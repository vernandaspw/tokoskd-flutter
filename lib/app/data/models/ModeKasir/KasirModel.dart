// To parse this JSON data, do
//
//     final kasirModel = kasirModelFromJson(jsonString);

import 'dart:convert';

KasirModel kasirModelFromJson(String str) =>
    KasirModel.fromJson(json.decode(str));

String kasirModelToJson(KasirModel data) => json.encode(data.toJson());

class KasirModel {
  static KasirModel? obs;

  KasirModel({
    required this.code,
    required this.status,
    required this.msg,
    required this.data,
  });

  int code;
  String status;
  String msg;
  List<Datum> data;

  factory KasirModel.fromJson(Map<String, dynamic> json) => KasirModel(
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.nama,
    required this.kasId,
    required this.isaktif,
    required this.status,
    required this.modeBebas,
    required this.createdAt,
    required this.updatedAt,
    required this.kasirReport,
    required this.kas,
  });

  int id;
  String nama;
  int kasId;
  int isaktif;
  String status;
  int modeBebas;
  String createdAt;
  String updatedAt;
  List<KasirReport> kasirReport;
  Kas kas;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        kasId: json["kas_id"],
        isaktif: json["isaktif"],
        status: json["status"],
        modeBebas: json["mode_bebas"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        kasirReport: List<KasirReport>.from(
            json["kasir_report"].map((x) => KasirReport.fromJson(x))),
        kas: Kas.fromJson(json["kas"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kas_id": kasId,
        "isaktif": isaktif,
        "status": status,
        "mode_bebas": modeBebas,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "kasir_report": List<dynamic>.from(kasirReport.map((x) => x.toJson())),
        "kas": kas.toJson(),
      };
}

class Kas {
  Kas({
    required this.id,
    this.no,
    required this.tipe,
    required this.nama,
    required this.saldo,
    required this.saldoSelisih,
    this.bank,
    this.norek,
    this.an,
    required this.isaktif,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic no;
  String tipe;
  String nama;
  String saldo;
  String saldoSelisih;
  dynamic bank;
  dynamic norek;
  dynamic an;
  int isaktif;
  DateTime createdAt;
  DateTime updatedAt;

  factory Kas.fromJson(Map<String, dynamic> json) => Kas(
        id: json["id"],
        no: json["no"],
        tipe: json["tipe"],
        nama: json["nama"],
        saldo: json["saldo"],
        saldoSelisih: json["saldo_selisih"],
        bank: json["bank"],
        norek: json["norek"],
        an: json["an"],
        isaktif: json["isaktif"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "tipe": tipe,
        "nama": nama,
        "saldo": saldo,
        "saldo_selisih": saldoSelisih,
        "bank": bank,
        "norek": norek,
        "an": an,
        "isaktif": isaktif,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class KasirReport {
  KasirReport({
    required this.id,
    required this.kasirId,
    required this.kasAwal,
    required this.totalUangMasuk,
    required this.totalUangKeluar,
    required this.kasAkhir,
    required this.kasTutup,
    required this.selisih,
    required this.kasDitarik,
    required this.sisaDikasir,
    required this.jumlahTransaksi,
    required this.uangTunai,
    required this.uangNontunai,
    required this.tagihanUtang,
    required this.omset,
    required this.untung,
    required this.bukaOleh,
    this.tutupOleh,
    this.tutupAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int kasirId;
  String kasAwal;
  String totalUangMasuk;
  String totalUangKeluar;
  String kasAkhir;
  String kasTutup;
  String selisih;
  String kasDitarik;
  String sisaDikasir;
  int jumlahTransaksi;
  String uangTunai;
  String uangNontunai;
  String tagihanUtang;
  String omset;
  String untung;
  int bukaOleh;
  int? tutupOleh;
  DateTime? tutupAt;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory KasirReport.fromJson(Map<String, dynamic> json) => KasirReport(
        id: json["id"],
        kasirId: json["kasir_id"],
        kasAwal: json["kas_awal"],
        totalUangMasuk: json["total_uang_masuk"],
        totalUangKeluar: json["total_uang_keluar"],
        kasAkhir: json["kas_akhir"],
        kasTutup: json["kas_tutup"],
        selisih: json["selisih"],
        kasDitarik: json["kas_ditarik"],
        sisaDikasir: json["sisa_dikasir"],
        jumlahTransaksi: json["jumlah_transaksi"],
        uangTunai: json["uang_tunai"],
        uangNontunai: json["uang_nontunai"],
        tagihanUtang: json["tagihan_utang"],
        omset: json["omset"],
        untung: json["untung"],
        bukaOleh: json["buka_oleh"],
        tutupOleh: json["tutup_oleh"],
        tutupAt:
            json["tutup_at"] == null ? null : DateTime.parse(json["tutup_at"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kasir_id": kasirId,
        "kas_awal": kasAwal,
        "total_uang_masuk": totalUangMasuk,
        "total_uang_keluar": totalUangKeluar,
        "kas_akhir": kasAkhir,
        "kas_tutup": kasTutup,
        "selisih": selisih,
        "kas_ditarik": kasDitarik,
        "sisa_dikasir": sisaDikasir,
        "jumlah_transaksi": jumlahTransaksi,
        "uang_tunai": uangTunai,
        "uang_nontunai": uangNontunai,
        "tagihan_utang": tagihanUtang,
        "omset": omset,
        "untung": untung,
        "buka_oleh": bukaOleh,
        "tutup_oleh": tutupOleh,
        "tutup_at": tutupAt?.toIso8601String(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
