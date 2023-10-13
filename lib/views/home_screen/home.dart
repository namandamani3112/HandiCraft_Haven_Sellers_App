import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellersapp/const/const.dart';
import 'package:sellersapp/controllers/home_controller.dart';
import 'package:sellersapp/views/home_screen/home_screen.dart';
import 'package:sellersapp/views/order_screen/orders_screen.dart';
import 'package:sellersapp/views/product_screen/products_screen.dart';
import 'package:sellersapp/views/profile_screen/profile_screen.dart';
import 'package:sellersapp/views/widgets/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(), const ProductsScreen(), const OrderScreen(), const ProfileScreen()
    ];

    var bottomNavbar  = [
       const BottomNavigationBarItem(
        icon: Icon(Icons.home),label: dashboard
      ),
       BottomNavigationBarItem(
        icon: Image.asset(icProducts,color: darkGrey,width: 24 ,), label: products
      ),
       BottomNavigationBarItem(
        icon: Image.asset(icOrders, width: 24, color: darkGrey), label: orders,
      ),
       BottomNavigationBarItem(
        icon: Image.asset(icGeneralSettings,width: 24, color: darkGrey), label: setting
      ),

    ];
    return Scaffold(
      bottomNavigationBar: Obx(
          () => BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
            currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed ,
          selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar,
          ),
      ),
      body: Obx(()=>Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value)),
          ],
        ),
      ),
    );
  }
}
