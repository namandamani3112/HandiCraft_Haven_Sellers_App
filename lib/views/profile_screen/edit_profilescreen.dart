import 'package:get/get.dart';
import 'package:sellersapp/controllers/profile_controller.dart';
import 'package:sellersapp/views/widgets/custom_textfield.dart';
import 'package:sellersapp/views/widgets/loading_indicator.dart';
import 'dart:io';
import '../../const/const.dart';
import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key,this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(()=> Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value ? loadingIndicator() : TextButton(onPressed: () async{
              controller.isLoading(true);
              // //if image is not selected
              if (controller.profileImgPath.isNotEmpty) {
                await controller.uploadprofileImage();
              } else {
                controller.profileImgLink = controller.snapshotData['imgUrl'];
              }
              //if old matches database
              if (controller.snapshotData['password'] ==
                  controller.oldpassController.text) {
                await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password: controller.oldpassController.text,
                  newpassword: controller.newpassController.text,
                );
                await controller.updateProfile(
                  name: controller.nameController.text,
                  password: controller.newpassController.text,
                  imgUrl: controller.profileImgLink,
                );
                VxToast.show(context, msg: "Updated");
              }
              else if(controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull) {
                await controller.updateProfile(
                  name: controller.nameController.text,
                  password: controller.snapshotData['password'] ,
                  imgUrl: controller.profileImgLink,
                );
                VxToast.show(context, msg: "Updated");
              }
              else {
                VxToast.show(context, msg: "Some error occured");
                controller.isLoading(false);
              }
            }, child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
              Column(
              children: [
                controller.snapshotData['imgUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                    : controller.snapshotData['imgUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                  controller.snapshotData['imgUrl'],
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                  File(controller.profileImgPath.value),
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                // Image.asset(imgProduct,width: 150).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                ),onPressed: (){
                  controller.changeImage(context);
                }, child: normalText(text: changeImage, color: fontGrey),
                ),
                10.heightBox,
                const Divider(color: white),
                customTextField(label: name, hint: "eg. Naman Damani", controller: controller.nameController),
                30.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: boldText(text: "Change Your Password")),
                10.heightBox,
                customTextField(label: password,hint: passwordHint, controller: controller.oldpassController ),
                10.heightBox,
                customTextField(label: confirmPass, hint: passwordHint, controller: controller.newpassController),
              ],
            ),

        ),
      ),
    );
  }
}
