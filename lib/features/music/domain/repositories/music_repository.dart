
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/features/music/domain/entities/link_group.dart';

abstract class MusicRepository {

  Future<Either<Failure, List<SongInfo>>> getAllLocalSongs();

  Future<Either<Failure, Stream<Duration>>> getOnAudioPositionChanged();

  Future<Either<Failure, LinkGroup>> getLinks(String trackName, String artistName);

  Future<Either<Failure, Stream<AudioPlayerState>>> getOnPlayerStateChange();
}
