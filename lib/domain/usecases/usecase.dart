import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';

abstract class UseCase<Type, Params> {
  ///Type : what does the usecase return => Output
  ///Params : What is required to call API => Input

  Future<Either<AppError, Type>> call(Params params);
}