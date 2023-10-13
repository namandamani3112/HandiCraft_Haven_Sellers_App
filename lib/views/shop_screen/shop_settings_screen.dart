import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellersapp/controllers/profile_controller.dart';
import 'package:sellersapp/views/widgets/custom_textfield.dart';
import 'package:sellersapp/views/widgets/loading_indicator.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});


  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSetting, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopAddressController.text,
                        shopname: controller.shopNameController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopdesc: controller.shopDescController.text,
                      );
                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  label: shopname,
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextField(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(
                  isDesc: true,
                  label: description,
                  hint: shopDescHint,
                  controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
