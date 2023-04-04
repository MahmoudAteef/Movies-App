import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/pages/movie_details_page.dart';
import 'package:movies_app_v1/movie/provider/movie_get_nowplaying_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/image_widget.dart';

class MovieNowPlayingComponent extends StatefulWidget {
  @override
  State<MovieNowPlayingComponent> createState() =>
      _MovieNowPlayingComponentState();
}

class _MovieNowPlayingComponentState extends State<MovieNowPlayingComponent> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetNowPlayingProvider>().getNowPlaying(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<MovieGetNowPlayingProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black38,
                )),
              );
            }
            if (provider.movies.isNotEmpty) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final movie = provider.movies[index];
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black26],
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageNetworkWidget(
                                  height: 200,
                                  width: 120,
                                  radius: 12,
                                  imageSrc: movie.posterPath),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          "${movie.voteAverage} (${movie.voteCount})",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      movie.overview,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned.fill(
                            child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return MovieDetailsPage(id: movie.id);
                              }));
                            },
                          ),
                        ))
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(
                        width: 8,
                      ),
                  itemCount: provider.movies.length);
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                'Not found now playing movies',
                style: TextStyle(color: Colors.black54),
              )),
            );
          },
        ),
      ),
    );
  }
}
