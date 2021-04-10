import 'package:json_annotation/json_annotation.dart';
part 'weight_record.g.dart';

@JsonSerializable()
class WeightRecord {
  final String recordId;
  final double weight;
  final DateTime dateTime;

  WeightRecord(this.recordId, this.weight, this.dateTime);

  WeightRecord copyWith(WeightRecord wr) {
    return WeightRecord(wr.recordId, wr.weight, wr.dateTime);
  }

  factory WeightRecord.fromJson(Map<String, dynamic> json) =>
      _$WeightRecordFromJson(json);
  Map<String, dynamic> toJson() => _$WeightRecordToJson(this);
}
