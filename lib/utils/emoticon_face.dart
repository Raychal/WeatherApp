import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {
  const EmoticonFace({Key? key, required this.emoticonFace}) : super(key: key);

  final String emoticonFace;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Center(
          child: Text(
            emoticonFace,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
      ),
    );
  }
}
