import 'package:audioplayers/audioplayers.dart';

abstract class PlayerDataSource {
  /// Plays music on `songPath` path
  Future<void> playMusic(String songPath);
  /// Pause music
  Future<void> pauseMusic();
  /// Resume music
  Future<void> resumeMusic();
  /// Stops playing music
  Future<void> stopMusic();
}

class PlayerDataSourceImpl extends PlayerDataSource {

  final AudioPlayer _audioPlayer;

  PlayerDataSourceImpl(this._audioPlayer);

  @override
  Future<void> playMusic(String songPath) {
    return _audioPlayer.play(songPath, isLocal: true);
  }

  @override
  Future<void> stopMusic() {
    return _audioPlayer.stop();
  }

  @override
  Future<void> pauseMusic() {
    return _audioPlayer.pause();
  }

  @override
  Future<void> resumeMusic() {
    return _audioPlayer.resume();
  }
}