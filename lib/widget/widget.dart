import 'package:flutter/material.dart';

Widget logo() {
  return CircleAvatar(
    radius: 30.0,
    backgroundColor: Colors.lightBlue.shade500,
    foregroundColor: Colors.white,
    child: const Icon(
      Icons.bungalow_outlined,
      size: 50,
    ),
  );
}
