
import 'package:dartz/dartz.dart';
import 'package:music_app/core/errors/failure.dart';

abstract class PlayerRepository {

  Future<Either<Failure, void>> playMusic(String pathToMusic);

  Future<Either<Failure, void>> pauseMusic();

  Future<Either<Failure, void>> resumeMusic();

  Future<Either<Failure, void>> stopMusic();
}
