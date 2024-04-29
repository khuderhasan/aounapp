import 'package:flutter/material.dart';

class CurrentStoreProvider with ChangeNotifier {
  String _currentStoreId = '';
  String get currentStoreId => _currentStoreId;
  set currentStoreId(String id) {
    _currentStoreId = id;
    notifyListeners();
  }
}
