import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/pages/movie_details_page.dart';
import 'package:movies_app_v1/movie/provider/movie_get_toprated_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/image_widget.dart';

class MovieTopRatedComponent extends StatefulWidget {
  @override
  State<MovieTopRatedComponent> createState() => _MovieTopRatedComponentState();
}

class _MovieTopRatedComponentState extends State<MovieTopRatedComponent> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<MovieGetTopRatedProvider>(
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
                    return ImageNetworkWidget(
                      height: 200,
                      width: 120,
                      radius: 12,
                      imageSrc: provider.movies[index].posterPath,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return MovieDetailsPage(
                              id: provider.movies[index].id);
                        }));
                      },
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
                'Not found top rated movies',
                style: TextStyle(color: Colors.black54),
              )),
            );
          },
        ),
      ),
    );
  }
}
