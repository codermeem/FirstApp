import 'package:flutter/material.dart';

Widget logo() {
  return CircleAvatar(
    radius: 60.0,
    backgroundColor: Colors.grey.shade100,
    foregroundColor: Colors.lightBlue.shade300,
    child: const Icon(
      Icons.bungalow_outlined,
      size: 100,
    ),
  );
}
