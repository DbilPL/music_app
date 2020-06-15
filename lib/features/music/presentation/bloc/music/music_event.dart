part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();
}

class LoadMusic extends MusicEvent {
  @override
  List<Object> get props => [];
}
