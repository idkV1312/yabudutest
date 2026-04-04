import 'package:flutter/material.dart';

class GenderSheet extends StatefulWidget {
  final String? initialGender;

  const GenderSheet({super.key, this.initialGender});

  @override
  State<GenderSheet> createState() => _GenderSheetState();
}

class _GenderSheetState extends State<GenderSheet> {
  String? gender;

  @override
  void initState() {
    super.initState();
    gender = widget.initialGender; // <-- берем переданное значение
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
      decoration: const BoxDecoration(
        color: Color(0xFFECECEC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xFFC5C5C5),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Пол',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'FindSansPro',
            ),
          ),
          const SizedBox(height: 26),

          _buildTile('Мужской'),
          _buildTile('Женский'),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTile(String value) {
    final isSelected = gender == value;

    return InkWell(
      onTap: () {
        setState(() => gender = value);
        Navigator.pop(context, value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // КАСТОМНЫЙ КРУЖОК
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey,
                  width: 2,
                ),
                color: isSelected ? Colors.blue : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),

            const SizedBox(width: 12),

            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Monsterrat',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
