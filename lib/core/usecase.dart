
import 'package:dartz/dartz.dart';
import 'package:music_app/core/errors/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
