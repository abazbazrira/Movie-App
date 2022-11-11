import 'package:equatable/equatable.dart';

class MovieTvShow extends Equatable {
  MovieTvShow({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.type,
  });

  MovieTvShow.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.type,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? type;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        type,
      ];
}
