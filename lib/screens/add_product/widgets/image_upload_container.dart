import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/providers/add_product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';

class ImageUploadContainer extends StatefulWidget {
  const ImageUploadContainer({Key? key}) : super(key: key);

  @override
  State<ImageUploadContainer> createState() => _ImageUploadContainerState();
}

class _ImageUploadContainerState extends State<ImageUploadContainer> {
  File? mobileImage;
  Uint8List? webImage;

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final addProductProvider = Provider.of<AddProductProvider>(context);
    return InkWell(
      onTap: () {
        chooseImage(addProductProvider);
      },
      child: Container(
        height: size.width < 900 ? size.width * 0.4 : size.width * 0.25,
        width: size.width < 900 ? size.width * 0.4 : size.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: addProductProvider.webImage != null ||
                addProductProvider.imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: kIsWeb
                    ? Image.memory(
                        addProductProvider.webImage!,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        addProductProvider.imageFile!,
                        fit: BoxFit.cover,
                      ),
              )
            : DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6.0, 5.0],
                borderPadding: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.photo_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        'Drag your image here or select',
                        style: const TextStyle().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await chooseImage(addProductProvider);
                        },
                        child: Text(
                          'Click to browse',
                          style: const TextStyle().copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  Future<void> chooseImage(AddProductProvider addProductProvider) async {
    final picker = ImagePicker();
    if (!kIsWeb) {
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.gallery);

      if (selectedImage != null) {
        // setState(() {
        //   mobileImage = File(selectedImage.path);
        // });

        addProductProvider.saveProductImageFile(File(selectedImage.path));
      } else {
        print('mobile image error');
      }
    } else if (kIsWeb) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final f = await image.readAsBytes();
        // setState(() {
        //   webImage = f;
        //   mobileImage = File('_');
        // });
        addProductProvider.saveProductWebImage(f);
      } else {
        print('web image error');
      }
    } else {
      print('something went wrong');
    }
  }
}
