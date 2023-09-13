import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'call_data_model.dart';

class ViewPage extends StatefulWidget {
  List<CallLogEntry2> calldata;

  ViewPage(this.calldata, {super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  static const platform = MethodChannel('samples.flutter.dev/calllogs');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _getBatteryLevel() async {
    final Map<String, dynamic> params = {
      'name': widget.calldata[0].name,
      'number': widget.calldata[0].number,
      "formattedNumber": widget.calldata[0].formattedNumber,
      'callType': widget.calldata[0].callType,
      'duration': widget.calldata[0].duration,
      'timestamp': widget.calldata[0].timestamp,
      'cachedNumberType': widget.calldata[0].cachedNumberType,
      'cachedNumberLabel': widget.calldata[0].cachedNumberLabel,
      'cachedMatchedNumber': widget.calldata[0].cachedMatchedNumber,
      'simDisplayName': widget.calldata[0].simDisplayName,
      'phoneAccountId': widget.calldata[0].phoneAccountId,
    };
    print(widget.calldata);
    // String batteryLevel;
    // try {
    //   var result = await platform.invokeMethod('writeCallLog',params);
    //   batteryLevel = 'Battery level at $result % .';
    // } on PlatformException catch (e) {
    //   batteryLevel = "Failed to get battery level: '${e.message}'.";
    // }
    // log(batteryLevel);
    // for (int i = 0; i < widget.calldata.length; i++) {
      String batteryLevel;
      try {
        var result = await platform.invokeMethod('writeCallLog', params);
        batteryLevel = 'Battery level at $result % .';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Restored successfully")));
      } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }
      log(batteryLevel);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call logs"),
        actions: [
          // ElevatedButton(
          //     onPressed: () async {
          //       // _getBatteryLevel();
          //       final status = await Permission.phone.request();
          //       if (status.isGranted) {
          //         _getBatteryLevel();
          //       } else {
          //         // Handle the case when the permission is denied by the user.
          //       }
          //     },
          //     child: Text("Restore"))
        ],
      ),
      body: ListView.builder(
        itemCount: widget.calldata.length,
        itemBuilder: (context, index) {
          // return Text("${widget.calldata[index].name}  ${widget.calldata[index].number}");
          return Card(
              elevation: 2,
              child: ListTile(
                title: Text("${widget.calldata[index].name}"),
                subtitle: Text("${widget.calldata[index].number}"),
                trailing: Text("${widget.calldata[index].callType}\n${widget.calldata[index].duration} s"),
              ));
        },
      ),
    );
  }
}
