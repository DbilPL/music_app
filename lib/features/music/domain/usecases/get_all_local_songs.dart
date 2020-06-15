
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/core/params.dart';
import 'package:music_app/core/usecase.dart';
import 'package:music_app/features/music/domain/repositories/music_repository.dart';

class GetAllLocalSongs extends Usecase<List<SongInfo>, NoParams> {
  final MusicRepository _repository;

  GetAllLocalSongs(this._repository);

  @override
  Future<Either<Failure, List<SongInfo>>> call(NoParams params) {
    return _repository.getAllLocalSongs();
  }
  
}
