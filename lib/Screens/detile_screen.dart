import 'package:flutter/material.dart';

class DetileScreen extends StatelessWidget {
  const DetileScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  final String title, thumb, id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: id,
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: Offset(10, 10),
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
