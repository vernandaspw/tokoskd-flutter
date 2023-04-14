// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.code,
    required this.status,
    required this.msg,
    required this.data,
  });

  int code;
  String status;
  String msg;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.nip,
    required this.nama,
    required this.phone,
    required this.email,
    this.emailVerifiedAt,
    this.code,
    this.codeExpiredAt,
    this.codeResendAt,
    this.lastSeenAt,
    required this.role,
    required this.isaktif,
    this.tglGabung,
    required this.gajiPokok,
    required this.pinjaman,
    required this.sisaJatahCutiBulan,
    this.jk,
    this.npwp,
    this.alamat,
    this.bank,
    this.norek,
    this.an,
    required this.createdAt,
    this.updatedAt,
  });

  int id;
  String nip;
  String nama;
  String phone;
  String email;
  dynamic emailVerifiedAt;
  dynamic code;
  dynamic codeExpiredAt;
  dynamic codeResendAt;
  dynamic lastSeenAt;
  String role;
  int isaktif;
  dynamic tglGabung;
  String gajiPokok;
  String pinjaman;
  int sisaJatahCutiBulan;
  dynamic jk;
  dynamic npwp;
  dynamic alamat;
  dynamic bank;
  dynamic norek;
  dynamic an;
  DateTime createdAt;
  dynamic updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nip: json["nip"],
        nama: json["nama"],
        phone: json["phone"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        code: json["code"],
        codeExpiredAt: json["code_expired_at"],
        codeResendAt: json["code_resend_at"],
        lastSeenAt: json["last_seen_at"],
        role: json["role"],
        isaktif: json["isaktif"],
        tglGabung: json["tgl_gabung"],
        gajiPokok: json["gaji_pokok"],
        pinjaman: json["pinjaman"],
        sisaJatahCutiBulan: json["sisa_jatah_cuti_bulan"],
        jk: json["jk"],
        npwp: json["npwp"],
        alamat: json["alamat"],
        bank: json["bank"],
        norek: json["norek"],
        an: json["an"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nip": nip,
        "nama": nama,
        "phone": phone,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "code": code,
        "code_expired_at": codeExpiredAt,
        "code_resend_at": codeResendAt,
        "last_seen_at": lastSeenAt,
        "role": role,
        "isaktif": isaktif,
        "tgl_gabung": tglGabung,
        "gaji_pokok": gajiPokok,
        "pinjaman": pinjaman,
        "sisa_jatah_cuti_bulan": sisaJatahCutiBulan,
        "jk": jk,
        "npwp": npwp,
        "alamat": alamat,
        "bank": bank,
        "norek": norek,
        "an": an,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
