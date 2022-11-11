part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatusHasData extends WatchlistState {
  final bool result;
  final String message;

  const WatchlistStatusHasData(this.result, this.message);

  @override
  List<Object?> get props => [result, message];
}

class WatchlistHasData extends WatchlistState {
  final List<MovieTvShow> result;

  const WatchlistHasData(this.result);

  @override
  List<Object?> get props => [result];
}
