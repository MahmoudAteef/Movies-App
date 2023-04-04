import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/pages/movie_details_page.dart';
import 'package:movies_app_v1/movie/provider/movie_search_provider.dart';
import 'package:movies_app_v1/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search Movies';

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        onPressed: () => query = "",
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(builder: (_, provider, __) {
      if (query.isEmpty) {
        return Center(
            child: Text(
          'Search Movies',
        ));
      }

      if (provider.isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (provider.movies.isEmpty) {
        return Center(
          child: Text('Movies Not Found'),
        );
      }
      if (provider.movies.isNotEmpty) {
        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (_, index) {
            final movie = provider.movies[index];
            return Stack(
              children: [
                Row(
                  children: [
                    ImageNetworkWidget(
                      imageSrc: movie.posterPath,
                      height: 120,
                      width: 80,
                      radius: 12,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            movie.overview,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontStyle: FontStyle.italic,),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Positioned.fill(child: Material(color: Colors.transparent,
                child: InkWell(onTap: (){
                  close(context, null);
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return MovieDetailsPage(id: movie.id);
                  }));
                },),
                ))
              ],
            );
          },
          separatorBuilder: (_, __) => SizedBox(
            height: 10,
          ),
          itemCount: provider.movies.length,
        );
      }
      return Center(
        child: Text('Another Error on search movies'),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox(child: Center(child: Text('Search Content')),);
  }
}
