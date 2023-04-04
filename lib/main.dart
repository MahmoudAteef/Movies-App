import 'package:flutter/material.dart';
import 'package:movies_app_v1/injector.dart';
import 'package:movies_app_v1/movie/pages/movie_page.dart';
import 'package:movies_app_v1/movie/provider/movie_get_discover_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_nowplaying_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_toprated_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'movie/provider/movie_get_details_provider.dart';
import 'movie/provider/movie_get_videos_provider.dart';
import 'movie/provider/movie_search_provider.dart';


void main(){
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => sl<MovieGetDetailsProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => sl<MovieGetVideosProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => sl<MovieSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie DB',
        home: MoviePage(),
      ),
    );
  }
}
