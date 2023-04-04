import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/models/movie_details_model.dart';
import 'package:movies_app_v1/movie/repositories/movie_repository.dart';

class MovieGetDetailsProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDetailsProvider(this._movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetails(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetails(id: id);
    result.fold((messageError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(messageError)));
      _movie = null;
      return;
    }, (response) {
      _movie = response;
      notifyListeners();
      return;
    });
  }
}
