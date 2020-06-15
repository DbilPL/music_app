part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}


class PlayMusicEvent extends PlayerEvent {

  final String songPath;

  const PlayMusicEvent(this.songPath);

  @override
  List<Object> get props => [songPath];
}

class PauseMusicEvent extends PlayerEvent {

   final String songPath;

  const PauseMusicEvent(this.songPath);

  @override
  List<Object> get props => [songPath];
}

class ResumeMusicEvent extends PlayerEvent {
  final String songPath;

  const ResumeMusicEvent(this.songPath);

  @override
  List<Object> get props => [songPath];
}

class StopMusicEvent extends PlayerEvent {

  @override
  List<Object> get props => [];
}