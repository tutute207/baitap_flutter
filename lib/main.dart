

import 'package:flutter/material.dart';

import 'SampleItemListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản Lý Đánh Đề',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleItemListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}