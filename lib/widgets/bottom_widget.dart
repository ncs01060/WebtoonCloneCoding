import 'package:first_app/Screens/fav_webtoons.dart';
import 'package:first_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  late SharedPreferences pref;
  bool playdis = false;
  bool playfav = false;

  Future initDisplay() async {
    pref = await SharedPreferences.getInstance();
    final display = pref.getString('Display');
    if (display != null) {
      if (display == 'home') {
        setState(() {
          playdis = true;
        });
      } else {
        setState(() {
          playfav = true;
        });
      }
    } else {
      pref.setString('Display', 'home');
    }
  }

  @override
  void initState() {
    super.initState();
    initDisplay();
  }

  onClickDisplay() async {
    final display = pref.getString('Display');
    if (display != null) {
      if (playdis) {
      } else {
        pref.setString('Display', 'home');
        setState(() {
          playdis = true;
          playfav = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false, // 🔥 모든 기존 라우트를 제거
        );
      }
    }
  }

  onClickFav() async {
    final display = pref.getString('Display');
    if (display != null) {
      if (playfav) {
      } else {
        pref.setString('Display', 'fav');
        setState(() {
          playdis = false;
          playfav = true;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => FavWebtoons()),
          (route) => false, // 🔥 모든 기존 라우트를 제거
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(1, 1),
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onClickDisplay,
            color: Colors.green,
            icon: playdis ? Icon(Icons.home) : Icon(Icons.home_outlined),
            iconSize: 40,
          ),
          IconButton(
            onPressed: onClickFav,
            color: Colors.green,
            icon: playfav ? Icon(Icons.favorite) : Icon(Icons.favorite_outline),
            iconSize: 40,
          ),
        ],
      ),
    );
  }
}
