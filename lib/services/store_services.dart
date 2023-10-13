import 'package:sellersapp/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore.collection(vendorsCollections).where('id', isEqualTo: uid).get();
  }

  static getMessages(uid) {
    return firestore.collection(chatsCollections).where('toId', isEqualTo: uid).snapshots();
  }

  static getOrders(uid) {
    return firestore.collection(ordersCollections).where('vendors', arrayContains: uid).snapshots();
  }

  static getProducts(uid){
    return firestore.collection(productsCollections).where('vendor_id', isEqualTo: uid).snapshots();
  }



}