// To parse this JSON data, do
//
//     final movies = moviesFromJson(jsonString);

import 'dart:convert';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

String moviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
    Movies({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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

class Result {
    Result({
        this.video,
        this.voteAverage,
        this.overview,
        this.releaseDate,
        this.adult,
        this.backdropPath,
        this.voteCount,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.title,
        this.popularity,
        this.mediaType,
        this.originCountry,
        this.name,
        this.firstAirDate,
        this.originalName,
    });

    bool video;
    double voteAverage;
    String overview;
    DateTime releaseDate;
    bool adult;
    String backdropPath;
    int voteCount;
    List<int> genreIds;
    int id;
    OriginalLanguage originalLanguage;
    String originalTitle;
    String posterPath;
    String title;
    double popularity;
    MediaType mediaType;
    List<String> originCountry;
    String name;
    DateTime firstAirDate;
    String originalName;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath: json["backdrop_path"],
        voteCount: json["vote_count"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"] == null ? null : json["original_title"],
        posterPath: json["poster_path"],
        title: json["title"] == null ? null : json["title"],
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map[json["media_type"]],
        originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
        originalName: json["original_name"] == null ? null : json["original_name"],
    );

    Map<String, dynamic> toJson() => {
        "video": video == null ? null : video,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath,
        "vote_count": voteCount,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle == null ? null : originalTitle,
        "poster_path": posterPath,
        "title": title == null ? null : title,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
        "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => x)),
        "name": name == null ? null : name,
        "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "original_name": originalName == null ? null : originalName,
    };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues = EnumValues({
    "movie": MediaType.MOVIE,
    "tv": MediaType.TV
});

enum OriginalLanguage { EN, JA, TR, PL }

final originalLanguageValues = EnumValues({
    "en": OriginalLanguage.EN,
    "ja": OriginalLanguage.JA,
    "pl": OriginalLanguage.PL,
    "tr": OriginalLanguage.TR
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
