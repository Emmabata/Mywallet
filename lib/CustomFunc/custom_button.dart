import "package:flutter/material.dart";


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue, // Default color if none is provided
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text, style: textStyle),
    );
  }
}
