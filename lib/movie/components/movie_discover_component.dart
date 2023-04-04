import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/pages/movie_details_page.dart';
import 'package:provider/provider.dart';
import '../../widgets/item_movie_widget.dart';
import '../provider/movie_get_discover_provider.dart';

class MovieDiscoverComponent extends StatefulWidget {
  const MovieDiscoverComponent({Key? key}) : super(key: key);

  @override
  State<MovieDiscoverComponent> createState() => _MovieDiscoverComponentState();
}

class _MovieDiscoverComponentState extends State<MovieDiscoverComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.black38,)),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.movies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.movies[index];
                  return ItemMovieWidget(
                    movie : movie,
                    heightBackdrop: 300,
                    widthBackdrop: double.infinity,
                    heightPoster: 160,
                    widthPoster: 100,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return MovieDetailsPage(id: movie.id);
                      }));
                    },
                  );
                },
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 0.8,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ));
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 300,
            width: double.infinity,
            child: Center(
                child: Text(
                  'Not Found discover movies',
                  style: TextStyle(color: Colors.black54),
                )),
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(12)),
          );
        },
      ),
    );
  }
}
