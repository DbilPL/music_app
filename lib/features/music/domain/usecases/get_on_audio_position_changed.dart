
import 'package:music_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/core/params.dart';
import 'package:music_app/core/usecase.dart';
import 'package:music_app/features/music/domain/repositories/music_repository.dart';

class GetOnAudioPositionChanged extends Usecase<Stream<Duration>, NoParams> {
  final MusicRepository _repository;

  GetOnAudioPositionChanged(this._repository);

  @override
  Future<Either<Failure, Stream<Duration>>> call(NoParams params) {
    return _repository.getOnAudioPositionChanged();
  }
  
}
