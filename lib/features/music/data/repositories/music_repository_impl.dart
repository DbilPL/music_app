
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/features/music/data/datasource/music_data_source.dart';
import 'package:music_app/features/music/data/model/link_group_model.dart';
import 'package:music_app/features/music/domain/repositories/music_repository.dart';

class MusicRepositoryImpl extends MusicRepository {

  final MusicDataSource _dataSource;
  final DataConnectionChecker _connectionChecker;


  MusicRepositoryImpl(this._dataSource, this._connectionChecker);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() method) async {
    try {
      final T result = await method();

      return Right(result);
    }
    catch (e) {
      return Left(Failure('Something went wrong! $e'));
    }
  }

  @override
  Future<Either<Failure, List<SongInfo>>> getAllLocalSongs() async {
    return _handleCalls<List<SongInfo>>(_dataSource.getAllLocalSongs);
  }
  @override
  Future<Either<Failure, Stream<Duration>>> getOnAudioPositionChanged() {
    return _handleCalls<Stream<Duration>>(_dataSource.getOnAudioPositionChanged);
  }

    @override
  Future<Either<Failure, Stream<AudioPlayerState>>> getOnPlayerStateChange() {
    return _handleCalls<Stream<AudioPlayerState>>(_dataSource.getOnPlayerStateChange);
  }

  @override
  Future<Either<Failure, LinkGroupModel>> getLinks(String trackName, String artistName) async {
    try {
        if (await _connectionChecker.hasConnection) {
      final LinkGroupModel result = await _dataSource.getLinks(trackName, artistName);

      return Right(result);
      }
      else {
        return Left(Failure('No connection to internet!'));
      }
    }
    catch (e) {
      return Left(Failure('Something went wrong! $e'));
    }
  }
  
}
