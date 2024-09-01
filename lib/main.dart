// ignore_for_file: unnecessary_null_comparison

import 'package:educational_institute/core/utils/local_storage/local_storage.dart';
import 'package:educational_institute/eductional_institute.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  if (LocalStorage.getData(key: 'isGuest') == null) {
    await LocalStorage.saveData(key: 'isGuest', value: true);
  }

  runApp(const EductionalInstitute());
}
