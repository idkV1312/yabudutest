import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:yabudu/features/auth/data/pkce.dart';

abstract class TokenStore {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
}

class SecureTokenStore implements TokenStore {
  SecureTokenStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }
}

class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    this.idToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
  });

  final String accessToken;
  final String? idToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class CreateSessionResult {
  const CreateSessionResult({
    required this.sessionId,
    required this.authRequestId,
    required this.verificationCode,
    required this.responseBody,
  });

  final String sessionId;
  final String authRequestId;
  final String verificationCode;
  final String responseBody;
}

class AuthService {
  AuthService({http.Client? httpClient, TokenStore? tokenStore})
    : _httpClient = httpClient ?? http.Client(),
      _tokenStore = tokenStore ?? SecureTokenStore();

  final http.Client _httpClient;
  final TokenStore _tokenStore;

  static const String _backendBaseUrl = 'https://develop.yabudu.club';
  static const String _authHost = 'auth-develop.yabudu.club';
  static const String _tokenPath = '/oauth/v2/token';

  static const String clientId = String.fromEnvironment(
    'OAUTH_CLIENT_ID',
    defaultValue: '368263087813296502',
  );
  static const String egl = String.fromEnvironment(
    'OAUTH_EGL',
    defaultValue: '',
  );

  static const String redirectUri = String.fromEnvironment(
    'OAUTH_REDIRECT_URI',
    defaultValue: 'myapp://callback',
  );

  static const String accessTokenKey = 'access_token';
  static const String idTokenKey = 'id_token';
  static const String refreshTokenKey = 'refresh_token';

  static Uri get tokenEndpoint => Uri.https(_authHost, _tokenPath);
  static Uri get authorizeEndpoint =>
      Uri.https(_authHost, '/oauth/v2/authorize');

  Future<String> fetchAuthRequestId() async {
    final state = PKCE.generateVerifier();
    final uri = authorizeEndpoint.replace(
      queryParameters: <String, String>{
        'redirect_uri': redirectUri,
        'response_type': 'code',
        'response_mode': 'fragment',
        'client_id': clientId,
        'scope': 'openid profile email phone offline_access',
        'state': state,
        if (egl.isNotEmpty) 'egl': egl,
      },
    );

    final callback = await FlutterWebAuth2.authenticate(
      url: uri.toString(),
      callbackUrlScheme: Uri.parse(redirectUri).scheme,
      options: const FlutterWebAuth2Options(preferEphemeral: true),
    );
    debugPrint('[AuthService] fetchAuthRequestId callback raw: $callback');
    if (!callback.startsWith(redirectUri)) {
      throw AuthException(
        'Unexpected callback URI. Expected prefix: $redirectUri, got: $callback',
      );
    }

    final callbackUri = Uri.parse(callback);
    debugPrint(
      '[AuthService] fetchAuthRequestId query: ${callbackUri.queryParameters}',
    );

    Map<String, String> fragmentParams = <String, String>{};
    if (callbackUri.fragment.isNotEmpty) {
      try {
        fragmentParams = Uri.splitQueryString(callbackUri.fragment);
      } catch (_) {
        debugPrint(
          '[AuthService] fetchAuthRequestId fragment parse failed: ${callbackUri.fragment}',
        );
      }
    }
    debugPrint('[AuthService] fetchAuthRequestId fragment: $fragmentParams');

    final authRequest =
        callbackUri.queryParameters['authRequest'] ??
        callbackUri.queryParameters['auth_request'] ??
        callbackUri.queryParameters['authRequestId'] ??
        fragmentParams['authRequest'] ??
        fragmentParams['auth_request'] ??
        fragmentParams['authRequestId'];

    if (authRequest == null || authRequest.isEmpty) {
      throw AuthException('authRequestId not found in callback URL: $callback');
    }
    debugPrint('[AuthService] fetchAuthRequestId parsed: $authRequest');

    return authRequest;
  }

  Future<String> fetchAuthRequestIdFromAuthorizeHtml() async {
    final state = PKCE.generateVerifier();
    final uri = authorizeEndpoint.replace(
      queryParameters: <String, String>{
        'redirect_uri': redirectUri,
        'response_type': 'code',
        'response_mode': 'query',
        'client_id': clientId,
        'scope': 'openid profile email phone offline_access',
        'state': state,
        if (egl.isNotEmpty) 'egl': egl,
      },
    );

    debugPrint('[AuthService] debug authorize URL: $uri');

    final client = HttpClient();
    try {
      final request = await client.getUrl(uri);
      request.followRedirects = false;
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      final location = response.headers.value(HttpHeaders.locationHeader);

      debugPrint(
        '[AuthService] debug authorize status: ${response.statusCode}',
      );
      debugPrint('[AuthService] debug authorize location: $location');
      debugPrint(
        '[AuthService] debug authorize body (first 1000): ${body.length > 1000 ? body.substring(0, 1000) : body}',
      );

      final fromLocation = _extractAuthRequestFromText(location ?? '');
      if (fromLocation != null && fromLocation.isNotEmpty) {
        debugPrint(
          '[AuthService] debug authRequest from location: $fromLocation',
        );
        return fromLocation;
      }

      final fromBody = _extractAuthRequestFromText(body);
      if (fromBody != null && fromBody.isNotEmpty) {
        debugPrint('[AuthService] debug authRequest from body: $fromBody');
        return fromBody;
      }

      throw const AuthException('authRequestId not found in location/body.');
    } finally {
      client.close(force: true);
    }
  }

  Future<CreateSessionResult> startPhoneSession(
    String login, {
    String? authRequestId,
  }) async {
    return _startSession(
      login: login,
      channelPath: 'phone',
      authRequestId: authRequestId,
    );
  }

  Future<CreateSessionResult> startEmailSession(
    String login, {
    String? authRequestId,
  }) async {
    return _startSession(
      login: login,
      channelPath: 'email',
      authRequestId: authRequestId,
    );
  }

  Future<CreateSessionResult> _startSession({
    required String login,
    required String channelPath,
    String? authRequestId,
  }) async {
    final normalizedLogin = login.trim();
    if (normalizedLogin.isEmpty) {
      throw const AuthException('Введите телефон или email.');
    }

    final normalizedAuthRequestId = authRequestId?.trim();
    final response = await _httpClient.post(
      Uri.parse('$_backendBaseUrl/api/v1/sessions/$channelPath'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String?>{
        'login': normalizedLogin,
        'authRequestId': normalizedAuthRequestId?.isEmpty == true
            ? null
            : normalizedAuthRequestId,
      }),
    );
    debugPrint(
      '[AuthService] POST /api/v1/sessions/$channelPath -> ${response.statusCode} ${response.body}',
    );

    final body = _safeJsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = _extractErrorMessage(body) ?? response.body;
      throw AuthException('Не удалось создать сессию: $message');
    }

    final sessionId = body['sessionId'] as String?;
    final responseAuthRequestId =
        (body['authRequestId'] as String?) ?? (body['code'] as String?);
    final verificationCode = body['code'] as String?;
    if (sessionId == null || sessionId.isEmpty) {
      throw const AuthException('Backend не вернул sessionId.');
    }
    if (responseAuthRequestId == null || responseAuthRequestId.isEmpty) {
      throw const AuthException('Backend не вернул authRequestId (code).');
    }
    if (verificationCode == null || verificationCode.isEmpty) {
      throw const AuthException('Backend не вернул verification code.');
    }

    return CreateSessionResult(
      sessionId: sessionId,
      authRequestId: responseAuthRequestId,
      verificationCode: verificationCode,
      responseBody: response.body,
    );
  }

  Future<AuthTokens> confirmPhoneSession({
    required String sessionId,
    required String authRequestId,
    required String smsCode,
  }) async {
    return _confirmSession(
      sessionId: sessionId,
      authRequestId: authRequestId,
      code: smsCode,
      channelPath: 'phone',
    );
  }

  Future<AuthTokens> confirmEmailSession({
    required String sessionId,
    required String authRequestId,
    required String code,
  }) async {
    return _confirmSession(
      sessionId: sessionId,
      authRequestId: authRequestId,
      code: code,
      channelPath: 'email',
    );
  }

  Future<AuthTokens> _confirmSession({
    required String sessionId,
    required String authRequestId,
    required String code,
    required String channelPath,
  }) async {
    final normalizedCode = code.trim();
    if (normalizedCode.isEmpty) {
      throw const AuthException('Введите код подтверждения.');
    }

    final patchResponse = await _httpClient.patch(
      Uri.parse('$_backendBaseUrl/api/v1/sessions/$channelPath'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: () {
        final payload = <String, String>{
          'sessionId': sessionId,
          'authRequestId': authRequestId,
          'code': normalizedCode,
        };
        debugPrint(
          '[AuthService] PATCH /api/v1/sessions/$channelPath request body: ${jsonEncode(payload)}',
        );
        return jsonEncode(payload);
      }(),
    );
    debugPrint(
      '[AuthService] PATCH /api/v1/sessions/$channelPath -> ${patchResponse.statusCode} ${patchResponse.body}',
    );

    if (patchResponse.statusCode < 200 || patchResponse.statusCode >= 300) {
      final body = _safeJsonDecode(patchResponse.body);
      final message = _extractErrorMessage(body) ?? patchResponse.body;
      throw AuthException('Не удалось подтвердить сессию: $message');
    }

    final callbackUrl = _readCallbackUrlFromBody(patchResponse.body);
    if (callbackUrl == null || callbackUrl.isEmpty) {
      throw const AuthException('Backend не вернул callback URL.');
    }

    final callbackUri = Uri.parse(callbackUrl);
    final directAccessToken = _readParamFromUri(callbackUri, 'access_token');
    if (directAccessToken != null && directAccessToken.isNotEmpty) {
      final tokens = AuthTokens(accessToken: directAccessToken);
      await _persistTokens(tokens);
      return tokens;
    }

    final authCode = _readParamFromUri(callbackUri, 'code');
    if (authCode == null || authCode.isEmpty) {
      throw const AuthException(
        'Callback не содержит access_token или code для обмена.',
      );
    }

    final tokenResponse = await _httpClient.post(
      tokenEndpoint,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'code': authCode,
        'redirect_uri': redirectUri,
      },
    );
    debugPrint(
      '[AuthService] POST /oauth/v2/token -> ${tokenResponse.statusCode} ${tokenResponse.body}',
    );

    final body = _safeJsonDecode(tokenResponse.body);

    if (tokenResponse.statusCode < 200 || tokenResponse.statusCode >= 300) {
      final message = _extractErrorMessage(body) ?? tokenResponse.body;
      throw AuthException('Не удалось обменять code на token: $message');
    }

    final accessToken = body['access_token'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      throw const AuthException('Token endpoint не вернул access_token.');
    }

    final tokens = AuthTokens(
      accessToken: accessToken,
      idToken: body['id_token'] as String?,
      refreshToken: body['refresh_token'] as String?,
      tokenType: body['token_type'] as String?,
      expiresIn: _tryParseInt(body['expires_in']),
    );

    await _persistTokens(tokens);
    return tokens;
  }

  Future<AuthTokens> signInWithSystemAuthSession() async {
    final verifier = PKCE.generateVerifier();
    final challenge = PKCE.generateChallenge(verifier);
    final state = PKCE.generateVerifier();

    final authorizeUri =
        Uri.https(_authHost, '/oauth/v2/authorize', <String, String>{
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'response_type': 'code',
          'scope': 'openid profile email phone offline_access',
          'code_challenge': challenge,
          'code_challenge_method': 'S256',
          'state': state,
          if (egl.isNotEmpty) 'egl': egl,
        });

    final callback = await FlutterWebAuth2.authenticate(
      url: authorizeUri.toString(),
      callbackUrlScheme: Uri.parse(redirectUri).scheme,
      options: const FlutterWebAuth2Options(preferEphemeral: true),
    );
    debugPrint('[AuthService] system auth callback raw: $callback');
    if (!callback.startsWith(redirectUri)) {
      throw AuthException(
        'Unexpected callback URI. Expected prefix: $redirectUri, got: $callback',
      );
    }

    final callbackUri = Uri.parse(callback);
    final callbackState = callbackUri.queryParameters['state'];
    if (callbackState != state) {
      throw const AuthException('Invalid OAuth state.');
    }

    final authCode = callbackUri.queryParameters['code'];
    if (authCode == null || authCode.isEmpty) {
      final error = callbackUri.queryParameters['error'] ?? 'no_code';
      throw AuthException('Authorize failed: $error');
    }

    final tokenResponse = await _httpClient.post(
      tokenEndpoint,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'code': authCode,
        'redirect_uri': redirectUri,
        'code_verifier': verifier,
      },
    );
    debugPrint(
      '[AuthService] POST /oauth/v2/token (system auth) -> ${tokenResponse.statusCode} ${tokenResponse.body}',
    );

    final body = _safeJsonDecode(tokenResponse.body);
    if (tokenResponse.statusCode < 200 || tokenResponse.statusCode >= 300) {
      final message = _extractErrorMessage(body) ?? tokenResponse.body;
      throw AuthException('Token exchange failed: $message');
    }

    final accessToken = body['access_token'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      throw const AuthException('Token endpoint did not return access_token.');
    }

    final tokens = AuthTokens(
      accessToken: accessToken,
      idToken: body['id_token'] as String?,
      refreshToken: body['refresh_token'] as String?,
      tokenType: body['token_type'] as String?,
      expiresIn: _tryParseInt(body['expires_in']),
    );
    await _persistTokens(tokens);
    return tokens;
  }

  Future<String?> readAccessToken() {
    return _tokenStore.read(accessTokenKey);
  }

  Future<Map<String, String>> buildAuthHeaders() async {
    final token = await readAccessToken();
    if (token == null || token.isEmpty) {
      throw const AuthException('Access token is missing.');
    }
    return <String, String>{
      'Authorization': 'Bearer $token',
      'Accept': 'application/json, text/plain',
    };
  }

  Future<String> getProtectedUsers() async {
    final headers = await buildAuthHeaders();
    final response = await _httpClient.get(
      Uri.parse('$_backendBaseUrl/api/v1/users'),
      headers: headers,
    );
    debugPrint(
      '[AuthService] GET /api/v1/users -> ${response.statusCode} ${response.body}',
    );
    return response.body;
  }

  Future<void> _persistTokens(AuthTokens tokens) async {
    await _tokenStore.write(accessTokenKey, tokens.accessToken);

    if (tokens.idToken != null && tokens.idToken!.isNotEmpty) {
      await _tokenStore.write(idTokenKey, tokens.idToken!);
    }

    if (tokens.refreshToken != null && tokens.refreshToken!.isNotEmpty) {
      await _tokenStore.write(refreshTokenKey, tokens.refreshToken!);
    }
  }

  static String? _readCallbackUrlFromBody(String rawBody) {
    final raw = rawBody.trim();
    if (raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is String) {
        return decoded;
      }
      if (decoded is Map<String, dynamic>) {
        final value = decoded['callbackUrl'];
        if (value is String) {
          return value;
        }
      }
    } catch (_) {
      // Ignore and try plain string below.
    }

    return raw;
  }

  static String? _readParamFromUri(Uri uri, String key) {
    final queryValue = uri.queryParameters[key];
    if (queryValue != null && queryValue.isNotEmpty) {
      return queryValue;
    }

    final fragment = uri.fragment;
    if (fragment.isNotEmpty) {
      try {
        final fragmentParams = Uri.splitQueryString(fragment);
        final fragmentValue = fragmentParams[key];
        if (fragmentValue != null && fragmentValue.isNotEmpty) {
          return fragmentValue;
        }
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  static String? _extractAuthRequestFromText(String text) {
    final match = RegExp(
      r'authRequest=([A-Za-z0-9_\-\.]+)',
      caseSensitive: false,
    ).firstMatch(text);
    return match?.group(1);
  }

  static Map<String, dynamic> _safeJsonDecode(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  static String? _extractErrorMessage(Map<String, dynamic> json) {
    final fromDescription = json['error_description'];
    if (fromDescription is String && fromDescription.isNotEmpty) {
      return fromDescription;
    }

    final fromError = json['error'];
    if (fromError is String && fromError.isNotEmpty) {
      return fromError;
    }

    return null;
  }

  static int? _tryParseInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  @visibleForTesting
  static String decodeError(Map<String, dynamic> json) {
    return _extractErrorMessage(json) ?? 'Unknown error';
  }
}
