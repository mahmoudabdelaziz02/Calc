import 'package:flutter/material.dart';

String symbols ="" ;
num(String symbols) {
    return InkWell(
      onTap:press,
      child: Container(
              width: 62,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Color.fromARGB(255, 48, 49, 54),
                boxShadow: [
                  BoxShadow(
                    // Color.fromARGB(255, 48, 49, 54),
                    blurRadius: 25,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                  child: Text(
                symbols,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
    );
  }


void press() {
}
