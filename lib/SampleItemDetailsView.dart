import 'package:flutter/material.dart';
import 'SampleItem.dart';
import 'SampleItemUpdate.dart';
import 'SampleItemViewModel.dart';

class SampleItemDetailsView extends StatefulWidget {
  final SampleItem item;

  const SampleItemDetailsView({Key? key, required this.item}) : super(key: key);

  @override
  _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  final viewModel = SampleItemViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết'),
        actions: [
          IconButton(
            onPressed: () {
              _editItem();
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _confirmDeleteItem(context);
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('Tên Người Đánh : ${widget.item.tenNguoiDanh}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Số Đánh : ${widget.item.soDe}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Số Tiền: ${widget.item.soTien}',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  void _editItem() async {
    final updatedValues = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(
        builder: (context) => SampleItemUpdate(
          initialSoDe: widget.item.soDe,
          initialSoTien: widget.item.soTien,
          initialTenNguoiDanh: widget.item.tenNguoiDanh,
        ),
      ),
    );
    if (updatedValues != null) {
      setState(() {
        widget.item.soDe = updatedValues['soDe'].toString() ?? widget.item.soDe;
        widget.item.soTien =
            updatedValues['soTien'].toString() ?? widget.item.soTien;
        widget.item.tenNguoiDanh = updatedValues['tenNguoiDanh'].toString() ??
            widget.item.tenNguoiDanh;
      });
    }
  }

  void _confirmDeleteItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận xóa"),
          content: const Text("Bạn có chắc muốn xóa mục này ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog mà không xóa
              },
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog và tiếp tục xóa
                viewModel.removeItem(widget.item.id, context); // Xóa item
                Navigator.of(context)
                    .pop(true); // Quay lại màn hình trước đó (nếu cần)
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }
}
