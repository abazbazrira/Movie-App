// Mocks generated by Mockito 5.2.0 from annotations
// in dicoding_mfde_submission/test/presentation/bloc/movie/now_playing_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:dicoding_mfde_submission/common/failure.dart' as _i6;
import 'package:dicoding_mfde_submission/domain/entities/movie_tv_show.dart'
    as _i7;
import 'package:dicoding_mfde_submission/domain/repositories/movie_tv_show_repository.dart'
    as _i2;
import 'package:dicoding_mfde_submission/domain/usecases/get_now_playing.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieTvShowRepository_0 extends _i1.Fake
    implements _i2.MovieTvShowRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetNowPlaying].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlaying extends _i1.Mock implements _i4.GetNowPlaying {
  MockGetNowPlaying() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieTvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeMovieTvShowRepository_0())
          as _i2.MovieTvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.MovieTvShow>>> execute(
          String? type) =>
      (super.noSuchMethod(Invocation.method(#execute, [type]),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.MovieTvShow>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.MovieTvShow>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.MovieTvShow>>>);
}
