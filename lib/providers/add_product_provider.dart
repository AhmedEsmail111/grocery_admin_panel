import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/models/product.dart';
import 'package:grocery_admin_panel/widgets/custom_snack_bar.dart';
import 'package:grocery_admin_panel/widgets/error_dialogue.dart';
import 'package:uuid/uuid.dart';

import '../consts/constants.dart';

class AddProductProvider with ChangeNotifier {
  final firebaseFireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? productTitle;
  double? productPrice;
  String productCategory = 'Vegetables';
  io.File? imageFile;
  Uint8List? webImage;
  int groupValue = 1;
  bool isPiece = false;
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  void saveProductTitle(String title) {
    productTitle = title;
    notifyListeners();
  }

  void saveProductPrice(double price) {
    productPrice = price;
    notifyListeners();
  }

  void saveProductCategory(String category) {
    productCategory = category;
    notifyListeners();
  }

  void saveProductImageFile(io.File image) {
    imageFile = image;
    notifyListeners();
  }

  void saveProductWebImage(Uint8List image) {
    webImage = image;
    notifyListeners();
  }

  void changeIsPiece(bool value) {
    isPiece = value;
    notifyListeners();
  }

  void changeGroupValue(int value) {
    groupValue = value;
    notifyListeners();
  }

  void clearImage() {
    imageFile = null;
    webImage = null;
    notifyListeners();
  }

// reset the form to its default values
  void clearForm() {
    imageFile = null;
    webImage = null;
    titleController.text = '';
    priceController.text = '';
    groupValue = 1;
    productCategory = 'Vegetables';

    notifyListeners();
  }

  Future<void> uploadProduct({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final String imageUrl;
    try {
      final uuid = const Uuid().v4();
      imageUrl = await uploadImageToStorage(uuid);

      final product = Product(
        id: uuid,
        title: productTitle!,
        productCategory: productCategory,
        imageUrl: imageUrl,
        price: productPrice!,
        salePrice: 0,
        isOnSale: false,
        isPiece: isPiece,
        createdAt: Timestamp.now().millisecondsSinceEpoch.toString(),
      );
      await firebaseFireStore.collection(productsCollection).doc(uuid).set(
            product.toJson(),
          );

      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: 'The product was uploaded successfully',
            backgroundColor: Colors.green,
            icon: Icons.done,
          ),
        );
      }
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.message ?? 'Firebase error occurred!',
          ),
        );
      }
      print(e.message.toString());
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => CustomErrorDialogue(
            contentText: e.toString(),
          ),
        );
      }
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  // upload the image to firebase firestore

  Future<String> uploadImageToStorage(String uuid) async {
    final String imageUrl;
    final storageRef = storage.ref().child(imagesFolder).child(uuid + 'jpg');

    if (kIsWeb) {
      await storageRef.putBlob(webImage);
      imageUrl = await storageRef.getDownloadURL();
    } else {
      await storageRef.putFile(imageFile!);
      imageUrl = await storageRef.getDownloadURL();
    }
    return imageUrl;
  }
}
