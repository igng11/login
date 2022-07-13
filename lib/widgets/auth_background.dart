import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
const AuthBackground ({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
            const _GreenBackground(),
            const _HeaderIcon(),
            child,
           ],
    ));
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
    child: Padding(
      padding: EdgeInsets.only(top: 50),
      child: SizedBox(
       width: double.infinity,
       child: Icon(Icons.account_box_rounded, size: 170, color: Colors.white,),
      ),
    ),
           );
  }
}

class _GreenBackground extends StatelessWidget {
  const _GreenBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      // height: size.height * 0.8,
      decoration: _grandientBox(),
    );
  }

  BoxDecoration _grandientBox() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
      Color.fromARGB(255, 36, 105, 139),
      Color.fromARGB(255, 255, 255, 255),
    ])
  );
}