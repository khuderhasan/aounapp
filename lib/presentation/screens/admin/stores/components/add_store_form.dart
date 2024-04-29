import '../admin_map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../cubits/stores/stores_cubit.dart';
import '../../add_new_product/components/add_product_field.dart';

import '../../../../../config/constants.dart';
import '../../../../../config/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStoreForm extends StatefulWidget {
  const AddStoreForm({super.key});

  @override
  State<AddStoreForm> createState() => _AddStoreFormState();
}

class _AddStoreFormState extends State<AddStoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _storeName = '';

  LatLng? _selectedLocation;

  Future<void> _selectOnMap() async {
    _selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const AdminMapScreen(),
      ),
    );
  }

  void emptyImageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(color: errorColor),
        ),
        content: Text(
          "Please Select a Location for the Store First",
          style: TextStyle(fontSize: defaultPadding),
        ),
      ),
    );
  }

  Future<void> _trySubmit() async {
    if (_selectedLocation == null) {
      emptyImageDialog();
    }
    final isValid = _formKey.currentState!.validate();
    if (isValid && _selectedLocation != null) {
      _formKey.currentState!.save();
      await context.read<StoresCubit>().addStore(
            storeName: _storeName,
            latitude: _selectedLocation!.latitude,
            longitude: _selectedLocation!.longitude,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoresCubit, StoresState>(
      listener: (context, state) {
        if (state is SuccessAddStoreState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar(reason: SnackBarClosedReason.hide)
            ..showSnackBar(const SnackBar(
              content: Text("Store Added Successfully"),
              backgroundColor: Colors.green,
            ));
        } else if (state is ErrorStoresState) {
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
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
              child: NewProductField(
                title: "Store Name:",
                keyboardType: TextInputType.name,
                validator: emptyValidator,
                onSaved: (value) {
                  _storeName = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Location:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: FloatingActionButton(
                    onPressed: _selectOnMap,
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
            ),
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
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 93, 134, 86))),
                child: BlocBuilder<StoresCubit, StoresState>(
                    builder: (context, state) {
                  if (state is LoadingStoresState) {
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
        ),
      ),
    );
  }
}
