
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/core/params.dart';
import 'package:music_app/core/usecase.dart';
import 'package:music_app/features/music/domain/repositories/music_repository.dart';

class GetOnPlayerStateChange extends Usecase<Stream<AudioPlayerState>, NoParams> {
  final MusicRepository _repository;

  GetOnPlayerStateChange(this._repository);

  @override
  Future<Either<Failure, Stream<AudioPlayerState>>> call(NoParams params) {
    return _repository.getOnPlayerStateChange();
  }
}
