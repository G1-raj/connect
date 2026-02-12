import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController textController;
  final double width;
  final double height;
  final String? Function(String?)? validator; 
  const InputField(
    {
      super.key,
      required this.hintText,
      required this.prefixIcon,
      this.isPassword = false,
      required this.textController,
      required this.width,
      required this.height,
      this.validator
    }
  );

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: widget.textController,
        obscureText: _obscureText,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
      
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off
            ),
          ): null,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey
            ),
          ),
      
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey
            ),
          ),
      
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey
            ),
          ),
      
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.red
            ),
          ),
        ),
      ),
    );
  }
}