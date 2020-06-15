import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app/features/music/data/model/link_group_model.dart';

abstract class MusicDataSource {
  /// Gets all [SongInfo]s from device (not supported for IOS)
  Future<List<SongInfo>> getAllLocalSongs();
  /// Gets position of playing song (in ms)
  Future<Stream<Duration>> getOnAudioPositionChanged();
  /// Gets state of playing music (completed or not)
  Future<Stream<AudioPlayerState>> getOnPlayerStateChange();
  /// Gets links for pages in iTunes or GooglePlay
  Future<LinkGroupModel> getLinks(String trackName, String artistName);
}

class MusicDataSourceImpl extends MusicDataSource {

  final FlutterAudioQuery _audioQuery;
  final AudioPlayer _audioPlayer;
  final Dio _dio;

  MusicDataSourceImpl(this._audioQuery, this._audioPlayer, this._dio);

  @override
  Future<List<SongInfo>> getAllLocalSongs() async {

    // TODO: Implement not fucking existing local songs on iPhone

    final List<SongInfo> songs = await _audioQuery.getSongs();
    
    return songs;
  }

  @override
  Future<Stream<Duration>> getOnAudioPositionChanged() async {
    return _audioPlayer.onAudioPositionChanged;
  }

  @override
  Future<Stream<AudioPlayerState>> getOnPlayerStateChange() async {
    return _audioPlayer.onPlayerStateChanged;
  }

  @override
  Future<LinkGroupModel> getLinks(String trackName, String artistName) async {
    final trackNameStr = _validateStr(trackName);
    final artistNameStr = _validateStr(artistName);

    // TODO: Implement not fucking existing Google Music API

    final Response<String> dataForITunes = await _dio.get(
      'https://itunes.apple.com/search?term=$artistNameStr+$trackNameStr&country=RU&media=music',
      options: Options(
        contentType: 'charset=utf-8', 
      ),
    );

    final dataForITunesJson = jsonDecode(dataForITunes.data);

    String iTunesUrl;
    String googleMusicUrl;

    if ((dataForITunesJson['resultCount'] as int) > 0) {
      iTunesUrl = dataForITunesJson['results'][0]['trackViewUrl'] as String;
    }
    
    if (iTunesUrl == null && googleMusicUrl == null) {
      throw Exception('No data!');
    }

    return LinkGroupModel(iTunesUrl, googleMusicUrl);
  }

  String _validateStr(String input) => input.split(' ').join('+');
}