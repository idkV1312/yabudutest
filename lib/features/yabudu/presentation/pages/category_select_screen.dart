import 'package:flutter/material.dart';
import 'package:yabudu/services/api_service.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> baseItems = [
    'Концерт',
    'Театр',
    'Детям',
    'Стендап',
    'Спорт',
    'Кино',
    'Танцы',
    'Мода',
    'Квест',
    'Экскурсия',
    'Обучение',
  ];

  final List<String> extraItems = [
    'IT / \nТехнологии',
    'Аниме / \nКосплей',
    'Благотвори-\nтельность',
    'Бизнес',
    'Вечеринка',
    'Встреча',
    'Гастрономия',
    'Игры',
    'Йога / \nмедитация',
    'Квартирник',
    'Конференция',
    'Культура',
    'Лекции',
    'Мастер-\nкласс',
  ];

  final Set<String> selected = {};
  bool expanded = false;

  final Map<String, String> icons = {
    'Концерт': 'assets/images/speaker.png',
    'Театр': 'assets/images/theater.png',
    'Детям': 'assets/images/baby.png',
    'Стендап': 'assets/images/mic.png',
    'Спорт': 'assets/images/fitness_center.png',
    'Кино': 'assets/images/film.png',
    'Танцы': 'assets/images/dancing.png',
    'Мода': 'assets/images/coat-hanger.png',
    'Квест': 'assets/images/search.png',
    'Экскурсия': 'assets/images/explore.png',
    'Обучение': 'assets/images/school.png',
    'IT / \nТехнологии': 'assets/images/it.png',
    'Аниме / \nКосплей': 'assets/images/anime.png',
    'Благотвори-\nтельность': 'assets/images/charity.png',
    'Бизнес': 'assets/images/business_center.png',
    'Вечеринка': 'assets/images/party.png',
    'Встреча': 'assets/images/group.png',
    'Гастрономия': 'assets/images/restaurant.png',
    'Игры': 'assets/images/casino.png',
    'Йога / \nмедитация': 'assets/images/self_improvement.png',
    'Квартирник': 'assets/images/kvartirnik.png',
    'Конференция': 'assets/images/conf.png',
    'Культура': 'assets/images/culture.png',
    'Лекции': 'assets/images/atom.png',
    'Мастер-\nкласс': 'assets/images/master_class.png',
  };

  final double baseWidth = 430.66;
  final double baseHeight = 932.0;

  double scaleW(BuildContext context, double size) =>
      MediaQuery.of(context).size.width / baseWidth * size;

  double scaleH(BuildContext context, double size) =>
      MediaQuery.of(context).size.height / baseHeight * size;

  List<String> get visibleItems =>
      expanded ? [...baseItems, ...extraItems] : baseItems;

  @override
  Widget build(BuildContext context) {
    final itemSize = scaleW(context, 117.05);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(scaleW(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Что вам нравится?',
                style: TextStyle(
                  fontSize: scaleW(context, 24),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'FindSansPro',
                ),
              ),
              SizedBox(height: scaleH(context, 12)),
              Text(
                'Поделитесь ответами, а мы подберём \n события специально для вас.\n Это займёт меньше минуты',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: scaleW(context, 14),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'FindSansPro',
                ),
              ),
              SizedBox(height: scaleH(context, 24)),

              /// GRID
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: scaleW(context, 13.25),
                    runSpacing: scaleH(context, 11.04),
                    children: [
                      ...visibleItems.map((item) {
                        final isSelected = selected.contains(item);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selected.remove(item);
                              } else {
                                selected.add(item);
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: itemSize,
                            height: itemSize,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2F33F9)
                                  : const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(
                                scaleW(context, 16),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  icons[item] ?? 'assets/images/default.png',
                                  width: scaleW(context, 32),
                                  height: scaleW(context, 32),
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(height: scaleH(context, 8)),
                                Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: scaleW(context, 12),
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'FindSansPro',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      /// КНОПКА "ДАЛЕЕ"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            expanded = !expanded;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: itemSize,
                          height: itemSize,
                          decoration: BoxDecoration(
                            color: expanded
                                ? const Color(0xFF2F33F9)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(
                              scaleW(context, 16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/trending_up.png',
                                width: scaleW(context, 32),
                                height: scaleW(context, 32),
                                color: expanded ? Colors.white : Colors.black,
                              ),
                              SizedBox(height: scaleH(context, 8)),
                              Text(
                                'Далее',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: scaleW(context, 12),
                                  color: expanded ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (selected.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: scaleH(context, 12)),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selected.isEmpty) return;

                        final api = ApiService();

                        final success = await api.savePreferences(
                          selected.toList() /*, token: token */,
                        );

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Предпочтения сохранены!'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Не удалось сохранить. Попробуйте позже.',
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F33F9),
                        padding: EdgeInsets.symmetric(
                          vertical: scaleH(context, 14),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        'Продолжить',
                        style: TextStyle(
                          fontSize: scaleW(context, 14),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'FindSansPro',
                        ),
                      ),
                    ),
                  ),
                ),

              /// "В ДРУГОЙ РАЗ"
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    print(selected.toList());
                  },
                  child: Text(
                    'В другой раз',
                    style: TextStyle(
                      fontSize: scaleW(context, 14),
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'FindSansPro',
                    ),
                  ),
                ),
              ),

              SizedBox(height: scaleH(context, 20)),
            ],
          ),
        ),
      ),
    );
  }
}
