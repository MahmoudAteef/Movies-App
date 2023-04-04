import 'package:dartz/dartz.dart';
import 'package:movies_app_v1/movie/models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../models/movie_videos_model.dart';

abstract class MovieRepository{
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  Future<Either<String, MovieDetailModel>> getDetails({required int id});
  Future<Either<String, MovieVideosModel>> getVideos({required int id});
  Future<Either<String, MovieResponseModel>>search({required String query});

}