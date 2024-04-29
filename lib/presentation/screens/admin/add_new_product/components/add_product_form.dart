import 'dart:io';

import '../../../../../providers/current_store_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../../config/validators.dart';
import '../../../../cubits/products_cubit/products_cubit.dart';
import 'add_product_field.dart';
import '../../components/pick_image_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewProductForm extends StatefulWidget {
  const NewProductForm({super.key});

  @override
  State<NewProductForm> createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  int? _amount;
  double? _price;
  XFile? _image;

  void emptyImageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(color: errorColor),
        ),
        content: Text(
          "Please inter an Image for the Product First",
          style: TextStyle(fontSize: defaultPadding),
        ),
      ),
    );
  }

  void _pickImage(source) async {
    final pickedImage =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (pickedImage == null) return;
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _trySubmit() async {
    if (_image == null) {
      emptyImageDialog();
    }
    final isValid = _formKey.currentState!.validate();
    if (isValid && _image != null) {
      _formKey.currentState!.save();
      await context.read<ProductsCubit>().addNewProduct(
            name: _name,
            image: _image,
            price: _price,
            location: _location,
            amount: _amount,
            storeId: Provider.of<CurrentStoreProvider>(context, listen: false)
                .currentStoreId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is SuccessAddProductState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Text("Product Added Successfully"),
              backgroundColor: Colors.green,
            ));
        } else if (state is ErrorProductsState) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(color: errorColor),
              ),
              content: Text(
                state.error.message,
                style: const TextStyle(fontSize: defaultPadding),
              ),
            ),
          );
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: NewProductField(
                  title: "Name:",
                  keyboardType: TextInputType.name,
                  validator: emptyValidator,
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
              ),
              NewProductField(
                title: "Price:",
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (value) {
                  _price = double.tryParse(value!);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: NewProductField(
                  title: "Amount:",
                  keyboardType: TextInputType.number,
                  validator: emptyValidator,
                  onSaved: (value) {
                    _amount = int.parse(value!);
                  },
                ),
              ),
              NewProductField(
                title: "Location:",
                keyboardType: TextInputType.name,
                validator: emptyValidator,
                onSaved: (value) {
                  _location = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Photo:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: FloatingActionButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PickImageBottomSheet(
                                cameraPressed: () {
                                  _pickImage(ImageSource.camera);
                                },
                                galleryPressed: () {
                                  _pickImage(ImageSource.gallery);
                                },
                              );
                            });
                      },
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ),
              if (_image != null)
                SizedBox(
                    height: 100,
                    width: 200,
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.contain,
                    )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: OutlinedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await _trySubmit();
                  },
                  style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(100, 40)),
                      backgroundColor: MaterialStatePropertyAll(customGreen)),
                  child: BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                    if (state is LoadingProductsState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
              )
            ],
          )),
    );
  }
}
