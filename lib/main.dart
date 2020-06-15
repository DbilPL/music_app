import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music/presentation/bloc/music_view/music_view_bloc.dart';
import 'package:music_app/features/music/presentation/pages/music_finder_page.dart';
import 'package:music_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:music_app/injection_container.dart';
import 'core/bloc_delegate.dart';
import 'features/music/presentation/bloc/music/music_bloc.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MusicBloc>(create: (context) => sl<MusicBloc>()..add(LoadMusic())),
        BlocProvider<PlayerBloc>(create: (context) => sl<PlayerBloc>()),
        BlocProvider<MusicViewBloc>(create: (context) => sl<MusicViewBloc>()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Finder',
      debugShowCheckedModeBanner: false,
      home: MusicFinderPage(),
      theme: ThemeData.dark(),
    );
  }
}
