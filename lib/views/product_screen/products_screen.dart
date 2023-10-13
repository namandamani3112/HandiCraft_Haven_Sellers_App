import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellersapp/controllers/products_controller.dart';
import 'package:sellersapp/services/store_services.dart';
import 'package:sellersapp/views/product_screen/add_product.dart';
import 'package:sellersapp/views/product_screen/products_details.dart';
import 'package:sellersapp/views/widgets/appbar.dart';
import 'package:sellersapp/views/widgets/loading_indicator.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';
import "package:intl/intl.dart" as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () async{
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(()=>const AddProduct());
          }, child: const Icon(Icons.add)),
      appBar: appbar(products),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return loadingIndicator();
            }
            else{

              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length , (index) => ListTile(
                      onTap: (){
                        Get.to(()=> ProductsDetails(data: data[index]));
                      },
                      leading: Image.network(data[index]['p_imgs'][0], width: 100, height: 100, fit: BoxFit.cover),
                      title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                      subtitle: Row(
                        children: [
                          normalText(text: "\$${data[index]['p_price']}",color: darkGrey),
                          10.widthBox,
                          boldText(text: data[index]['is_featured'] == true ? "Featured" : "", color: green),
                        ],
                      ),
                      trailing: VxPopupMenu(menuBuilder: ()=>Column(
                        children: List.generate(popupMenuIcons.length, (i) => Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                  popupMenuIcons[i],
                                color: data[index]['featured_id'] == currentUser!.uid && i==0 ? Colors.green : darkGrey,
                              ),
                              10.widthBox,
                              normalText(text: data[index]['featured_id'] == currentUser!.uid && i==0 ? 'Remove feature' : popupMenuTitles[i], color: darkGrey)

                            ],
                          ).onTap(() {
                            switch (i) {
                              case 0:
                                if (data[index]['is_featured']==true){
                                  controller.removeFeatured(data[index].id);
                                  VxToast.show(context, msg: "Removed");
                                }
                                else{
                                  controller.addFeatured(data[index].id);
                                  VxToast.show(context, msg: "Added");
                                }
                                break;
                              case 1:
                                break;
                              case 2:
                                controller.removeProduct(data[index].id);
                                VxToast.show(context, msg: "Product Removed");
                                break;
                              default:
                            }
                          }),
                        ),
                        ),
                      ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick, child: const Icon(Icons.more_vert_rounded)),
                    ),
                    ),
                  ),
                ),
              );
            }
        },
      ),
    );
  }
}
