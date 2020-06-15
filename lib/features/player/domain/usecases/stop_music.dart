
import 'package:music_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/core/params.dart';
import 'package:music_app/core/usecase.dart';
import 'package:music_app/features/player/domain/repositories/player_repository.dart';

class StopMusic extends Usecase<void, NoParams> {
  final PlayerRepository _repository;

  StopMusic(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.stopMusic();
  }
  
}
