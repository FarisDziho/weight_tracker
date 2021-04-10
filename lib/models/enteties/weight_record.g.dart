// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightRecord _$WeigtRecordFromJson(Map<String, dynamic> json) {
  return WeightRecord(
    (json['weight'] as num)?.toDouble(),
    json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
  );
}

Map<String, dynamic> _$WeigtRecordToJson(WeightRecord instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
