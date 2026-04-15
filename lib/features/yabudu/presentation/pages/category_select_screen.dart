import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> items = [
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

  final Set<String> selected = {};

  final Map<String, String> icons = {
    'Концерт': 'assets/images/speaker.png',
    'Театр': 'assets/images/Theatre.png',
    'Детям': 'assets/images/Baby.png',
    'Стендап': 'assets/images/mic.png',
    'Спорт': 'assets/images/fitness_center.png',
    'Кино': 'assets/images/film.png',
    'Танцы': 'assets/images/dancing 1.png',
    'Мода': 'assets/images/coat-hanger.png',
    'Квест': 'assets/images/search.png',
    'Экскурсия': 'assets/images/explore.png',
    'Обучение': 'assets/images/school.png',
  };

  final double baseWidth = 430.66;
  final double baseHeight = 932.0;

  double scaleW(BuildContext context, double size) =>
      MediaQuery.of(context).size.width / baseWidth * size;

  double scaleH(BuildContext context, double size) =>
      MediaQuery.of(context).size.height / baseHeight * size;

  @override
  Widget build(BuildContext context) {
    final itemSize = scaleW(context, 117.05);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(scaleW(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                'Поделитесь ответами, а мы подберём \n события специально для вас.\n Это займёт меньше минуты',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: scaleW(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: scaleH(context, 24)),

              Expanded(
                child: Wrap(
                  spacing: scaleW(context, 13.25),
                  runSpacing: scaleH(context, 11.04),
                  children: items.map((item) {
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
                              color: isSelected ? Colors.white : Colors.grey,
                            ),

                            SizedBox(height: scaleH(context, 8)),

                            Text(
                              item,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: scaleW(context, 14),
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
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
                    style: TextStyle(fontSize: scaleW(context, 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
