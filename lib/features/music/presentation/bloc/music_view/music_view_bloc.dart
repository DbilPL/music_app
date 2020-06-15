import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app/features/music/domain/entities/link_group.dart';
import 'package:music_app/features/music/domain/usecases/get_links.dart';

part 'music_view_event.dart';
part 'music_view_state.dart';

class MusicViewBloc extends Bloc<MusicViewEvent, MusicViewState> {

  final GetLinks _getLinks;

  MusicViewBloc(this._getLinks);

  @override
  MusicViewState get initialState => MusicViewInitial();

  @override
  Stream<MusicViewState> mapEventToState(
    MusicViewEvent event,
  ) async* {
    if (event is LoadMusicData) {
      yield MusicViewLoading();
      
      final data = await _getLinks(
        GetLinksParams(
          event.artistName,
          event.trackName,
        ),
      );

      yield data.fold((failure) => FailureMusicViewState(failure.message), (data) => MusicLinksLoaded(data));
    }
  }
}
