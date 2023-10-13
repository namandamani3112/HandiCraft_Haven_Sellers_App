import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellersapp/const/const.dart';
import 'package:sellersapp/controllers/auth_controller.dart';
import 'package:sellersapp/views/widgets/loading_indicator.dart';
import 'package:sellersapp/views/widgets/our_button.dart';
import 'package:sellersapp/views/widgets/text_style.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome,size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 70,
                    height: 70,
                  ).box.border(color: white).rounded.padding(const EdgeInsets.all(8)).make(),
                  10.widthBox,
                  boldText(text: appname,size: 20.0),
                ],
              ),
              40.heightBox,
              normalText(text: loginTo,size: 18.0,color: lightGrey),
              10.heightBox,
              Obx(()=>Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(Icons.email, color: purpleColor,),
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                          prefixIcon: Icon(Icons.lock, color: purpleColor),
                          border: InputBorder.none,
                          hintText: passwordHint,
                      ),
                    ),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword, color: purpleColor))),
                    20.heightBox,
                    SizedBox(
                      width : context.screenWidth - 100,
                      child: controller.isLoading.value ? loadingIndicator()
                          : ourButtom(
                        title: login,
                        onPress: () async{
                          controller.isLoading(true);
                          await controller.loginMethod(context: context).then((value) {
                            if (value !=null){
                              VxToast.show(context, msg: "Logged in");
                              controller.isLoading(false);
                              Get.offAll(() => const Home());
                            }
                            else{
                              controller.isLoading(false);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(8)).make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              Spacer(),
              boldText(text: credit),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
