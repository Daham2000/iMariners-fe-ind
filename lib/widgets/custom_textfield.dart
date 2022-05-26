import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final Icon icon;
  final TextEditingController textEditingController;

  const CustomTextField(
      {Key? key,
      required this.text,
      required this.icon,
      required this.textEditingController})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.86,
      child: TextField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
            prefixIcon: widget.icon,
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(50.0),
            ),
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: widget.text,
            fillColor: Colors.white70),
      ),
    );
  }
}
