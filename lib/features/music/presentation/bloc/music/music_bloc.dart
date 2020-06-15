import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/core/params.dart';
import 'package:music_app/features/music/domain/usecases/get_all_local_songs.dart';
import 'package:music_app/features/music/domain/usecases/get_on_audio_position_changed.dart';
import 'package:music_app/features/music/domain/usecases/get_on_player_state_change.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {

  final GetAllLocalSongs _getAllLocalSongs;
  final GetOnAudioPositionChanged _getOnAudioPositionChanged;
  final GetOnPlayerStateChange _getOnPlayerStateChange;
  

  MusicBloc(this._getAllLocalSongs, this._getOnAudioPositionChanged, this._getOnPlayerStateChange);

  @override
  MusicState get initialState => MusicInitial();

  @override
  Stream<MusicState> mapEventToState(
    MusicEvent event,
  ) async* {
    if (event is LoadMusic) {

      yield MusicLoadingState();

      final music = await _getAllLocalSongs(NoParams());

      yield await music.fold((failure) => FailureMusicState(failure.message),
       (songs) async {
         final status = await _getOnAudioPositionChanged(NoParams());

         return await status.fold((failure) => FailureMusicState(failure.message), (durationStream) async {
           final failureOrStream = await _getOnPlayerStateChange(NoParams());
           return failureOrStream.fold(
             (failure) => FailureMusicState(failure.message), 
             (playerStateStream) => MusicLoaded(songs, durationStream, playerStateStream),
            );
         });
      });
    }
    
  }
}
