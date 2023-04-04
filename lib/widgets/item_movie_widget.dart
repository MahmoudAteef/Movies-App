import 'package:flutter/material.dart';
import 'package:movies_app_v1/movie/models/movie_details_model.dart';
import '../movie/models/movie_model.dart';
import 'image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel? movie;
  final MovieDetailModel? movieDetails;
  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPoster;
  final double widthPoster;
  final double radius;
  final void Function()? onTap;

  ItemMovieWidget(
      { this.movie,
        this.movieDetails,
        required this.heightBackdrop,
      required this.widthBackdrop,
      required this.heightPoster,
      required this.widthPoster,
        this.radius = 12,
      this.onTap
      });
  @override
  Clip get clipBehavior => Clip.hardEdge;
  @override
  Decoration? get decoration =>
      BoxDecoration(borderRadius: BorderRadius.circular(radius));
  @override
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc: "${movieDetails != null ? movieDetails!.backdropPath : movie!.backdropPath}",
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87])),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  height: heightPoster,
                  width: widthPoster,
                  imageSrc: "${movieDetails != null ? movieDetails!.posterPath : movie!.posterPath}",
                  radius: 12,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${movieDetails != null ? movieDetails!.title : movie!.title}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    Text(
                      '${"${movieDetails != null ? movieDetails!.voteAverage : movie!.voteAverage}"
                        } (${movieDetails != null ? movieDetails!.voteCount : movie!.voteCount})',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          )
          )
        ],
      );
}
