import 'package:first_app/models/webtoon_detaile_model.dart';
import 'package:first_app/models/webtoon_episode_model.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/widgets/Episodes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetileScreen extends StatefulWidget {
  const DetileScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  final String title, thumb, id;

  @override
  State<DetileScreen> createState() => _DetileScreenState();
}

class _DetileScreenState extends State<DetileScreen> {
  late Future<WebtoonDetaileModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  late SharedPreferences pref;

  bool isLiked = false;

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();

    final likedToons = pref.getStringList('likedToons');

    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await pref.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodoesById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await pref.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: widget.id,
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
                            widget.thumb,
                            headers: const {
                              "User-Agent":
                                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  FutureBuilder(
                    future: webtoon,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.about,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 15),
                            Text(
                              '${snapshot.data!.genre} / ${snapshot.data!.age}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      } else {
                        return Text("...");
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  FutureBuilder(
                    future: episodes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            for (var episode
                                in snapshot.data!.length > 10
                                    ? snapshot.data!.sublist(0, 10)
                                    : snapshot.data!)
                              Episodes(episode: episode, webtoonId: widget.id),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
