import 'package:flutter/material.dart';

import '../../ui_helper/api_helper.dart';
import '../../ui_helper/db_helper.dart';
import '../../ui_helper/movies_api.dart';
import 'detail_screen.dart';


class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final db = DbHelper();
  List<Map<String, dynamic>> bookMarked = [];

  @override
  void initState() {
    super.initState();
    loadBookmarked();
  }

  Future<void> loadBookmarked() async {
    final data = await db.getAllBookmarks();
    setState(() {
      bookMarked = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 40.0, top: 40, right: 40),
          child: Text(
            "Movies you have added to your watch list:",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "Dongle",
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              childAspectRatio: 0.65,
            ),
            itemCount: bookMarked.length,
            itemBuilder: (context, index) {
              final item = bookMarked[index];
              return InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item["thumbnail"],
                          height: 120,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item["name"],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Dongle",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    print("Tapped movie id: ${item["id"]}");
                    try {
                      Movie_details MovieInfo = await fetchMovieDetails(movieId: item["id"]);
                      print("Fetched movie: ${MovieInfo.title}");
                      Movie info = Movie(
                        id: MovieInfo.id,
                        title: MovieInfo.title,
                        overview: MovieInfo.overview,
                        posterPath: MovieInfo.posterPath,
                        backdropPath: MovieInfo.backdropPath,
                        releaseDate: MovieInfo.releaseDate,
                        voteAverage: MovieInfo.voteAverage,
                        voteCount: MovieInfo.voteCount,
                        originalLanguage: MovieInfo.originalLanguage,
                        popularity: MovieInfo.popularity,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DetailScreen(info: info);
                      }));
                    } catch (e) {
                      print("Error during navigation: $e");
                    }
                  }

              );
            },
          ),
        ),
      ],
    );
  }
}
