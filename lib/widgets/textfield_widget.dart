import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {

  const TextFieldWidget({
    Key? key,
    required this.maxLines,
    required this.label,
    required this.text,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> validator;
  final ValueChanged<String> onSaved;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

   // TextEditingController? controller;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   controller = TextEditingController(text: widget.text);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   controller?.dispose();
  // }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: widget.text,
          // controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: widget.maxLines,
        ),
      ],
    ),
  );
}
