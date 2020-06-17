import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/core/params.dart';
import 'package:music_app/features/player/domain/usecases/pause_music.dart';
import 'package:music_app/features/player/domain/usecases/play_music.dart';
import 'package:music_app/features/player/domain/usecases/resume_music.dart';
import 'package:music_app/features/player/domain/usecases/stop_music.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {

  final PlayMusic _playMusic;
  final StopMusic _stopMusic;
  final PauseMusic _pauseMusic;
  final ResumeMusic _resumeMusic;

  PlayerBloc(this._playMusic, this._stopMusic, this._pauseMusic, this._resumeMusic);

  @override
  PlayerState get initialState => PlayerInitial();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is PlayMusicEvent) {
      final play = await _playMusic(event.songPath);
      yield* _handleEither(play, MusicPlaying(event.songPath));
    }
    if (event is StopMusicEvent) {
       final stop = await _stopMusic(NoParams());
       yield* _handleEither(stop, MusicStopped());
    }
    if (event is PauseMusicEvent) {
      final pause = await _pauseMusic(NoParams());
      yield* _handleEither(pause, MusicPaused(event.songPath));
    }
    if (event is ResumeMusicEvent) {
      final resume = await _resumeMusic(NoParams());
      yield* _handleEither(resume, MusicPlaying(event.songPath));
    }
  }

  Stream<PlayerState> _handleEither(Either<Failure, void> either, PlayerState nextState) async* {
    yield either.fold((failure) => PlayerFailureState(failure.message), (success) => nextState);
  }

}
