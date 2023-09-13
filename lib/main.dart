import 'package:call_log_demo/call_data_model.dart';
import 'package:call_log_demo/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';
Box<CallLogEntry2>? box;
List<CallLogEntry2>? calldata;

List<CallLogEntry2> selectedDataList = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('HIVE_DATA');
  Hive.registerAdapter(CallLogEntry2Adapter());
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(MaterialApp(home: HomeScreen()));
}


