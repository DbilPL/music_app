

import 'package:equatable/equatable.dart';

class LinkGroup extends Equatable {
  
  final String itunesLink;

  final String googleMusicLink;

  const LinkGroup(this.itunesLink, this.googleMusicLink);
  
  @override
  List<Object> get props => [itunesLink, googleMusicLink];
}