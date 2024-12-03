import 'dart:convert';
import 'package:http/http.dart' as http;

class Movies {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;
  String? imdbRating;

  Movies({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
    this.imdbRating,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      title: json['Title'] as String,
      year: json['Year'] as String,
      imdbID: json['imdbID'] as String,
      type: json['Type'] as String,
      poster: json['Poster'] as String,
    );
  }

  static Future<Movies> fetchDetails(String apiKey, Movies movie) async {
    final url = 'https://www.omdbapi.com/?i=${movie.imdbID}&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      movie.imdbRating = json['imdbRating'] as String?;
    } else {
      throw Exception('ratings not found');
    }
    return movie;
  }

  static Future<List<Movies>> fetchAllMovies(String apiKey, String request) async {

    final response = await http.get(Uri.parse('https://www.omdbapi.com/?s=$request&apikey=$apiKey'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['Search'] != null) {
        List<Movies> movies = (jsonResponse['Search'] as List).map((json) => Movies.fromJson(json)).toList();
        for (var i = 0; i < movies.length; i++) {
          movies[i] = await fetchDetails(apiKey,movies[i]);
        }
        return movies;
      }

    } else {
      throw Exception('response error');

    }
    throw Exception('Failed to load movie list');

  }
}