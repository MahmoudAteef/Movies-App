import 'package:dio/dio.dart';
import 'constants.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app_v1/movie/provider/movie_get_details_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_discover_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_nowplaying_provider.dart';
import 'package:movies_app_v1/movie/repositories/movie_repository.dart';
import 'movie/provider/movie_get_toprated_provider.dart';
import 'movie/provider/movie_get_videos_provider.dart';
import 'movie/provider/movie_search_provider.dart';
import 'movie/repositories/movie_repository_impl.dart';


final sl = GetIt.instance;

void setup(){
  // register provider
  sl.registerFactory<MovieGetDiscoverProvider>(
        () => MovieGetDiscoverProvider(sl()),
  );

  sl.registerFactory<MovieGetNowPlayingProvider>(
        () => MovieGetNowPlayingProvider(sl()),
  );

  sl.registerFactory<MovieGetTopRatedProvider>(
        () => MovieGetTopRatedProvider(sl()),
  );

  sl.registerFactory<MovieGetDetailsProvider>(
        () => MovieGetDetailsProvider(sl()),
  );

  sl.registerFactory<MovieGetVideosProvider>(
        () => MovieGetVideosProvider(sl()),
  );

  sl.registerFactory<MovieSearchProvider>(
        () => MovieSearchProvider(sl()),
  );
// register repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));


  // register http client (Dio)
  sl.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {'api_key': AppConstants.apiKey},
      ),
    ),
  );


}
