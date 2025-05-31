import 'package:first_app/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';

class FavWebtoons extends StatelessWidget {
  const FavWebtoons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          "즐겨찾기",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
        ),
      ),
      body: Center(child: Text("Hello")),
      bottomNavigationBar: BottomWidget(),
    );
  }
}
