import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphismDraftLayout extends StatelessWidget {
  const GlassmorphismDraftLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F10),
      body: SafeArea(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.564),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.367, sigmaY: 30.367),
              child: Container(
                width: 441.706,
                height: 883.412,
                padding: const EdgeInsets.fromLTRB(27.606, 27.606, 27.606, 27.606),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(212, 212, 212, 0.1),
                  borderRadius: BorderRadius.circular(16.564),
                  border: Border.all(
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                    width: 3.313,
                  ),
                ),
                child: Column(
                  children: const [
                    _TopImagePlaceholder(),
                    SizedBox(height: 21.79),
                    Text(
                      'Nouman Ejaz',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'FindSansPro',
                        fontWeight: FontWeight.w500,
                        fontSize: 39.754,
                        color: Color(0xFF262626),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Hi! I'm Nouman Ejaz, a passionate UI/UX designer dedicated to crafting immersive digital experiences. With a keen eye for aesthetics and functionality, I specialize in implementing cutting-edge design trends, including the captivating glassmorphism technique. My goal is to create interfaces that not only delight users visually but also enhance usability and interaction.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'FindSansPro',
                        fontWeight: FontWeight.w500,
                        fontSize: 17.668,
                        height: 1.36,
                        color: Color(0xFF404040),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '#nouman_ejaz',
                      style: TextStyle(
                        fontFamily: 'FindSansPro',
                        fontWeight: FontWeight.w500,
                        fontSize: 17.668,
                        color: Color(0xFF262626),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopImagePlaceholder extends StatelessWidget {
  const _TopImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 386.493,
      height: 386.493,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 217, 217, 0.5),
        borderRadius: BorderRadius.circular(16.564),
      ),
    );
  }
}
