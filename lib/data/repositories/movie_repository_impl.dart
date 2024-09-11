import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp/data/data_sources/movie_local_data_source.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/models/movie_model.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';

import '../../domain/entities/app_error.dart';
import '../models/cast_crew_result_data_model.dart';
import '../models/video_model.dart';
import '../tables/movie_table.dart';

class MovieRepositoryImpl extends MovieRepository {

   final MovieRemoteDataSource remoteDataSource;
   final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

   @override
   Future<Either<AppError, List<MovieModel>>> getTrending() async {
     try {
       final movies = await remoteDataSource.getTrending();
       return Right(movies);
     } on SocketException {
       return const Left(AppError(AppErrorType.network));
     } on Exception {
       return const Left(AppError(AppErrorType.api));
     }
   }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try{
      final movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getSearchedMovies(String searchTerm) async {
    try{
       final movies = await remoteDataSource.getSearchedMovies(searchTerm);
       return Right(movies);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

   @override
   Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
     try {
       final castCrew = await remoteDataSource.getCastCrew(id);
       return Right(castCrew);
     } on SocketException {
       return Left(AppError(AppErrorType.network));
     } on Exception {
       return Left(AppError(AppErrorType.api));
     }
   }

   @override
   Future<Either<AppError, List<VideoModel>>> getVideos(int id) async {
     try {
       final videos = await remoteDataSource.getVideos(id);
       return Right(videos);
     } on SocketException {
       return Left(AppError(AppErrorType.network));
     } on Exception {
       return Left(AppError(AppErrorType.api));
     }
   }

   @override
   Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId) async {
     try {
       final response = await localDataSource.checkIfMovieFavorite(movieId);
       return Right(response);
     } on Exception {
       return Left(AppError(AppErrorType.database));
     }
   }

   @override
   Future<Either<AppError, void>> deleteFavoriteMovie(int movieId) async {
     try {
       final response = await localDataSource.deleteMovie(movieId);
       return Right(response);
     } on Exception {
       return Left(AppError(AppErrorType.database));
     }
   }

   @override
   Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies() async {
     try {
       final response = await localDataSource.getMovies();
       return Right(response);
     } on Exception {
       return Left(AppError(AppErrorType.database));
     }
   }

   @override
   Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
     try {
       final table = MovieTable.fromMovieEntity(movieEntity);
       print(table);
       final response = await localDataSource
           .saveMovie(MovieTable.fromMovieEntity(movieEntity));
       return Right(response);
     } on Exception {
       return Left(AppError(AppErrorType.database));
     }
   }

}