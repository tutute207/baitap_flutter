import 'package:flutter/foundation.dart';

class SampleItem {
  static int _idCounter = 0;
  String id;
  String tenNguoiDanh;
  String soDe;
  String soTien;
  ValueNotifier<String> name;

  SampleItem({
    required this.tenNguoiDanh,
    required this.soDe,
    required this.soTien,
  })  : id = generateId(),
        name = ValueNotifier("ID : ${_idCounter}");

  SampleItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? generateId(),
        tenNguoiDanh = json['tenNguoiDanh'] ?? '',
        soDe = json['soDe'] ?? '',
        soTien = json['soTien'] ?? '',
        name = ValueNotifier("ID : ${_idCounter}");

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenNguoiDanh': tenNguoiDanh,
      'soDe': soDe,
      'soTien': soTien,
    };
  }

  static String generateId() {
    return 'ID_${++_idCounter}';
  }
}
