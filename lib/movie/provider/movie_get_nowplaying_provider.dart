import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../models/movie_model.dart';
import '../repositories/movie_repository.dart';

class MovieGetNowPlayingProvider with ChangeNotifier{
  final MovieRepository _movieRepository;

  MovieGetNowPlayingProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getNowPlaying(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getNowPlaying();

    result.fold(
          (errorMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)
        ));
        _isLoading = false;
        notifyListeners();
        return;
      },
          (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }



  void getNowPlayingWithPaging(BuildContext context,
      {required int page, required PagingController pagingController}) async {

    final result = await _movieRepository.getNowPlaying(page: page);
    result.fold(
          (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMessage)
        ));
        pagingController.error = errorMessage;
        return;
      },
          (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return;
      },
    );
  }

}