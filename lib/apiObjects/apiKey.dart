import 'dart:convert';

import 'package:http/http.dart';
import 'package:netflix_clone/apiObjects/get_tmdb_data/get_tmdb_data.dart';

const tmdbKey = "bdcab1e2560c5b56d36d5f14d315476c";
const apiRequst =
    'https://api.themoviedb.org/3/movie/550?api_key=bdcab1e2560c5b56d36d5f14d315476c';

class TMDB {
  static const trendingPopular =
      'https://api.themoviedb.org/3/movie/popular?api_key=bdcab1e2560c5b56d36d5f14d315476c&language=en-US&page=1';
  static const topRated =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=bdcab1e2560c5b56d36d5f14d315476c&language=en-US&page=1';

  static const getUpcoming =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=bdcab1e2560c5b56d36d5f14d315476c&language=en-US&page=1';
  static const nowPlaying =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=bdcab1e2560c5b56d36d5f14d315476c&language=en-US&page=1';
  static const latest =
      'https://api.themoviedb.org/3/movie/latest?api_key=bdcab1e2560c5b56d36d5f14d315476c&language=en-US';
  static const similarMovies =
      'https://api.themoviedb.org/3/movie/{movie_id}/similar?api_key=bdcab1e2560c5b56d36d5f14d315476c&language=en-US&page=1';
}

class HttpService {
  Future<List<dynamic>> getTrending(String listType) async {
    Response response = await get(Uri.parse(listType));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      List<dynamic> list = decodedJson['results']
          .map((item) => GetTmdbData.fromJson(item))
          .toList();
      return list;
    } else {
      throw 'Couldn\t get list';
    }
  }

  Future<List<dynamic>> getUpcoming(String listType) async {
    Response res = await get(Uri.parse(listType));
    if (res.statusCode == 200) {
      final decodedJson = jsonDecode(res.body);
      // print(decodedJson);
      List<dynamic> list = decodedJson['results']
          .map((item) => GetTmdbData.fromJson(item))
          .toList();
      return list;
    } else {
      throw 'Couldn\t get list';
    }
  }
}
