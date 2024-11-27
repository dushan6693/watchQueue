import 'dart:convert';
import 'package:http/http.dart' as http;
Movie moviesFromJson(String str) => Movie.fromJson(json.decode(str));

String moviesToJson(Movie data) => json.encode(data.toJson());

class Movie {
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  List<Rating> ratings;
  String metaScore;
  String imdbRating;
  String imdbVotes;
  String imdbId;
  String type;
  String dvd;
  String boxOffice;
  String production;
  String website;
  String response;
  String totalSeasons;

  Movie({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metaScore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
    required this.response,
    required this.totalSeasons,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    title: json["Title"],
    year: json["Year"]??'N/A',
    rated: json["Rated"]??'N/A',
    released: json["Released"]??'N/A',
    runtime: json["Runtime"]??'N/A',
    genre: json["Genre"]??'N/A',
    director: json["Director"]??'N/A',
    writer: json["Writer"]??'N/A',
    actors: json["Actors"]??'N/A',
    plot: json["Plot"]??'N/A',
    language: json["Language"]??'N/A',
    country: json["Country"]??'N/A',
    awards: json["Awards"]??'N/A',
    poster: json["Poster"],
    ratings: List<Rating>.from(json["Ratings"].map((x) => Rating.fromJson(x))),
    metaScore: json["Metascore"]??'N/A',
    imdbRating: json["imdbRating"]??'N/A',
    imdbVotes: json["imdbVotes"]??'N/A',
    imdbId: json["imdbID"],
    type: json["Type"],
    dvd: json["DVD"]??'N/A',
    boxOffice: json["BoxOffice"]??'N/A',
    production: json["Production"]??'N/A',
    website: json["Website"]??'N/A',
    response: json["Response"],
    totalSeasons: json["totalSeasons"]??'-',
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Year": year,
    "Rated": rated,
    "Released": released,
    "Runtime": runtime,
    "Genre": genre,
    "Director": director,
    "Writer": writer,
    "Actors": actors,
    "Plot": plot,
    "Language": language,
    "Country": country,
    "Awards": awards,
    "Poster": poster,
    "Ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
    "Metascore": metaScore,
    "imdbRating": imdbRating,
    "imdbVotes": imdbVotes,
    "imdbID": imdbId,
    "Type": type,
    "DVD": dvd,
    "BoxOffice": boxOffice,
    "Production": production,
    "Website": website,
    "Response": response,
    "totalSeasons":totalSeasons
  };
  static Future<Movie> fetchDetails(String apiKey, String imdbID) async {
    final url = 'https://www.omdbapi.com/?i=$imdbID&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Movie.fromJson(json);
    } else {
      throw Exception('ratings not found');
    }
  }
}

class Rating {
  String source;
  String value;

  Rating({
    required this.source,
    required this.value,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    source: json["Source"]??'N/A',
    value: json["Value"]??'N/A',
  );

  Map<String, dynamic> toJson() => {
    "Source": source,
    "Value": value,
  };
}
