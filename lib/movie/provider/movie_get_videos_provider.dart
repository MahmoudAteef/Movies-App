import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/models/movie_videos_model.dart';
import 'package:movies_app_v1/movie/repositories/movie_repository.dart';

class MovieGetVideosProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetVideosProvider(this._movieRepository);

  MovieVideosModel? _videos;
  MovieVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _movieRepository.getVideos(id: id);
    result.fold((messageError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(messageError)));
      _videos = null;
      return;
    }, (response) {
      _videos = response;
      notifyListeners();
      return;
    });
  }
}
