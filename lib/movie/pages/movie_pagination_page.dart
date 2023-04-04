import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app_v1/movie/models/movie_model.dart';
import 'package:movies_app_v1/movie/provider/movie_get_discover_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_nowplaying_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_toprated_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/item_movie_widget.dart';
import 'movie_details_page.dart';


enum TypeMovie{discover , nowPlaying , topRated}

class MoviePaginationPage extends StatefulWidget {

  final TypeMovie type;

  const MoviePaginationPage({super.key, required this.type});

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {

  final PagingController<int, MovieModel> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {

      switch(widget.type){
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
        case TypeMovie.nowPlaying:
          context.read<MovieGetNowPlayingProvider>().getNowPlayingWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;
        case TypeMovie.topRated:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPaging(context, page: pageKey, pagingController: _pagingController);
          break;


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Builder(
          builder: (_) {
            switch(widget.type){
              case TypeMovie.discover:
                return Text('Discover Movies');
              case TypeMovie.nowPlaying:
                return Text('Now Playing Movies');
              case TypeMovie.topRated:
                return Text('Top Rated Movies');
            }
          }
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(16),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieModel>(itemBuilder: (context,item,index) =>
              ItemMovieWidget(
            movie : item,
            heightBackdrop: 260,
            widthBackdrop: double.infinity,
            heightPoster: 140,
            widthPoster: 80,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MovieDetailsPage(
                        id: item.id);
                  }));
                },
          ),
          ),
          separatorBuilder: (context,index) => SizedBox(height: 10,))
    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
