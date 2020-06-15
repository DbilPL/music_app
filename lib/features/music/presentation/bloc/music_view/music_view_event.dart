part of 'music_view_bloc.dart';

abstract class MusicViewEvent extends Equatable {
  const MusicViewEvent();
}

class LoadMusicData extends MusicViewEvent {
  
  final String artistName;
  final String trackName;

  const LoadMusicData(this.artistName, this.trackName);
  
  @override
  List<Object> get props => [artistName, trackName];
}