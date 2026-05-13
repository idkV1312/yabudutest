import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'yabudu_event.dart';
part 'yabudu_state.dart';

class YabuduBloc extends Bloc<YabuduEvent, YabuduState> {
  YabuduBloc() : super(YabuduInitial()) {
    on<YabuduEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
