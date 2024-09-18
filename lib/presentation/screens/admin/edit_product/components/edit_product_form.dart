import 'dart:io';

import '../../../../../providers/current_store_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../../config/validators.dart';
import '../../../../../data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../cubits/products_cubit/products_cubit.dart';
import '../../add_new_product/components/add_product_field.dart';
import '../../components/pick_image_bottomsheet.dart';

class EditProductForm extends StatefulWidget {
  const EditProductForm({super.key, required this.product});
  final ProductModel product;
  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _formKey = GlobalKey<FormState>();
  late String _id;
  late String _name;
  late String? _location;
  int? _amount;
  double? _price;
  XFile? _image;
  @override
  void initState() {
    _id = widget.product.id!;
    _name = widget.product.name;
    _location = widget.product.location;
    _price = widget.product.price;
    _amount = widget.product.amount;
    super.initState();
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
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      await context.read<ProductsCubit>().updateProduct(
            id: _id,
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
        if (state is SuccessUpdateProduct) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Text("Product Updated Successfully"),
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
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: NewProductField(
                  title: "Name:",
                  initialValue: _name,
                  keyboardType: TextInputType.name,
                  validator: emptyValidator,
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
              ),
              NewProductField(
                title: "Price:",
                initialValue: _price.toString(),
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
                  initialValue: _amount.toString(),
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
                initialValue: _location.toString(),
                validator: emptyValidator,
                onSaved: (value) {
                  _location = value!;
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.only(right: defaultPadding / 2),
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
              SizedBox(
                  height: 100,
                  width: 200,
                  child: (_image == null)
                      ? Image.network(widget.product.image!,
                          fit: BoxFit.contain)
                      : Image.file(
                          File(_image!.path),
                          fit: BoxFit.contain,
                        )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: OutlinedButton(
                  onPressed: () async {
                    await _trySubmit();
                  },
                  style: const ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(100, 40)),
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 93, 134, 86))),
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
