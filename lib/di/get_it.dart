import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_sources/authentication_local_data_source.dart';
import 'package:movieapp/data/data_sources/authentication_remote_data_source.dart';
import 'package:movieapp/data/data_sources/language_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/repositories/app_repository_impl.dart';
import 'package:movieapp/data/repositories/authentication_repository_impl.dart';
import 'package:movieapp/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';
import 'package:movieapp/domain/repositories/authentication_repository.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/check_if_movie_favorite.dart';
import 'package:movieapp/domain/usecases/delete_favorite_movie.dart';
import 'package:movieapp/domain/usecases/get_cast.dart';
import 'package:movieapp/domain/usecases/get_favorite_movies.dart';
import 'package:movieapp/domain/usecases/get_movie_detail.dart';
import 'package:movieapp/domain/usecases/get_preferred_language.dart';
import 'package:movieapp/domain/usecases/get_preferred_theme.dart';
import 'package:movieapp/domain/usecases/get_videos.dart';
import 'package:movieapp/domain/usecases/login_user.dart';
import 'package:movieapp/domain/usecases/logout_user.dart';
import 'package:movieapp/domain/usecases/save_movie.dart';
import 'package:movieapp/domain/usecases/update_language.dart';
import 'package:movieapp/domain/usecases/update_theme.dart';
import 'package:movieapp/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:movieapp/presentation/blocs/language/language_cubit.dart';
import 'package:movieapp/presentation/blocs/loading/loading_cubit.dart';
import 'package:movieapp/presentation/blocs/login/login_cubit.dart';
import 'package:movieapp/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/theme/theme_cubit.dart';

import '../domain/usecases/get_coming_soon.dart';
import '../domain/usecases/get_playing_now.dart';
import '../domain/usecases/get_popular.dart';
import '../domain/usecases/get_trending.dart';
import '../domain/usecases/search_movies.dart';
import '../presentation/blocs/cast/cast_cubit.dart';
import '../presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import '../presentation/blocs/movie_detail/movie_detail_cubit.dart';
import '../presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import '../presentation/blocs/search_movie/search_movie_cubit.dart';
import '../presentation/blocs/videos/videos_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  
  // * API Client INJECTION
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  //getItInstance.registerLazySingleton<Dio>(() => Dio());

  // * REPOSITORY & DATA SOURCES INJECTION
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRepository>(
          () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
          () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
          () => AuthenticationLocalDataSourceImpl());

  // * USE CASES INJECTION
  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(() => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(() => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance.registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(() => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(() => DeleteFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(() => CheckIfFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(() => GetPreferredLanguage(getItInstance()));
  getItInstance.registerLazySingleton<UpdateLanguage>(() => UpdateLanguage(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferredTheme>(() => GetPreferredTheme(getItInstance()));
  getItInstance.registerLazySingleton<UpdateTheme>(() => UpdateTheme(getItInstance()));

  getItInstance.registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance.registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));

  // * CUBITS INJECTION
  getItInstance.registerFactory(() => MovieCarouselCubit(
      getTrending: getItInstance(),
      movieBackdropCubit: getItInstance(),
      loadingCubit: getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropCubit());

  getItInstance.registerFactory(
        () => MovieTabbedCubit(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
        () => SearchMovieCubit(
      loadingCubit: getItInstance(),
      searchMovies: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  
  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    getPreferredTheme: getItInstance(),
    updateTheme: getItInstance(),
  ));

  getItInstance.registerSingleton<LoginCubit>(LoginCubit(
    loginUser: getItInstance(),
    logoutUser: getItInstance(),
    loadingCubit: getItInstance(),
  ));

 /* getItInstance.registerFactory(() => LoginCubit(
    loginUser: getItInstance(),
    logoutUser: getItInstance(),
    loadingCubit: getItInstance(),
  )); */

  getItInstance.registerFactory(
        () => MovieDetailCubit(
      loadingCubit: getItInstance(),
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosCubit: getItInstance(),
      favoriteCubit: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => FavoriteCubit(
    saveMovie: getItInstance(),
    checkIfFavoriteMovie: getItInstance(),
    deleteFavoriteMovie: getItInstance(),
    getFavoriteMovies: getItInstance(),
  ));

  getItInstance.registerFactory(
        () => CastCubit(
      getCast: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
        () => VideosCubit(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => SearchMovieCubit(
      searchMovies: getItInstance(),
      loadingCubit: getItInstance()));

}