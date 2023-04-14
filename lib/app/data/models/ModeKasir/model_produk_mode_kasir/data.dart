import 'datum.dart';

class Data {
  int? totalData;
  List<Datum>? data;

  Data({this.totalData, this.data});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalData: json['totalData'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'totalData': totalData,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
