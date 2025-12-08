import 'package:flutter/material.dart';


import '../../ui_helper/api_helper.dart';
import '../../ui_helper/movies_api.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  List<dynamic> searchList = [];
  List<dynamic> helperList = [];
  late Future<List<Popular_movies>> popularMoviesDetails;
  late Future<List<AiringToday_movies>> airingTodayMoviesDetails;
  late Future<List<TopRated_movies>> topRatedMoviesDetails;

  String selectedCategory = "Popular Movies";

  final List<String> categories = [
    "Popular Movies",
    "Airing Today",
    "Top Rated Movies",
  ];

  Future<Movie> fetchPopularMovieDetails(int index) async {
    List<Popular_movies> movies = await popularMoviesDetails;
    Popular_movies data = movies[index];

    return Movie(
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
  }

  Future<Movie> fetchAiringTodayMovieDetails(int index) async {
    List<AiringToday_movies> movies = await airingTodayMoviesDetails;
    AiringToday_movies data = movies[index];

    return Movie(
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
  }

  Future<Movie> fetchTopRatedMovieDetails(int index) async {
    List<TopRated_movies> movies = await topRatedMoviesDetails;
    TopRated_movies data = movies[index];

    return Movie(
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
  }

  Future<List<dynamic>>? moviesDetails;

  @override
  void initState() {
    super.initState();
    fetchMoviesForCategory(selectedCategory);
  }

  void fetchMoviesForCategory(String category) {
    setState(() {
      searchController.clear();
      searchList.clear();
      helperList.clear();
      if (category == "Popular Movies") {
        moviesDetails = fetchPopularMovies();
      } else if (category == "Airing Today") {
        moviesDetails = fetchAiringTodayMovies();
      } else if (category == "Top Rated Movies") {
        moviesDetails = fetchTopRatedMovies();
      }
    });
  }

  Movie normalizeMovie(dynamic item) {
    // Convert any movie object to a consistent Movie object
    if (selectedCategory == "Popular Movies") {
      return Movie(
        id: item.id,
        title: item.title,
        overview: item.overview,
        posterPath: item.posterPath,
        backdropPath: item.backdropPath,
        releaseDate: item.releaseDate,
        voteAverage: item.voteAverage,
        voteCount: item.voteCount,
        originalLanguage: item.originalLanguage,
        popularity: item.popularity,

      );
    } else {
      return Movie(
        id: item.id,
        title: item.originalName,
        overview: item.overview,
        posterPath: item.posterPath,
        backdropPath: item.backdropPath,
        releaseDate: item.firstAirDate,
        voteAverage: item.voteAverage,
        voteCount: item.voteCount,
        originalLanguage: item.originalLanguage,
        popularity: item.popularity,

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: DropdownButton<String>(
                value: selectedCategory,
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xff305973)),
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xff305973),
                  fontWeight: FontWeight.w500,
                ),
                underline: Container(),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                    fetchMoviesForCategory(newValue);
                  }
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 50),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "Search",
                style: const TextStyle(
                  fontSize: 45,
                  fontFamily: "Dongle",
                  color: Color(0xff305973),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: TextStyle(
              fontFamily: "Dongle",
              fontSize: 30,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            controller: searchController,
            decoration: InputDecoration(
              fillColor: Color(0xff305973),
              filled: true,
              hintText: "${selectedCategory}...",
              hintStyle: TextStyle(
                fontSize: 30,
                fontFamily: "Dongle",
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onChanged: (val) {
              String searchItem = val.toLowerCase();
              if (searchItem.isEmpty) {
                searchList.clear();
              } else {
                searchList = helperList.where((movie) {
                  String name = selectedCategory == "Popular Movies"
                      ? movie.title.toLowerCase()
                      : movie.originalName.toLowerCase();
                  return name.contains(searchItem);
                }).toList();
              }
              setState(() {});
            },
          ),
        ),
        SizedBox(height: 25),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: moviesDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                helperList = snapshot.data!;
                var displayList = searchController.text.isEmpty
                    ? helperList
                    : searchList;

                if (displayList.isEmpty) {
                  return Center(
                    child: Text(
                      "No movies found",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    var item = displayList[index];
                    Movie info = normalizeMovie(item);

                    return InkWell(
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        color: Color(0xff305973),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                height: 120,
                                width: 100,
                                child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${info.posterPath}"),
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 250,
                              child: Text(
                                "${ info.title}",
                                style: TextStyle(
                                  fontFamily: "Dongle",
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(info: info)));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 5, color: Colors.white);
                  },
                );
              } else {
                return const Center(child: Text("No data found"));
              }
            },
          ),
        ),
      ],
    );
  }
}
