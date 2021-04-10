// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightRecord _$WeightRecordFromJson(Map<String, dynamic> json) {
  return WeightRecord(
    json['recordId'] as String,
    (json['weight'] as num)?.toDouble(),
    json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
  );
}

Map<String, dynamic> _$WeightRecordToJson(WeightRecord instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'weight': instance.weight,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
