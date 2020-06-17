part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
}

class PlayerFailureState extends PlayerState {
  
  final String message;

  const PlayerFailureState(this.message);
  
  @override
  List<Object> get props => [message];
}

class PlayerInitial extends PlayerState {
  @override
  List<Object> get props => [];
}

class MusicPlaying extends PlayerState {

  final String currentMusicPath;

  const MusicPlaying(this.currentMusicPath);

  @override
  List<Object> get props => [];
}

class MusicPaused extends PlayerState {
  final String currentMusicPath;

  const MusicPaused(this.currentMusicPath);

  @override
  List<Object> get props => [];
}

class MusicStopped extends PlayerState {
  
  @override
  List<Object> get props => [];
}