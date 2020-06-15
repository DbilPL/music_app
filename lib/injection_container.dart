import 'package:audioplayers/audioplayers.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/music/data/datasource/music_data_source.dart';
import 'package:music_app/features/music/data/repositories/music_repository_impl.dart';
import 'package:music_app/features/music/domain/usecases/get_all_local_songs.dart';
import 'package:music_app/features/music/domain/usecases/get_links.dart';
import 'package:music_app/features/music/domain/usecases/get_on_audio_position_changed.dart';
import 'package:music_app/features/music/domain/usecases/get_on_player_state_change.dart';
import 'package:music_app/features/player/data/datasource/player_data_source.dart';
import 'package:music_app/features/player/data/repositories/player_repository_impl.dart';
import 'package:music_app/features/player/domain/usecases/pause_music.dart';
import 'package:music_app/features/player/domain/usecases/play_music.dart';
import 'package:music_app/features/player/domain/usecases/resume_music.dart';
import 'package:music_app/features/player/domain/usecases/stop_music.dart';
import 'package:music_app/features/player/presentation/bloc/player_bloc.dart';

import 'features/music/presentation/bloc/music/music_bloc.dart';
import 'features/music/presentation/bloc/music_view/music_view_bloc.dart';

final GetIt sl = GetIt.instance;

void init() {

  // Third part dependecy

  sl.registerSingleton(FlutterAudioQuery());
  sl.registerSingleton(AudioPlayer());
  sl.registerSingleton(DataConnectionChecker());
  sl.registerSingleton(Dio(
    BaseOptions(
      connectTimeout: 3000,
      receiveTimeout: 3000,
      sendTimeout: 3000
    ),
  ));

  // Music feature

  sl.registerSingleton(MusicDataSourceImpl(sl<FlutterAudioQuery>(), sl<AudioPlayer>(), sl<Dio>()));

  sl.registerSingleton(MusicRepositoryImpl(sl<MusicDataSourceImpl>(), sl<DataConnectionChecker>()));

  sl.registerSingleton(GetAllLocalSongs(sl<MusicRepositoryImpl>()));
  sl.registerSingleton(GetOnAudioPositionChanged(sl<MusicRepositoryImpl>()));
  sl.registerSingleton(GetOnPlayerStateChange(sl<MusicRepositoryImpl>()));
  sl.registerSingleton(GetLinks(sl<MusicRepositoryImpl>()));

  sl.registerSingleton(
    MusicBloc(
      sl<GetAllLocalSongs>(),
      sl<GetOnAudioPositionChanged>(),
      sl<GetOnPlayerStateChange>(),
      ),
    );
    
    sl.registerSingleton(
    MusicViewBloc(
      sl<GetLinks>(),
      ),
    );

  // Player feature

  sl.registerSingleton(PlayerDataSourceImpl(sl<AudioPlayer>()));

  sl.registerSingleton(PlayerRepositoryImpl(sl<PlayerDataSourceImpl>()));

  sl.registerSingleton(PlayMusic(sl<PlayerRepositoryImpl>()));
  sl.registerSingleton(StopMusic(sl<PlayerRepositoryImpl>()));
  sl.registerSingleton(PauseMusic(sl<PlayerRepositoryImpl>()));
  sl.registerSingleton(ResumeMusic(sl<PlayerRepositoryImpl>()));

  sl.registerSingleton(PlayerBloc(sl<PlayMusic>(), sl<StopMusic>(), sl<PauseMusic>(), sl<ResumeMusic>()));

}