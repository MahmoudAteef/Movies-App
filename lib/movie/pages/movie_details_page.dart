import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/provider/movie_get_details_provider.dart';
import 'package:movies_app_v1/movie/provider/movie_get_videos_provider.dart';
import 'package:movies_app_v1/widgets/image_widget.dart';
import 'package:movies_app_v1/widgets/item_movie_widget.dart';
import 'package:movies_app_v1/widgets/webview_widget.dart';
import 'package:movies_app_v1/widgets/youtube_player_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../injector.dart';

class MovieDetailsPage extends StatelessWidget {
  final int id;

  const MovieDetailsPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                sl<MovieGetDetailsProvider>()..getDetails(context, id: id)),
        ChangeNotifierProvider(
            create: (_) =>
                sl<MovieGetVideosProvider>()..getVideos(context, id: id))
      ],
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context),
            Consumer<MovieGetVideosProvider>(
              builder: (_, provider, __) {
                final videos = provider.videos;
                if (videos != null) {
                  return SliverToBoxAdapter(
                      child: _Content(
                    title: 'Trailer',
                    padding: 0,
                    body: SizedBox(
                      height: 160,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final video = videos.results[index];
                            return Stack(
                              children: [
                                ImageNetworkWidget(
                                  radius: 12,
                                  type: TypeSrcImg.external,
                                  imageSrc: YoutubePlayer.getThumbnail(
                                      videoId: video.key),
                                ),
                                Positioned.fill(
                                    child: Center(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                )),
                                Positioned.fill(
                                    child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  YouTubePlayerWidget(
                                                      youtubeKey: video.key)));
                                    },
                                  ),
                                ))
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                                width: 8,
                              ),
                          itemCount: videos.results.length),
                    ),
                  ));
                }
                return SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final String title;
  final Widget body;
  final double padding;

  const _Content({required this.title, required this.body, this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;
  _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Color? get foregroundColor => Colors.black;

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Consumer<MovieGetDetailsProvider>(builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => WeebViewWidget(
                                  url: movie.homepage,
                                  title: movie.title,
                                )));
                  },
                  icon: Icon(Icons.public),
                ),
              ),
            );
          }
          return SizedBox();
        }),
      ];

  @override
  double? get expandedHeight => 300;

  @override
  Widget? get flexibleSpace =>
      Consumer<MovieGetDetailsProvider>(builder: (_, provider, __) {
        final movie = provider.movie;

        if (movie != null) {
          return ItemMovieWidget(
            movieDetails: movie,
            heightBackdrop: double.infinity,
            widthBackdrop: double.infinity,
            heightPoster: 160,
            widthPoster: 100,
            radius: 0,
          );
        }
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black12,
        );
      });
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(content),
      ),
    ]);
  }

  @override
  Widget? get child => Consumer<MovieGetDetailsProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 32,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                _Content(
                  title: 'Genres',
                  body: Wrap(
                    spacing: 6,
                    children: movie.genres
                        .map((genre) => Chip(label: Text(genre.name)))
                        .toList(),
                  ),
                ),
                _Content(
                  title: 'Overview',
                  body: Text(movie.overview),
                ),
                _Content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12)),
                    children: [
                      _tableContent(
                          title: 'Adult', content: movie.adult ? 'Yes' : 'No'),
                      _tableContent(
                          title: 'Popularity', content: '${movie.popularity}'),
                      _tableContent(
                          title: 'Status', content: '${movie.status}'),
                      _tableContent(
                          title: 'Budget', content: '${movie.budget}'),
                      _tableContent(
                          title: 'Revenue', content: '${movie.revenue}'),
                      _tableContent(
                          title: 'TagLine', content: '${movie.tagline}'),
                    ],
                  ),
                ),
                SizedBox(height: 16,)
              ],
            );
          }
          return Container();
        },
      );
}
