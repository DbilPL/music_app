part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();
}

class MusicInitial extends MusicState {
  @override
  List<Object> get props => [];
}

class FailureMusicState extends MusicState {

  final String message;

  const FailureMusicState(this.message);

  @override
  List<Object> get props => [message];
}

class MusicLoadingState extends MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoaded extends MusicState {
  final List<SongInfo> songs;
  final Stream<Duration> durationStream;
  final Stream<AudioPlayerState> playerStateStream;

  const MusicLoaded(this.songs, this.durationStream, this.playerStateStream);
  
  @override
  List<Object> get props => [songs, durationStream, playerStateStream];
}