import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

const vendorsCollections = "vendors";
const productsCollections = "products";
const chatsCollections = "chats";
const messagesCollections = "messages";
const ordersCollections = "orders";




