import 'package:flutter/material.dart';
import 'package:baitap2004/SampleItem.dart';
import 'package:baitap2004/SampleItemDetailsView.dart';
import 'package:baitap2004/SampleItemUpdate.dart';
import 'package:baitap2004/SampleItemViewModel.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({Key? key}) : super(key: key);

  @override
  _SampleItemListViewState createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final viewModel = SampleItemViewModel();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Đánh Đề'),
        leading: Image.asset('assets/icon.jpg'), // Đường dẫn đến ảnh icon.jpg
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<Map<String, String>>(
                context: context,
                builder: (context) => SampleItemUpdate(),
              ).then((value) {
                if (value != null) {
                  if (!_validateInput(value)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Lỗi: Số Đề phải lớn hơn 0 và nhỏ hơn 100 và không chứa chữ cái, Số Tiền không được chứa chữ cái',
                        ),
                      ),
                    );
                  } else {
                    viewModel.addItem(
                      tenNguoiDanh: value['tenNguoiDanh'] ?? '',
                      soDe: value['soDe'] ?? '',
                      soTien: value['soTien'] ?? '',
                      context: context,
                    );
                  }
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm theo tên hoặc số đề',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (() {
                        _searchController.clear();
                        setState(() {});
                      })),
                ),
                onChanged: (_) => setState(() {}),
              ),
              Expanded(
                child: ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, _) {
                    final List<SampleItem> displayedItems = _searchController
                            .text.isNotEmpty
                        ? viewModel.searchByNameAndSoDe(_searchController.text)
                        : viewModel.items;

                    // Kiểm tra nếu không có kết quả tìm kiếm thì hiển thị toàn bộ dữ liệu
                    if (displayedItems.isEmpty &&
                        _searchController.text.isNotEmpty) {
                      return ListView.builder(
                        itemCount: viewModel.items.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.items[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              title: Text(
                                item.name.value,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tên Người Đánh : ${item.tenNguoiDanh}',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 1, 0, 0),
                                    ),
                                  ),
                                  Text(
                                    'Số Đề : ${item.soDe}',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  Text(
                                    'Số Tiền : ${item.soTien}',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push<bool>(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SampleItemDetailsView(item: item),
                                  ),
                                )
                                    .then((deleted) {
                                  if (deleted ?? false) {
                                    viewModel.removeItem(item.id, context);
                                  }
                                });
                              },
                            ),
                          );
                        },
                      );
                    }

                    return ListView.builder(
                      itemCount: displayedItems.length,
                      itemBuilder: (context, index) {
                        final item = displayedItems[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(
                              item.name.value,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tên Người Đánh : ${item.tenNguoiDanh}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 1, 0, 0),
                                  ),
                                ),
                                Text(
                                  'Số Đề : ${item.soDe}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                Text(
                                  'Số Tiền : ${item.soTien}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push<bool>(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SampleItemDetailsView(item: item),
                                ),
                              )
                                  .then((deleted) {
                                if (deleted ?? false) {
                                  viewModel.removeItem(item.id, context);
                                }
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateInput(Map<String, String> input) {
    final String? soDe = input['soDe'];
    final String? soTien = input['soTien'];

    if (soDe != null) {
      if (soDe.contains(RegExp(r'[a-zA-Z]')) ||
          double.tryParse(soDe) == null ||
          double.parse(soDe) <= 0 ||
          double.parse(soDe) >= 100) {
        return false;
      }
    }

    if (soTien != null) {
      if (soTien.contains(RegExp(r'[a-zA-Z]'))) {
        return false;
      }
    }

    return true;
  }
}
