import 'package:flutter/material.dart';
import 'SampleItemViewModel.dart';

class SampleItemUpdate extends StatefulWidget {
  final String? initialSoDe;
  final String? initialTenNguoiDanh;
  final String? initialSoTien;

  SampleItemUpdate(
      {Key? key,
      this.initialTenNguoiDanh,
      this.initialSoDe,
      this.initialSoTien})
      : super(key: key);

  @override
  _SampleItemUpdateState createState() => _SampleItemUpdateState();
}

class _SampleItemUpdateState extends State<SampleItemUpdate> {
  late TextEditingController soDeTextEditingController;
  late TextEditingController soTienTextEditingController;
  late TextEditingController tenNguoiDanhTextEditingController;

  @override
  void initState() {
    super.initState();

    soDeTextEditingController = TextEditingController(text: widget.initialSoDe);
    soTienTextEditingController =
        TextEditingController(text: widget.initialSoTien);
    tenNguoiDanhTextEditingController =
        TextEditingController(text: widget.initialTenNguoiDanh);
  }

  @override
  void dispose() {
    soDeTextEditingController.dispose();
    soTienTextEditingController.dispose();
    tenNguoiDanhTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialSoDe != null ? 'Chỉnh sửa' : 'Thêm mới'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop({
                'soDe': soDeTextEditingController.text,
                'soTien': soTienTextEditingController.text,
                'tenNguoiDanh': tenNguoiDanhTextEditingController.text,
              });
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: tenNguoiDanhTextEditingController,
            decoration: InputDecoration(labelText: 'Tên'),
          ),
          TextFormField(
            controller: soDeTextEditingController,
            decoration: InputDecoration(labelText: 'Số đề'),
          ),
          TextFormField(
            controller: soTienTextEditingController,
            decoration: InputDecoration(labelText: 'Số Tiền'),
          ),
        ],
      ),
    );
  }
}
