
import 'package:music_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase.dart';
import 'package:music_app/features/music/domain/entities/link_group.dart';
import 'package:music_app/features/music/domain/repositories/music_repository.dart';

class GetLinks extends Usecase<LinkGroup, GetLinksParams> {
  final MusicRepository _repository;

  GetLinks(this._repository);

  @override
  Future<Either<Failure, LinkGroup>> call(GetLinksParams params) async {
    return _repository.getLinks(params.trackName, params.artistName);
  }
    
}
  
class GetLinksParams {
  final String artistName;
  final String trackName;

  GetLinksParams(this.artistName, this.trackName);
}
