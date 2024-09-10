import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_detail_entity.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';
import '../entities/movie_params.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams>{
  final MovieRepository repository;
  
  GetMovieDetail(this.repository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams params) async {
    return await repository.getMovieDetail(params.id);
  }
  
}