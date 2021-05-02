// To parse this JSON data, do
//
//     final tvShows = tvShowsFromJson(jsonString);

import 'dart:convert';

TvShows tvShowsFromJson(String str) => TvShows.fromJson(json.decode(str));

String tvShowsToJson(TvShows data) => json.encode(data.toJson());

class TvShows {
    TvShows({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int page;
    List<Results> results;
    int totalPages;
    int totalResults;

    factory TvShows.fromJson(Map<String, dynamic> json) => TvShows(
        page: json["page"],
        results: List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Results {
    Results({
        this.backdropPath,
        this.firstAirDate,
        this.genreIds,
        this.id,
        this.name,
        this.title,
        this.originCountry,
        this.originalLanguage,
        this.originalName,
        this.overview,
        this.popularity,
        this.posterPath,
        this.voteAverage,
        this.voteCount,
    });

    String backdropPath;
    DateTime firstAirDate;
    List<int> genreIds;
    int id;
    String name;
    String title;
    List<String> originCountry;
    OriginalLanguage originalLanguage;
    String originalName;
    String overview;
    double popularity;
    String posterPath;
    double voteAverage;
    int voteCount;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        backdropPath: json["backdrop_path"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

enum OriginalLanguage { ES, EN, DE, FR }

final originalLanguageValues = EnumValues({
    "de": OriginalLanguage.DE,
    "en": OriginalLanguage.EN,
    "es": OriginalLanguage.ES,
    "fr": OriginalLanguage.FR
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
