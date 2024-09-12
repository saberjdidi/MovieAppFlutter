import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/domain/usecases/get_coming_soon.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';

class GetPopularMock extends Mock implements GetPopular {}

class GetPlayingNowMock extends Mock implements GetPlayingNow {}

class GetComingSoonMock extends Mock implements GetComingSoon {}

main(){
  GetPopularMock getPopularMock;
  GetPlayingNowMock getPlayingNowMock;
  GetComingSoonMock getComingSoonMock;

  MovieTabbedCubit? movieTabbedCubit;

  setUp((){
    getPopularMock = GetPopularMock();
    getPlayingNowMock = GetPlayingNowMock();
    getComingSoonMock = GetComingSoonMock();

    movieTabbedCubit = MovieTabbedCubit(
        getPopular: getPopularMock,
        getPlayingNow: getPlayingNowMock,
        getComingSoon: getComingSoonMock);
  });

  tearDown(() {
    movieTabbedCubit!.close();
  });

  test('bloc should have initial state as [MovieTabbedInitial]', () {
    expect(movieTabbedCubit!.state.runtimeType, MovieTabbedInitial);
  });
}