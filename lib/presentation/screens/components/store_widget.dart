import '../../../config/constants.dart';
import '../../../data/models/store_model.dart';
import '../../../providers/current_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget({
    super.key,
    required this.store,
    required this.onTap,
  });
  final StoreModel store;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
      child: GestureDetector(
        onTap: () {
          Provider.of<CurrentStoreProvider>(context, listen: false)
              .currentStoreId = store.id;
          onTap!();
        },
        child: Card(
          color: Colors.white,
          child: ListTile(
            title: Text(
              store.storeName,

            ),
            subtitle: (store.distance != null)
                ? Text("Distance: ${store.distance} m")
                : null,
            leading: const Icon(
              Icons.storefront,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
