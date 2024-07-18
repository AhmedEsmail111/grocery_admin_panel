import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/controllers/menu_controller.dart';
import 'package:grocery_admin_panel/providers/add_product_provider.dart';
import 'package:grocery_admin_panel/screens/add_product/widgets/form_control_buttons.dart';
import 'package:grocery_admin_panel/screens/add_product/widgets/image_controll_buttons.dart';
import 'package:grocery_admin_panel/screens/add_product/widgets/image_upload_container.dart';
import 'package:grocery_admin_panel/screens/add_product/widgets/product_info_column.dart';
import 'package:grocery_admin_panel/widgets/custom_text_field.dart';
import 'package:grocery_admin_panel/widgets/error_dialogue.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/loading_manager.dart';
import 'package:grocery_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';
import '../../responsive.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = Utils(context).getScreenSize.width;
    final color = Utils(context).color;
    final addProductProvider = Provider.of<AddProductProvider>(context);
    return Scaffold(
      key: context.read<MenuControllerr>().getAddProductScaffoldKey,
      drawer: const SideMenu(),
      body: CustomLoadingManager(
        isLoading: addProductProvider.isLoading,
        child: SafeArea(
          child: Row(
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              Flexible(
                flex: 5,
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Header(
                        fct: context
                            .read<MenuControllerr>()
                            .controlAddProductsMenu,
                        title: 'Add Product',
                        withSearch: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                          defaultPadding,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product title*',
                                style: const TextStyle().copyWith(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: Responsive.isDesktop(context)
                                    ? width * 0.4
                                    : width * 0.7,
                                child: CustomTextField(
                                  controller:
                                      addProductProvider.titleController,
                                  hintText: '',
                                  textInputType: TextInputType.name,
                                  autovalidateMode: _autoValidateMode,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      _autoValidateMode =
                                          AutovalidateMode.always;

                                      return 'please enter the product title';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    context
                                        .read<AddProductProvider>()
                                        .saveProductTitle(value!);
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const ProductInfoColumn(),
                                  const SizedBox(
                                    width: defaultPadding,
                                  ),
                                  const Flexible(
                                    child: ImageUploadContainer(),
                                  ),
                                  const SizedBox(
                                    width: defaultPadding,
                                  ),
                                  ImageControllButtons(
                                    onClearTap: addProductProvider.clearImage,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              FormControlButtons(
                                onFormUpload: () {
                                  upload(addProductProvider);
                                },
                                onFormClear: addProductProvider.clearForm,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void upload(AddProductProvider addProductProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (addProductProvider.imageFile != null ||
          addProductProvider.webImage != null) {
        await addProductProvider.uploadProduct(context: context);

        addProductProvider.clearForm();
      } else {
        showDialog(
          context: context,
          builder: (_) => const CustomErrorDialogue(
              contentText: 'Please choose a product image!'),
        );
      }
    }
  }
}
