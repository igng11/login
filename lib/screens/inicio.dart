import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
const Inicio ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text('Inicio', style: TextStyle(color: Colors.white, fontSize: 48, letterSpacing: 2)),
     ),
   );
  }
}