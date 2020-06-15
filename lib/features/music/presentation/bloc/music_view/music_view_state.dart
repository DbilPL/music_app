part of 'music_view_bloc.dart';

abstract class MusicViewState extends Equatable {
  const MusicViewState();
}

class MusicViewInitial extends MusicViewState {
  @override
  List<Object> get props => [];
}

class MusicViewLoading extends MusicViewState {
  @override
  List<Object> get props => [];
}

class MusicLinksLoaded extends MusicViewState {

  final LinkGroup links;

  const MusicLinksLoaded(this.links);

  @override
  List<Object> get props => [links];
}

class FailureMusicViewState extends MusicViewState {

  final String message;

  const FailureMusicViewState(this.message);

  @override
  List<Object> get props => [message];
}