import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_admin_panel/models/product.dart';
import 'package:grocery_admin_panel/providers/products_provider.dart';
import 'package:grocery_admin_panel/widgets/buttons.dart';
import 'package:grocery_admin_panel/widgets/custom_snack_bar.dart';
import 'package:grocery_admin_panel/widgets/loading_manager.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';
import '../../services/global_method.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  // Title and price controllers
  late final TextEditingController _titleController, _priceController;
  // Category
  late String _catValue;
  // Sale
  String _salePercent = '0';
  late String percToShow;
  late double _salePrice;
  late bool _isOnSale;
  // Image
  File? _pickedImage;
  Uint8List webImage = Uint8List(10);
  late String _imageUrl;
  // kg or Piece,
  late int val;
  late bool _isPiece;
  // while loading

  @override
  void initState() {
    // set the price and title initial values and initialize the controllers
    _priceController =
        TextEditingController(text: widget.product.price.toStringAsFixed(2));
    _titleController = TextEditingController(text: widget.product.title);
    // Set the variables
    _salePrice = widget.product.salePrice;
    _catValue = widget.product.productCategory;
    _isOnSale = widget.product.isOnSale;
    _isPiece = widget.product.isPiece;
    val = _isPiece ? 2 : 1;
    _imageUrl = widget.product.imageUrl;
    // Calculate the percentage
    percToShow = (100 -
                (_salePrice * 100) /
                    widget.product.price) // WIll be the price instead of 1.88
            .round()
            .toStringAsFixed(1) +
        '%';
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controllers
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final theme = Utils(context).getTheme;
    final color = theme == true ? Colors.white : Colors.black;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      // key: context.read<MenuControllerr>().getEditProductScaffoldKey,
      // drawer: const SideMenu(),
      body: CustomLoadingManager(
        isLoading: productsProvider.isLoading,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width > 650 ? 650 : size.width,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextWidget(
                          text: 'Product title*',
                          color: color,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _titleController,
                          key: const ValueKey('Title'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Title';
                            }
                            return null;
                          },
                          decoration: inputDecoration,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: 'Price in \$*',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        controller: _priceController,
                                        key: const ValueKey('Price \$'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Price is missed';
                                          }
                                          return null;
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9.]')),
                                        ],
                                        decoration: inputDecoration,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextWidget(
                                      text: 'Porduct category*',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      color: _scaffoldColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: catDropDownWidget(color),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextWidget(
                                      text: 'Measure unit*',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextWidget(text: 'Kg', color: color),
                                        Radio(
                                          value: 1,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val = 1;
                                              _isPiece = false;
                                            });
                                          },
                                          activeColor: Colors.green,
                                        ),
                                        TextWidget(text: 'Piece', color: color),
                                        Radio(
                                          value: 2,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val = 2;
                                              _isPiece = true;
                                            });
                                          },
                                          activeColor: Colors.green,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _isOnSale,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _isOnSale = newValue!;
                                              if (_isOnSale) {
                                                _salePrice = 0.0;
                                              }
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        TextWidget(
                                          text: 'Sale',
                                          color: color,
                                          isTitle: true,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    AnimatedSwitcher(
                                      duration: const Duration(seconds: 1),
                                      child: !_isOnSale
                                          ? Container()
                                          : Row(
                                              children: [
                                                TextWidget(
                                                    text: "\$" +
                                                        _salePrice
                                                            .toStringAsFixed(2),
                                                    color: color),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                salePourcentageDropDownWidget(
                                                    color),
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: size.width > 650
                                      ? 350
                                      : size.width * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: _pickedImage == null
                                        ? Image.network(
                                            _imageUrl,
                                            fit: BoxFit.cover,
                                          )
                                        : (kIsWeb)
                                            ? Image.memory(
                                                webImage,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                _pickedImage!,
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    FittedBox(
                                      child: TextButton(
                                        onPressed: () {
                                          _pickImage();
                                        },
                                        child: TextWidget(
                                          text: 'Update image',
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ButtonsWidget(
                                foregroundColor: Colors.white,
                                onPressed: () async {
                                  GlobalMethods.warningDialog(
                                      title: 'Delete?',
                                      subtitle: 'Press okay to confirm',
                                      fct: () async {
                                        Navigator.pop(context);
                                        productsProvider.deleteProduct(
                                          productId: widget.product.id,
                                          context: context,
                                          inEdit: true,
                                        );
                                      },
                                      context: context);
                                },
                                text: 'Delete',
                                icon: IconlyBold.danger,
                                backgroundColor: Colors.red.shade700,
                              ),
                              ButtonsWidget(
                                foregroundColor: Colors.white,
                                onPressed: () {
                                  _updateProduct(productsProvider);
                                },
                                text: 'Update',
                                icon: IconlyBold.setting,
                                backgroundColor: Colors.blue,
                              ),
                            ],
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
      ),
    );
  }

  DropdownButtonHideUnderline salePourcentageDropDownWidget(Color color) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _salePercent,
        style: TextStyle(color: color),
        items: const [
          DropdownMenuItem<String>(
            child: Text('10%'),
            value: '10',
          ),
          DropdownMenuItem<String>(
            child: Text('15%'),
            value: '15',
          ),
          DropdownMenuItem<String>(
            child: Text('25%'),
            value: '25',
          ),
          DropdownMenuItem<String>(
            child: Text('50%'),
            value: '50',
          ),
          DropdownMenuItem<String>(
            child: Text('75%'),
            value: '75',
          ),
          DropdownMenuItem<String>(
            child: Text('0%'),
            value: '0',
          ),
        ],
        onChanged: (value) {
          if (value == '0') {
            setState(() {
              _salePercent = '0';
              _salePrice = 0.00;
            });
          } else {
            if (value != null) {
              setState(() {
                _salePercent = value;
                _salePrice = widget.product.price -
                    (double.parse(value) * widget.product.price / 100);
              });
            }
          }
        },
        hint: Text(_salePercent),
      ),
    );
  }

  DropdownButtonHideUnderline catDropDownWidget(Color color) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        style: TextStyle(color: color),
        items: const [
          DropdownMenuItem<String>(
            child: Text('Vegetables'),
            value: 'Vegetables',
          ),
          DropdownMenuItem<String>(
            child: Text('Fruits'),
            value: 'Fruits',
          ),
          DropdownMenuItem<String>(
            child: Text('Grains'),
            value: 'Grains',
          ),
          DropdownMenuItem<String>(
            child: Text('Nuts'),
            value: 'Nuts',
          ),
          DropdownMenuItem<String>(
            child: Text('Herbs'),
            value: 'Herbs',
          ),
          DropdownMenuItem<String>(
            child: Text('Spices'),
            value: 'Spices',
          ),
        ],
        onChanged: (value) {
          setState(() {
            _catValue = value!;
          });
        },
        hint: const Text('Select a Category'),
        value: _catValue,
      ),
    );
  }

  Future<void> _pickImage() async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _pickedImage = selected;
        });
      } else {
        log('No file selected');
        // showToast("No file selected");
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          _pickedImage = File("a");
          webImage = f;
        });
      } else {
        log('No file selected');
      }
    } else {
      log('Perm not granted');
    }
  }

  void _updateProduct(ProductsProvider productsProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_titleController.text.trim().isNotEmpty &&
          _priceController.text.trim().isNotEmpty) {
        final product = Product(
          id: widget.product.id,
          title: _titleController.text,
          productCategory: _catValue,
          imageUrl: widget.product.imageUrl,
          price: double.parse(_priceController.text),
          salePrice: _salePrice,
          isOnSale: _isOnSale,
          isPiece: _isPiece,
          createdAt: widget.product.createdAt,
        );

        await productsProvider.updateProduct(
          context: context,
          product: product,
          image: _pickedImage != null
              ? kIsWeb
                  ? webImage
                  : _pickedImage
              : null,
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => buildCustomSnackBar(
            message: 'Please enter all the required information',
            context: context,
            backgroundColor: Colors.red,
            icon: Icons.error,
          ),
        );
      }
    }
  }
}
