import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String text;
  Icon icon;
  bool obscureText;
  TextEditingController textEditingController;

  CustomTextField(
      {Key? key,
      required this.text,
      required this.icon,
      required this.textEditingController,
      required this.obscureText})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.86,
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.obscureText,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: widget.icon,
            suffixIcon: widget.text == "Password"
                ? InkWell(
                    onTap: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    child: Icon(Icons.remove_red_eye),
                  )
                : Container(
                    width: 10,
                  ),
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
