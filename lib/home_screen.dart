// import 'package:flutter/material.dart';
// import 'package:call_log/call_log.dart';
// import 'package:flutter/services.dart';
// import 'package:workmanager/workmanager.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     callbackDispatcher();
//   }
//
//   void callbackDispatcher() {
//     Workmanager().executeTask((dynamic task, dynamic inputData) async {
//       print('Background Services are Working!');
//       try {
//         final Iterable<CallLogEntry> cLog = await CallLog.get();
//         print('Queried call log entries');
//         for (CallLogEntry entry in cLog) {
//           print('-------------------------------------');
//           print('F. NUMBER  : ${entry.formattedNumber}');
//           print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
//           print('NUMBER     : ${entry.number}');
//           print('NAME       : ${entry.name}');
//           print('TYPE       : ${entry.callType}');
//           print('DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
//           print('DURATION   : ${entry.duration}');
//           print('ACCOUNT ID : ${entry.phoneAccountId}');
//           print('ACCOUNT ID : ${entry.phoneAccountId}');
//           print('SIM NAME   : ${entry.simDisplayName}');
//           print('-------------------------------------');
//         }
//         return true;
//       } on PlatformException catch (e, s) {
//         print(e);
//         print(s);
//         return true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           ElevatedButton(onPressed: () {
//           }, child: const Text("Backup"))
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:call_log_demo/main.dart';
import 'package:call_log_demo/view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';
import 'package:collection/collection.dart';

import 'call_data_model.dart';

///TOP-LEVEL FUNCTION PROVIDED FOR WORK MANAGER AS CALLBACK
void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      final Iterable<CallLogEntry> cLog = await CallLog.get();
      print('Queried call log entries');
      for (CallLogEntry entry in cLog) {
        print('-------------------------------------');
        print('F. NUMBER  : ${entry.formattedNumber}');
        print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
        print('NUMBER     : ${entry.number}');
        print('NAME       : ${entry.name}');
        print('TYPE       : ${entry.callType}');
        print('DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
        print('DURATION   : ${entry.duration}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('SIM NAME   : ${entry.simDisplayName}');
        print('-------------------------------------');
      }
      return true;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      return true;
    }
  });
}

/// example widget for call log plugin
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/calllogs');
  List<CallLogEntry2> callDataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCallLog();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('call_log example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await box?.clear();
                  callDataList.clear();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cleared successfully")));
                },
                child: const Text("Clear all call logs")),
            ElevatedButton(
                onPressed: () async {
                  // // var calldata =  box?.values.toList()??[];
                  // // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // //   return SecondPage(calldata);
                  // // // },));
                  // // _getBatteryLevel();
                  // // getCallLog(isRestore: true);
                  // // List<CallLogEntry2> callDataList2=[];
                  // // if (isRestore==false) {
                  // //   box?.clear();
                  // // }
                  // // Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
                  // final Iterable<CallLogEntry> result = await CallLog.query();
                  // // List<CallLogEntry2> callDataList2 = [];
                  // callDataList.clear();
                  // // setState(() {
                  // //   _callLogEntries = result;
                  // // });
                  // result.forEach((element) {
                  //   final Map<String, dynamic> params = {
                  //     'name': element.name,
                  //     'number': element.number,
                  //     "formattedNumber": element.formattedNumber,
                  //     'callType': element.callType,
                  //     'duration': element.duration,
                  //     'timestamp': element.timestamp,
                  //     'cachedNumberType': element.cachedNumberType,
                  //     'cachedNumberLabel': element.cachedNumberLabel,
                  //     'cachedMatchedNumber': element.cachedMatchedNumber,
                  //     'simDisplayName': element.simDisplayName,
                  //     'phoneAccountId': element.phoneAccountId,
                  //   };
                  //
                  //   callDataList.add(CallLogEntry2.fromMap(params));
                  //   // print(params);
                  //   // if (isRestore==false) {
                  //   //   box?.add(CallLogEntry2.fromMap(params));
                  //   // }
                  // });
                  // print("callDataList $callDataList");
                  // List<CallLogEntry2> restoreCallList = [];
                  //
                  // print("box?.values.length ${box?.values.length}");
                  // box?.values.forEach((element) {
                  //   var callLog = callDataList.firstWhereOrNull((e) {
                  //     return e.compareTo(element);
                  //   });
                  //   if (callLog == null) {
                  //     restoreCallList.add(element);
                  //   }
                  // });
                  //
                  // setState(() {});
                  // // final status = await Permission.phone.request();
                  // // if (status.isGranted) {
                  // _getBatteryLevel(restoreCallList);
                  // // } else {
                  // // Handle the case when the permission is denied by the user.
                  // // }

                  final Iterable<CallLogEntry> result = await CallLog.query();
                  // callDataList.clear();
                  List<CallLogEntry2> callDataList2 = [];
                  result.forEach((element) {
                    final Map<String, dynamic> params = {
                      'name': element.name,
                      'number': element.number,
                      "formattedNumber": element.formattedNumber,
                      'callType': element.callType,
                      'duration': element.duration,
                      'timestamp': element.timestamp,
                      'cachedNumberType': element.cachedNumberType,
                      'cachedNumberLabel': element.cachedNumberLabel,
                      'cachedMatchedNumber': element.cachedMatchedNumber,
                      'simDisplayName': element.simDisplayName,
                      'phoneAccountId': element.phoneAccountId,
                    };

                    callDataList2.add(CallLogEntry2.fromMap(params));
                  });

                  print("callDataList $callDataList2");


                  print("box.length ${box?.values.length}");

                  List<CallLogEntry2> restoreCallList = [];
                  box?.values.forEach((element) {
                    var callLog = callDataList2.firstWhereOrNull((e) {
                      return e.compareTo(element);
                    });
                    if (callLog == null) {
                      restoreCallList.add(element);
                    }
                  });

                   final status = await Permission.phone.request();
                  if (status.isGranted) {
                    await _getBatteryLevel(restoreCallList);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Permission denied")));
                  // Handle the case when the permission is denied by the user.
                  }

                  // await _getBatteryLevel(restoreCallList);

                  print("restoreCallList ${restoreCallList.toString()}");
                  restoreCallList.clear();

                },
                child: const Text("Restore all call logs")),
            ElevatedButton(
              onPressed: () async {
                getCallLog();

                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return GetCallLogScreen();
                // },));
              },
              child: const Text('Backup all call logs'),
            ),
            // ElevatedButton(onPressed: () async {
            //    box = await Hive.openBox<CallLogEntry2>('myBox');
            //
            //   print("box.length ${box?.values.length}");
            // }, child: Text("Check box lenght")),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ViewPage(callDataList);
                  },
                ));
              },
              child: const Text('View call logs'),
            ),
          ],
        ),
      ),
    );
  }

  Map<CallType, String> getCallTypeString = {
    CallType.incoming: "incoming",
    CallType.outgoing: "outgoing",
    CallType.missed: "missed",
    CallType.rejected: "rejected",
    CallType.blocked: "blocked",
    CallType.answeredExternally: "answeredExternally",
    CallType.unknown: "unknown",
    CallType.wifiIncoming: "wifiIncoming",
    CallType.wifiOutgoing: "wifiOutgoing"
  };

  Future<void> _getBatteryLevel(List<CallLogEntry2> restoreCallList) async {
    List<Map<String, dynamic>> submitList = restoreCallList
        .map((element) => {
              'name': element.name,
              'number': element.number,
              "formattedNumber": element.formattedNumber,
              'callType': element.callType,
              'duration': element.duration,
              'timestamp': element.timestamp,
              'cachedNumberType': element.cachedNumberType,
              'cachedNumberLabel': element.cachedNumberLabel,
              'cachedMatchedNumber': element.cachedMatchedNumber,
              'simDisplayName': element.simDisplayName,
              'phoneAccountId': element.phoneAccountId,
            })
        .toList();

    // for (int i = 0; i < widget.calldata.length; i++) {
    String batteryLevel;
    try {
      var result = await platform.invokeMethod('writeCallLog', submitList);
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    } finally {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Restored successfully")));
    }
    log(batteryLevel);
  }

  getCallLog() async {
    box = await Hive.openBox<CallLogEntry2>('myBox');
    callDataList.clear();
    await box?.clear();

    final Iterable<CallLogEntry> result = await CallLog.query();
    // log(result.toString(), name: "Tesr");
    // setState(() {
    //   _callLogEntries = result;
    // });
    result.forEach((element) async {
      // log(element.toString());
      final Map<String, dynamic> params = {
        'name': element.name,
        'number': element.number,
        "formattedNumber": element.formattedNumber,
        'callType': element.callType,
        'duration': element.duration,
        'timestamp': element.timestamp,
        'cachedNumberType': element.cachedNumberType,
        'cachedNumberLabel': element.cachedNumberLabel,
        'cachedMatchedNumber': element.cachedMatchedNumber,
        'simDisplayName': element.simDisplayName,
        'phoneAccountId': element.phoneAccountId,
      };
      // log(params.toString());
      callDataList.add(CallLogEntry2.fromMap(params));
      await box?.add(CallLogEntry2.fromMap(params));
    });
    print("callDataList.length ${callDataList.length}");
    print("box.length ${box?.values.length}");
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Backup successfully")));
  }
}
