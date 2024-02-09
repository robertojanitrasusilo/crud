import 'dart:ffi';

import 'package:crud/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookProvider extends ChangeNotifier {
  bool? _available = false;

  bool? get available => _available;
  set available(bool? value) {
    _available = value;
    notifyListeners();
  }
}
