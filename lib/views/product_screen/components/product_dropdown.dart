import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sellersapp/const/const.dart';
import 'package:sellersapp/controllers/products_controller.dart';
import 'package:sellersapp/views/widgets/text_style.dart';

Widget productDropdown(hint,List<String> list, dropvalue, ProductsController controller) {
  return Obx(()=> DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: normalText(text: "$hint", color: fontGrey),
            value: dropvalue.value=='' ? null : dropvalue.value,
            isExpanded: true,

            items: list.map((e){
              return DropdownMenuItem(
                value: e,
                child: e.toString().text.make(),
              );
            }).toList(),
            onChanged: (newValue) {
              if (hint=="Category"){
                controller.subcategoryvalue.value = '';
                controller.populateSubcategory(newValue.toString());

              }
              dropvalue.value = newValue.toString();
            }
        ),
    ).box.white.roundedSM.padding(const EdgeInsets.symmetric(horizontal: 4)).make(),
  );
}