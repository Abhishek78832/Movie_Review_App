import 'package:flutter/material.dart';

import '../../ui_helper/api_helper.dart';
import '../../ui_helper/movies_api.dart';
import 'detail_screen.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late Future<List<Popular_movies>> popularMoviesDetails;
  late Future<List<AiringToday_movies>> airingTodayMoviesDetails;
  late Future<List<TopRated_movies>> topRatedMoviesDetails;

  @override
  void initState() {
    super.initState();
    popularMoviesDetails = fetchPopularMovies();
    airingTodayMoviesDetails = fetchAiringTodayMovies();
    topRatedMoviesDetails = fetchTopRatedMovies();

  }

  Future<Movie> fetchPopularMovieDetails(int index) async {

    List<Popular_movies> movies = await popularMoviesDetails;

    Popular_movies data = movies[index];

    Movie info = Movie(
      id: data.id,
      title: data.title,
      overview: data.overview,
      posterPath: data.posterPath,
      backdropPath: data.backdropPath,
      releaseDate: data.releaseDate,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
      originalLanguage: data.originalLanguage,
      popularity: data.popularity,

    );


    return info;
  }

  Future<Movie> fetchAiringTodayMovieDetails(int index) async {

    List<AiringToday_movies> movies = await airingTodayMoviesDetails;

    AiringToday_movies data = movies[index];

    Movie info = Movie(
      id: data.id,
      title: data.originalName,
      overview: data.overview,
      posterPath: data.posterPath,
      backdropPath: data.backdropPath,
      releaseDate: data.firstAirDate,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
      originalLanguage: data.originalLanguage,
      popularity: data.popularity,

    );


    return info;
  }

  Future<Movie> fetchTopRatedMovieDetails(int index) async {

    List<TopRated_movies> movies = await topRatedMoviesDetails;

    TopRated_movies data = movies[index];

    Movie info = Movie(
      id: data.id,
      title: data.originalName,
      overview: data.overview,
      posterPath: data.posterPath,
      backdropPath: data.backdropPath,
      releaseDate: data.firstAirDate,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
      originalLanguage: data.originalLanguage,
      popularity: data.popularity,

    );


    return info;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<Popular_movies>>(
                future: popularMoviesDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    final movieData = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Popular Movies",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontFamily: "Dongle",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieData.length,
                            itemBuilder: (context, index) {
                              final info = movieData[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey[200],
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/w500/${info.posterPath}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      onTap: () async {
                                        Movie info = await fetchPopularMovieDetails(index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(info: info),
                                          ),
                                        );
                                      },

                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        "${info.title}",
                                        style: const TextStyle(
                                          fontFamily: "Dongle",
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 20),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${info.voteAverage?.toStringAsFixed(1) ?? 'N/A'}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Dongle",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text("No data found"));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<AiringToday_movies>>(
                future: airingTodayMoviesDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    final movieData = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Airing today Movies",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontFamily: "Dongle",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieData.length,
                            itemBuilder: (context, index) {
                              final info = movieData[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey[200],
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/w500/${info.posterPath}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      onTap: () async {
                                        Movie info = await fetchAiringTodayMovieDetails(index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(info: info),
                                          ),
                                        );
                                      },

                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        "${info.originalName}",
                                        style: const TextStyle(
                                          fontFamily: "Dongle",
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 20),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${info.voteAverage?.toStringAsFixed(1) ?? 'N/A'}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Dongle",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text("No data found"));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<TopRated_movies>>(
                future: topRatedMoviesDetails,
                builder: (context, snapshot)  {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    final movieData = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Top Rated Movies",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontFamily: "Dongle",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 260,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieData.length,
                            itemBuilder: (context, index) {
                              final info = movieData[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey[200],
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/w500/${info.posterPath}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      onTap: () async {
                                        Movie info = await fetchTopRatedMovieDetails(index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(info: info),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        "${info.originalName}",
                                        style: const TextStyle(
                                          fontFamily: "Dongle",
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size: 20),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${info.voteAverage?.toStringAsFixed(1) ?? 'N/A'}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Dongle",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    );
                  } else {
                    return const Center(child: Text("No data found"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
