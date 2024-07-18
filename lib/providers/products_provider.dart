import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/widgets/custom_snack_bar.dart';

import '../models/product.dart';
import '../screens/home/home_screen.dart';
import '../widgets/error_dialogue.dart';

class ProductsProvider with ChangeNotifier {
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateProduct(
      {required Product product,
      required BuildContext context,
      required dynamic image}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final String? newImageUrl =
          image != null ? await uploadImageToStorage(product.id, image) : null;

      await fireStore.collection(productsCollection).doc(product.id).update(
            newImageUrl != null
                ? product.toJsonWithNewImage(newImageUrl: newImageUrl)
                : product.toJson(),
          );
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: 'The product was updated successfully',
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

  Future<void> deleteProduct(
      {required String productId,
      required BuildContext context,
      bool inEdit = false}) async {
    try {
      _isLoading = true;
      notifyListeners();

      await fireStore.collection(productsCollection).doc(productId).delete();
      _isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          context: context,
          message: 'The product was deleted successfully',
          backgroundColor: Colors.green,
          icon: Icons.done,
        ),
      );
      if (inEdit && Navigator.canPop(context)) {
        Navigator.pop(context);
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
  // upload the new image to firebase firestore

  Future<String> uploadImageToStorage(String uuid, image) async {
    final String imageUrl;
    final storageRef = storage.ref().child(imagesFolder).child(uuid + 'jpg');

    if (kIsWeb) {
      await storageRef.putBlob(image);
      imageUrl = await storageRef.getDownloadURL();
    } else {
      await storageRef.putFile(image);
      imageUrl = await storageRef.getDownloadURL();
    }
    return imageUrl;
  }
}
