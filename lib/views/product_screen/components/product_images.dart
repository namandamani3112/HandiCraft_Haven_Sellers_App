import 'package:flutter/cupertino.dart';
import 'package:sellersapp/const/colors.dart';
import 'package:sellersapp/const/const.dart';
import 'package:sellersapp/views/widgets/text_style.dart';

Widget productImages({required label, onPress}) {
  return "$label".text.bold.color(fontGrey).size(16.0).makeCentered().box.color(lightGrey).size(100, 100).roundedSM.make();
}