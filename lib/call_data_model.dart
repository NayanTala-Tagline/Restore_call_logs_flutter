import 'package:call_log/call_log.dart';
import 'package:hive/hive.dart';

part 'call_data_model.g.dart';

@HiveType(typeId: 0)
class CallLogEntry2 extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? number;
  @HiveField(2)
  String? formattedNumber;
  @HiveField(3)
  String? callType;
  @HiveField(4)
  int? duration;
  @HiveField(5)
  int? timestamp;
  @HiveField(6)
  int? cachedNumberType;
  @HiveField(7)
  String? cachedNumberLabel;
  @HiveField(8)
  String? cachedMatchedNumber;
  @HiveField(9)
  String? simDisplayName;
  @HiveField(10)
  String? phoneAccountId;

  /// constructor
  CallLogEntry2({
    this.name,
    this.number,
    this.formattedNumber,
    this.callType,
    this.duration,
    this.timestamp,
    this.cachedNumberType,
    this.cachedNumberLabel,
    this.simDisplayName,
    this.phoneAccountId,
  });

  /// constructor creating object from provided map
  CallLogEntry2.fromMap(Map<dynamic, dynamic> m) {
    name = m['name'];
    number = m['number'];
    formattedNumber = m['formattedNumber'];
    callType = getCallTypeString[m['callType']];
    duration = m['duration'];
    timestamp = m['timestamp'];
    cachedNumberType = m['cachedNumberType'];
    cachedNumberLabel = m['cachedNumberLabel'];
    cachedMatchedNumber = m['cachedMatchedNumber'];
    simDisplayName = m['simDisplayName'];
    phoneAccountId = m['phoneAccountId'];
  }

  bool compareTo(CallLogEntry2 other) => (other.name == name &&
      other.number == number &&
      other.formattedNumber == formattedNumber &&
      other.callType == callType &&
      other.duration == duration &&
      other.timestamp == timestamp &&
      other.cachedNumberType == cachedNumberType &&
      other.cachedNumberLabel == cachedNumberLabel &&
      other.cachedMatchedNumber == cachedMatchedNumber &&
      other.simDisplayName == simDisplayName &&
      other.phoneAccountId == phoneAccountId);

  @override
  bool operator ==(Object other) =>
      other is CallLogEntry2 &&
          (other.name == name &&
              other.number == number &&
              other.formattedNumber == formattedNumber &&
              other.callType == callType &&
              other.duration == duration &&
              other.timestamp == timestamp &&
              other.cachedNumberType == cachedNumberType &&
              other.cachedNumberLabel == cachedNumberLabel &&
              other.cachedMatchedNumber == cachedMatchedNumber &&
              other.simDisplayName == simDisplayName &&
              other.phoneAccountId == phoneAccountId);
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

// CallType getCallType(int n) {
//   if (n == 100) {
//     //return the wifi outgoing call
//     return CallType.wifiOutgoing;
//   } else if (n == 101) {
//     //return wifiIncoming call
//     return CallType.wifiIncoming;
//   } else if (n >= 1 && n <= 8) {
//     return CallType.values[n - 1];
//   } else {
//     return CallType.unknown;
//   }
// }
