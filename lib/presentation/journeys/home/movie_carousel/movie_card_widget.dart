import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import '../../../../common/constants/route_constants.dart';
import '../../../../common/constants/size_constants.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String posterPath;

  const MovieCardWidget({
    Key? key,
    required this.movieId,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            RouteList.movieDetail,
            arguments: MovieDetailArguments(movieId),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: CachedNetworkImage(
            //imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
            imageUrl: 'https://www.shutterstock.com/image-photo/photo-old-movie-projector-260nw-92369284.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}