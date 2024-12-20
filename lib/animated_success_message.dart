import 'package:flutter/material.dart';

class AnimatedSuccessMessage extends StatefulWidget {
  const AnimatedSuccessMessage({super.key}); // Ensure key is included in public widget constructors

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedSuccessMessageState createState() => _AnimatedSuccessMessageState();
}

class _AnimatedSuccessMessageState extends State<AnimatedSuccessMessage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () { // Use 'const' with Duration
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 1), // Use 'const' with Duration
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12), // Use 'const' with EdgeInsets
          color: Colors.green,
          child: const Text(
            'Transaction Successful!',
            style: TextStyle(color: Colors.white, fontSize: 18), // Use 'const' with TextStyle
          ),
        ),
      ),
    );
  }
}
