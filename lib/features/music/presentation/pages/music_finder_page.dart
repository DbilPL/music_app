
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/presentation/pages/loading_page.dart';
import 'package:music_app/features/music/presentation/bloc/music/music_bloc.dart';
import 'package:music_app/features/music/presentation/bloc/music_view/music_view_bloc.dart';
import 'package:music_app/features/music/presentation/pages/music_view_page.dart';
import 'package:music_app/features/music/presentation/widgets/music_tile.dart';
import 'package:music_app/features/player/presentation/bloc/player_bloc.dart';

class MusicFinderPage extends StatefulWidget {
  @override
  _MusicFinderPageState createState() => _MusicFinderPageState();
}

class _MusicFinderPageState extends State<MusicFinderPage> {

  int selectedMusicIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MusicBloc, MusicState>(
        listener: (context, state) {
              if (state is MusicLoaded) {
                state.playerStateStream.listen((event) {
                  if (event == AudioPlayerState.COMPLETED) {
                    BlocProvider.of<PlayerBloc>(context).add(StopMusicEvent());
                  }
              });
            }
        },
        child: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            if (state is MusicLoaded) {
            return Scaffold(
                    appBar: AppBar(
                    title: const Text('Music finder'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<MusicBloc>(context).add(LoadMusic());
                          BlocProvider.of<PlayerBloc>(context).add(StopMusicEvent());
                          setState(() {
                            selectedMusicIndex = null;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  bottomNavigationBar: BottomAppBar(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: const Icon(Icons.close), onPressed: () {
                            setState(() {
                              selectedMusicIndex = null;
                            });
                          }),
                          IconButton(icon: const Icon(Icons.check), onPressed: selectedMusicIndex != null ? () {
                            BlocProvider.of<MusicViewBloc>(context).add(
                                LoadMusicData(
                                state.songs[selectedMusicIndex].artist,
                                state.songs[selectedMusicIndex].title,
                              ),
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MusicViewPage(
                                song: state.songs[selectedMusicIndex],
                              ),
                            ));
                          } : null),
                        ],
                      ),
                    ),
                  ),
                    body: ListView.separated(
                    itemCount: state.songs.length,
                    itemBuilder: (context, counter) {
                      return MusicTile(
                        durationStream: state.durationStream,
                        song: state.songs[counter],
                        isSelected: selectedMusicIndex == counter,
                        key: Key(counter.toString()),
                        onSelected: () {
                          setState(() {
                            if (selectedMusicIndex == counter) {
                              selectedMusicIndex = null;
                            }
                            else {
                              selectedMusicIndex = counter;
                            }
                          });
                        },
                      );
                    }, 
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                ),
            );
            }
            if (state is FailureMusicState) {
              return Scaffold(
                  body: SizedBox.expand(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.message),
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              BlocProvider.of<MusicBloc>(context).add(LoadMusic());
                            },
                            child: const Text('Try again'),
                          ),
                        ],
                      ),
                    ),
                  ),
              );
            }
            else {
              return Scaffold(
                  body: LoadingPage(),
              );
            }
          },
        ),
    );
  }
}
