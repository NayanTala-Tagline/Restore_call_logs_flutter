// import 'package:call_log/call_log.dart';
// import 'package:call_log_demo/call_data_model.dart';
// import 'package:call_log_demo/main.dart';
// import 'package:flutter/material.dart';
// import 'package:collection/collection.dart';
//
// class GetCallLogScreen extends StatefulWidget {
//   const GetCallLogScreen({super.key});
//
//   @override
//   State<GetCallLogScreen> createState() => _GetCallLogScreenState();
// }
//
// class _GetCallLogScreenState extends State<GetCallLogScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCallLog();
//   }
//
//   getCallLog() async {
//     callDataList.clear();
//     Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
//     final Iterable<CallLogEntry> result = await CallLog.query();
//     setState(() {
//       _callLogEntries = result;
//     });
//     _callLogEntries.forEach((element) {
//       final Map<String, dynamic> params = {
//         'name': element.name,
//         'number': element.number,
//         "formattedNumber": element.formattedNumber,
//         // 'callType': element.callType,
//         'duration': element.duration,
//         'timestamp': element.timestamp,
//         'cachedNumberType': element.cachedNumberType,
//         'cachedNumberLabel': element.cachedNumberLabel,
//         'cachedMatchedNumber': element.cachedMatchedNumber,
//         'simDisplayName': element.simDisplayName,
//         'phoneAccountId': element.phoneAccountId,
//       };
//       print(params);
//
//       callDataList.add(CallLogEntry2.fromMap(params));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         title: Text("Call Log List"),
//         actions: [
//           GestureDetector(
//               onTap: () {
//                 callDataList.forEach((element) async {
//                   try {
//                     var data = box?.values.firstWhereOrNull((e) => e.timestamp.toString() == element.timestamp.toString());
//                     if (data == null) {
//                       await box?.add(element);
//                     }
//                   } catch (e) {}
//                 });
//                 selectedDataList.clear();
//                 setState(() {});
//                 Navigator.pop(context);
//               },child: Center(child: Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Text("Backup all"),
//               )),)
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: callDataList.length,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 2,
//             child: ListTile(
//               onTap: () {
//                 setState(() {
//                   if(selectedDataList.contains(callDataList[index])){
//                     selectedDataList.remove(callDataList[index]);
//                   }else{
//                     selectedDataList.add(callDataList[index]);
//                   }
//                 });
//               },
//               leading: Checkbox(
//                 value: selectedDataList.contains(callDataList[index]),
//                 onChanged: (value) {
//                   setState(() {
//                     if(selectedDataList.contains(callDataList[index])){
//                       selectedDataList.remove(callDataList[index]);
//                     }else{
//                       selectedDataList.add(callDataList[index]);
//                     }
//                   });
//                 },
//               ),
//               title: Text("${callDataList[index].name}"),
//               subtitle: Text("${callDataList[index].number}"),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
