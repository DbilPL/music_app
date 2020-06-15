import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      await _playMusic(event.songPath);
      yield MusicPlaying(event.songPath);
    }
    if (event is StopMusicEvent) {
       await _stopMusic(NoParams());
       yield MusicStopped();
    }
    if (event is PauseMusicEvent) {
      await _pauseMusic(NoParams());
      yield MusicPaused(event.songPath);
    }
    if (event is ResumeMusicEvent) {
      await _resumeMusic(NoParams());
      yield MusicPlaying(event.songPath);
    }
  }
}
