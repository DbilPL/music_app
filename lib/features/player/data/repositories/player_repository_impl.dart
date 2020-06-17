
import 'package:dartz/dartz.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/features/player/data/datasource/player_data_source.dart';
import 'package:music_app/features/player/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl extends PlayerRepository {

  final PlayerDataSource _dataSource;

  PlayerRepositoryImpl(this._dataSource);

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
  Future<Either<Failure, void>> playMusic(String pathToMusic) async {
    try {
      final result = await _dataSource.playMusic(pathToMusic);

      return Right(result);
    }
    catch (e) {
      return Left(Failure('Something went wrong! $e'));
    }
  }

  @override
  Future<Either<Failure, void>> pauseMusic() {
    return _handleCalls<void>(_dataSource.pauseMusic);
  }

  @override
  Future<Either<Failure, void>> resumeMusic() {
    return _handleCalls<void>(_dataSource.resumeMusic);
  }

  @override
  Future<Either<Failure, void>> stopMusic() {
    return _handleCalls<void>(_dataSource.stopMusic);
  }
  
}
