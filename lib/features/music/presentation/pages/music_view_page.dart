import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants.dart';
import 'package:music_app/core/presentation/pages/loading_page.dart';
import 'package:music_app/core/presentation/widgets/gap.dart';
import 'package:music_app/features/music/presentation/bloc/music_view/music_view_bloc.dart';
import 'package:music_app/features/music/presentation/widgets/other_source_widget.dart';

class MusicViewPage extends StatefulWidget {

  final SongInfo song;

  const MusicViewPage({Key key, this.song}) : super(key: key);

  @override
  _MusicViewPageState createState() => _MusicViewPageState();
}

class _MusicViewPageState extends State<MusicViewPage> {
  @override
  Widget build(BuildContext context) {

    final mainSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.song.artist} - ${widget.song.title}'),
      ),
      body: BlocBuilder<MusicViewBloc, MusicViewState>(
        builder: (context, state) {
          if (state is MusicLinksLoaded) {
            return SizedBox.expand(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Gap(),
                  if (widget.song.albumArtwork != null) 
                    Image(
                      width: mainSize,
                      height: mainSize,
                      image: FileImage(
                        File(widget.song.albumArtwork),
                      ),
                    ) 
                  else
                    Container(
                      width: mainSize,
                      height: mainSize,
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(
                          Icons.music_note,
                          color: Colors.grey[500],
                          size: 100,
                        ),
                      ),
                    ),
                  Gap(),
                  Text(
                    widget.song.artist,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.song.title,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  Gap(),
                  OtherSourceWidget(
                    buttonText: kAppleMusic,
                    url: state.links.itunesLink,
                  ),
                  Gap(),
                  OtherSourceWidget(
                    buttonText: kGooglePlay,
                    url: state.links.googleMusicLink,
                  ),
                ],
              ),
            );
          }
          if (state is FailureMusicViewState) {
            return SizedBox.expand(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.message),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        BlocProvider.of<MusicViewBloc>(context).add(
                          LoadMusicData(
                            widget.song.artist,
                            widget.song.title
                          ),
                        );
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }
          else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}