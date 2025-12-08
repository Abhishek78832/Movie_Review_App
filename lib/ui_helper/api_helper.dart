import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import 'movies_api.dart';

Future<List<Popular_movies>> fetchPopularMovies() async {
  String url = "https://api.themoviedb.org/3/movie/popular";
  var headers = {
    "Accept": "application/json",
    "Authorization":
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2NlNzVhOGQxMzRjMGI3MGRhYWUyN2ZjNWNmNzdkNiIsIm5iZiI6MTc1OTc2Mjc5NC4xMTMsInN1YiI6IjY4ZTNkOTZhMmE1YTQxZWQyZjYxN2Q2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TTpJPCNjOTmZte_g9n3hRxxQ2mlZ2mzSOXyAwjzVsJA",
  };
  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> result = data["results"];
      List<Popular_movies> info = await result.map((val) {
        return Popular_movies.fromJson(val);
      }).toList();
      return info;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (ex) {
    throw Exception("Error fetching data: $ex");
  }
}

Future<List<AiringToday_movies>> fetchAiringTodayMovies() async {
  String url = "https://api.themoviedb.org/3/tv/airing_today";
  var headers = {
    "Accept": "application/json",
    "Authorization":
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2NlNzVhOGQxMzRjMGI3MGRhYWUyN2ZjNWNmNzdkNiIsIm5iZiI6MTc1OTc2Mjc5NC4xMTMsInN1YiI6IjY4ZTNkOTZhMmE1YTQxZWQyZjYxN2Q2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TTpJPCNjOTmZte_g9n3hRxxQ2mlZ2mzSOXyAwjzVsJA",
  };
  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> result = data["results"];
      List<AiringToday_movies> info = await result.map((val) {
        return AiringToday_movies.fromJson(val);
      }).toList();
      return info;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (ex) {
    throw Exception("Error fetching data: $ex");
  }
}

Future<List<TopRated_movies>> fetchTopRatedMovies() async {
  String url = "https://api.themoviedb.org/3/tv/top_rated";
  var headers = {
    "Accept": "application/json",
    "Authorization":
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2NlNzVhOGQxMzRjMGI3MGRhYWUyN2ZjNWNmNzdkNiIsIm5iZiI6MTc1OTc2Mjc5NC4xMTMsInN1YiI6IjY4ZTNkOTZhMmE1YTQxZWQyZjYxN2Q2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TTpJPCNjOTmZte_g9n3hRxxQ2mlZ2mzSOXyAwjzVsJA",
  };
  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> result = data["results"];
      List<TopRated_movies> info = await result.map((val) {
        return TopRated_movies.fromJson(val);
      }).toList();
      return info;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (ex) {
    throw Exception("Error fetching data: $ex");
  }
}

Future<List<Thumbnail>> fetchMovieVideos({required int? movieId}) async {
  final String url =
      "https://api.themoviedb.org/3/movie/$movieId/videos?api_key=27ce75a8d134c0b70daae27fc5cf77d6&language=en-US";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['results'] == null) {
        throw Exception("No results found for this movie.");
      }

      List<dynamic> results = data['results'];
      List<Thumbnail> videos =
      results.map((item) => Thumbnail.fromJson(item)).toList();
      print(videos[0].key);
      return videos;
    } else {
      throw Exception("Failed to load videos: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error fetching videos: $e");
  }
}

Future<Movie_details> fetchMovieDetails({required int? movieId}) async{

  String url = "https://api.themoviedb.org/3/movie/${movieId}?";
  var headers = {
    "Accept": "application/json",
    "Authorization":
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2NlNzVhOGQxMzRjMGI3MGRhYWUyN2ZjNWNmNzdkNiIsIm5iZiI6MTc1OTc2Mjc5NC4xMTMsInN1YiI6IjY4ZTNkOTZhMmE1YTQxZWQyZjYxN2Q2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TTpJPCNjOTmZte_g9n3hRxxQ2mlZ2mzSOXyAwjzVsJA",
  };
  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Movie_details result = Movie_details.fromJson(data);
      return result;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (ex) {
    throw Exception("Error fetching data: $ex");
  }
}

Future<List<Reviews>> fetchReviewDetails({required int? movieId}) async{
  print("api calling started");
  String url = "https://api.themoviedb.org/3/movie/${movieId}/reviews";
  var headers = {
    "Accept": "application/json",
    "Authorization":
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2NlNzVhOGQxMzRjMGI3MGRhYWUyN2ZjNWNmNzdkNiIsIm5iZiI6MTc1OTc2Mjc5NC4xMTMsInN1YiI6IjY4ZTNkOTZhMmE1YTQxZWQyZjYxN2Q2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TTpJPCNjOTmZte_g9n3hRxxQ2mlZ2mzSOXyAwjzVsJA",
  };
  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    print("api calling is on the way...");
    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      if(data["results"] == null){
        throw Exception("No review found on this movie");
      }
      List<dynamic> result = await data["results"];
      List<Reviews> list = await result.map((val) { return Reviews.fromJson(val);}).toList();
      print(list[0]);
      return list;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (ex) {
    print("api calling gets busy...");
    throw Exception("Error fetching data: $ex");
  }
}


