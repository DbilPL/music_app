
import 'package:music_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase.dart';
import 'package:music_app/features/player/domain/repositories/player_repository.dart';

class PlayMusic extends Usecase<void, String> {
  final PlayerRepository _repository;

  PlayMusic(this._repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return _repository.playMusic(params);
  }
  
}
