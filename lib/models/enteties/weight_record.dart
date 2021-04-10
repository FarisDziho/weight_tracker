import 'package:json_annotation/json_annotation.dart';
part 'weight_record.g.dart';

@JsonSerializable()
class WeightRecord {
  final double weight;
  final DateTime dateTime;

  WeightRecord(this.weight, this.dateTime);

  WeightRecord copyWith(WeightRecord wr) {
    return WeightRecord(wr.weight, wr.dateTime);
  }

  factory WeightRecord.fromJson(Map<String, dynamic> json) =>
      _$WeigtRecordFromJson(json);
  Map<String, dynamic> toJson() => _$WeigtRecordToJson(this);
}
