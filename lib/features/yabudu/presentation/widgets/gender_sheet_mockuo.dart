import 'package:flutter/material.dart';

class GenderSheet extends StatefulWidget {
  @override
  State<GenderSheet> createState() => _GenderSheetState();
}

class _GenderSheetState extends State<GenderSheet> {
  String gender = 'male';

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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 26),

          RadioListTile<String>(
            value: 'Мужской',
            groupValue: gender,
            title: const Text('Мужской'),
            onChanged: (v) => setState(() => gender = v!),
          ),
          RadioListTile<String>(
            value: 'Женский',
            groupValue: gender,
            title: const Text('Женский'),
            onChanged: (v) => setState(() => gender = v!),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, gender);
            },
            child: const Text('Выбрать'),
          ),
        ],
      ),
    );
  }
}