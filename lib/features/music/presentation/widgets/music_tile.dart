
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/player/presentation/bloc/player_bloc.dart';

class MusicTile extends StatefulWidget {

  final SongInfo song;
  final bool isSelected;
  final Stream<Duration> durationStream;
  final void Function() onSelected;


  const MusicTile({Key key, this.song, this.onSelected, this.isSelected, this.durationStream}) : super(key: key);

  @override
  _MusicTileState createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> { 

  String _validateTime(String time) {
    return time.length == 1 ? '0$time' : time;
  }

  @override
  Widget build(BuildContext context) {


    final Duration duration = Duration(milliseconds: int.parse(widget.song.duration));


    final num minutes = duration.inMinutes;

    final num seconds = duration.inSeconds - (minutes * 60);

    final String minutesStr = _validateTime(minutes.toString());

    final String secondsStr = _validateTime(seconds.toString());

    final String durationStr = "$minutesStr:$secondsStr";

    return BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            return ListTile(
                onLongPress: widget.onSelected,
                onTap: () {
                  if (state is MusicPlaying && state.currentMusicPath == widget.song.filePath) {
                    BlocProvider.of<PlayerBloc>(context).add(PauseMusicEvent(widget.song.filePath));
                  } 
                  else if (state is MusicPaused && state.currentMusicPath == widget.song.filePath) {
                    BlocProvider.of<PlayerBloc>(context).add(ResumeMusicEvent(widget.song.filePath));
                  } 
                  else {
                    BlocProvider.of<PlayerBloc>(context).add(StopMusicEvent());
                    BlocProvider.of<PlayerBloc>(context).add(PlayMusicEvent(widget.song.filePath));
                  }
                },
                title: Row(
                  children: [
                    Text(widget.song.title),
                    const SizedBox(width: 6),
                    if (widget.isSelected) 
                      Icon(Icons.check, size: 10, color: Colors.green[800]),
                  ],
                ),
                subtitle: Text(widget.song.artist),
                trailing: Text(durationStr),
                leading: Stack(
                  children: [
                    if (widget.song.albumArtwork != null)
                    Image(
                      width: 30,
                      height: 30,
                      image: FileImage(
                        File(widget.song.albumArtwork),
                      ),
                    ),
                    if (state is MusicPlaying && state.currentMusicPath == widget.song.filePath) Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.play_arrow 
                                ),
                                StreamBuilder<Duration>(
                                  stream: widget.durationStream,
                                  initialData: Duration.zero,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData && snapshot.data != null) {
                                      return CircularProgressIndicator(
                                        value: snapshot.data.inMilliseconds / int.parse(widget.song.duration),
                                      );
                                    }
                                    else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            ) else const Icon(
                              Icons.pause 
                            ),
                  ],
                ),
            );
          },
        );
  }
}