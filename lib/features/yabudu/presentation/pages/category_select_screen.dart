import 'package:flutter/material.dart';

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

  final List<String> extraItems = List.generate(15, (i) => 'Extra ${i + 1}');

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
    for (int i = 0; i < 15; i++)
      'Extra ${i + 1}': 'assets/images/default1.png',
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
                ),
              ),
              SizedBox(height: scaleH(context, 12)),
              Text(
                'Поделитесь ответами, а мы подберём \n события специально для вас.\n Это займёт меньше минуты',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: scaleW(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: scaleH(context, 24)),
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
                                  icons[item] ??
                                      'assets/images/default.png',
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
                                color: expanded
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(height: scaleH(context, 8)),
                              Text(
                                'Далее',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: scaleW(context, 12),
                                  color: expanded
                                      ? Colors.white
                                      : Colors.black,
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