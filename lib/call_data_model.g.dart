// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallLogEntry2Adapter extends TypeAdapter<CallLogEntry2> {
  @override
  final int typeId = 0;

  @override
  CallLogEntry2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallLogEntry2(
      name: fields[0] as String?,
      number: fields[1] as String?,
      formattedNumber: fields[2] as String?,
      callType: fields[3] as String?,
      duration: fields[4] as int?,
      timestamp: fields[5] as int?,
      cachedNumberType: fields[6] as int?,
      cachedNumberLabel: fields[7] as String?,
      simDisplayName: fields[9] as String?,
      phoneAccountId: fields[10] as String?,
    )..cachedMatchedNumber = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, CallLogEntry2 obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.formattedNumber)
      ..writeByte(3)
      ..write(obj.callType)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.cachedNumberType)
      ..writeByte(7)
      ..write(obj.cachedNumberLabel)
      ..writeByte(8)
      ..write(obj.cachedMatchedNumber)
      ..writeByte(9)
      ..write(obj.simDisplayName)
      ..writeByte(10)
      ..write(obj.phoneAccountId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallLogEntry2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
