import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({super.key,this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 163, 160, 159),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
