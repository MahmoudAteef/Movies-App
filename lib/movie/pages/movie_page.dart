import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/components/movie_discover_component.dart';
import 'package:movies_app_v1/movie/components/movie_toprated_component.dart';
import 'package:movies_app_v1/movie/pages/movie_pagination_page.dart';
import 'package:movies_app_v1/movie/pages/movie_search_page.dart';
import '../components/movie_nowplaying_component.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/logo.png'),
                  )),
              Text('Movie DB'),
            ],
          ),
          actions: [
            IconButton(onPressed: () => showSearch(context: context, delegate: MovieSearchPage()), icon: Icon(Icons.search)),
          ],
          floating: true,
          snap: true,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        _WidgetTitle(
          title: 'Discover Movies',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MoviePaginationPage(
                          type: TypeMovie.discover,
                        )));
          },
        ),
        MovieDiscoverComponent(),
        _WidgetTitle(
          title: 'Top Rated Movies',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MoviePaginationPage(
                          type: TypeMovie.topRated,
                        )));
          },
        ),
        MovieTopRatedComponent(),
        _WidgetTitle(
          title: 'Now Playing Movies',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MoviePaginationPage(
                          type: TypeMovie.nowPlaying,
                        )));
          },
        ),
        MovieNowPlayingComponent(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        // SliverToBoxAdapter(child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text('developed by\t',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic),),
        //     Text('"MahmoudZahran"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        //   ],
        // ),
        // ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
      ],
    ));
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
                side: const BorderSide(
                  color: Colors.black54,
                ),
              ),
              child: const Text('See All'),
            )
          ],
        ),
      );
}
