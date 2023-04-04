import 'package:flutter/material.dart';
import '../constants.dart';


enum TypeSrcImg {movieDB , external}

class ImageNetworkWidget extends StatelessWidget {

  final String? imageSrc;
  final TypeSrcImg type;
  final double? height;
  final double? width;
  final double radius;
  final void Function()? onTap;

  const ImageNetworkWidget({super.key, this.height, this.width,this.imageSrc, this.radius = 0.0,this.type = TypeSrcImg.movieDB,this.onTap});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
           type == TypeSrcImg.movieDB ?  "${AppConstants.imageUrlW500}$imageSrc" : imageSrc!,
            fit: BoxFit.cover,
            height: height,
            width: width,
            loadingBuilder: (context,child,loadingProgress){
              return Container(
                height: height,
                width: width,
                color: Colors.black26,
                child: child,
              );
            },
            errorBuilder: (_, __, ___) {
              return SizedBox(
                height: height,
                width: width,
                child: Icon(Icons.broken_image_rounded),
              );
            },
          ),
        ),
        Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ))
      ],
    );
  }
}



