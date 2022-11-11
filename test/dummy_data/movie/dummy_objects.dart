import 'package:dicoding_mfde_submission/common/constants.dart';
import 'package:dicoding_mfde_submission/data/models/movie_tv_show_table.dart';
import 'package:dicoding_mfde_submission/domain/entities/genre.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart';
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show_detail.dart';

final testMovie = MovieTvShow(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
  type: 'movie',
);

final testMovieList = [testMovie];

const testMovieDetail = MovieTvShowDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
  type: 'movie',
);

final testWatchlistMovie = MovieTvShow.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

const testMovieTable = MovieTvShowTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

const testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': movies,
};
