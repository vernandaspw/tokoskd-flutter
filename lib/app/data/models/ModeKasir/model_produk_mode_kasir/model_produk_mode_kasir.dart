import 'data.dart';

class ModelProdukModeKasir {
  int? code;
  String? status;
  String? msg;
  Data? data;

  static ModelProdukModeKasir? obs;

  ModelProdukModeKasir({this.code, this.status, this.msg, this.data});

  factory ModelProdukModeKasir.fromJson(Map<String, dynamic> json) {
    return ModelProdukModeKasir(
      code: json['code'] as int?,
      status: json['status'] as String?,
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'msg': msg,
        'data': data?.toJson(),
      };
}
