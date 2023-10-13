import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellersapp/const/colors.dart';

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(red),
    ),
  );
}