import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'SampleItem.dart';

class SampleItemViewModel extends ChangeNotifier {
  final LocalStorage storage =
      new LocalStorage('sample_storage'); // Khởi tạo LocalStorage
  final List<SampleItem> items = [];

  SampleItemViewModel() {
    _loadData(); // Gọi hàm để load dữ liệu từ LocalStorage
  }

  void _loadData() async {
    await storage.ready;
    if (storage.getItem('items') != null) {
      // Nếu có dữ liệu trong LocalStorage, lấy dữ liệu và gán vào items
      items.addAll((storage.getItem('items') as List<dynamic>)
          .map((item) => SampleItem.fromJson(item))
          .toList());
      notifyListeners();
    }
  }

  void _saveData() {
    storage.setItem('items', items); // Lưu items vào LocalStorage
  }

  void addItem({
    required String tenNguoiDanh,
    required String soDe,
    required String soTien,
    BuildContext? context, // Thêm context để hiển thị SnackBar
  }) {
    items.add(
        SampleItem(tenNguoiDanh: tenNguoiDanh, soDe: soDe, soTien: soTien));
    notifyListeners();
    _saveData(); // Lưu dữ liệu vào LocalStorage sau khi thêm mới
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thêm thành công')),
      );
    }
  }

  void removeItem(String id, BuildContext? context) {
    items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveData(); // Lưu dữ liệu vào LocalStorage sau khi xóa
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xóa thành công')),
      );
    }
  }

  void updateItem(String id, String tenNguoiDanh, String soDe, String soTien,
      BuildContext? context) {
    try {
      final item = items.firstWhere((item) => item.id == id);
      item.soDe = soDe;
      item.soTien = soTien;
      item.tenNguoiDanh = tenNguoiDanh;
      notifyListeners();
      _saveData(); // Lưu dữ liệu vào LocalStorage sau khi cập nhật
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cập nhật thành công')),
        );
      }
    } catch (e) {
      debugPrint("Không tìm thấy mục với ID $id");
    }
  }

  List<SampleItem> searchByNameAndSoDe(String query) {
    return items.where((item) {
      if (item.tenNguoiDanh.toLowerCase().contains(query.toLowerCase())) {
        return true;
      }
      try {
        final int soDeQuery = int.parse(query);
        final int soDeItem = int.parse(item.soDe);
        return soDeItem == soDeQuery;
      } catch (e) {
        return false;
      }
    }).toList();
  }
}
