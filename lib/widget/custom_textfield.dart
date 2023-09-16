import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_storage/constant/appsize.dart';

class ShopWidget extends AppSize {
  Widget textfieldWidget(
      {TextEditingController? controller,
      String? hintText,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: s60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 199, 197, 197),
          borderRadius: BorderRadius.circular(s10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Center(
            child: TextField(
              controller: controller,
              cursorHeight: 20,
              keyboardType: keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: hintText ?? 'Enter-text'),
            ),
          ),
        ),
      ),
    );
  }
}
