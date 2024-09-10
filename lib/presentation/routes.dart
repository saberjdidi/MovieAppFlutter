import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/route_constants.dart';

import 'journeys/home/home_screen.dart';
import 'journeys/movie_detail/movie_detail_arguments.dart';
import 'journeys/movie_detail/movie_detail_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
    //RouteList.initial: (context) => LoginScreen(),
    RouteList.initial: (context) => HomeScreen(),
    RouteList.home: (context) => HomeScreen(),
    RouteList.movieDetail: (context) => MovieDetailScreen(
      movieDetailArguments: setting.arguments as MovieDetailArguments,
    ),
    /*RouteList.watchTrailer: (context) => WatchVideoScreen(
      watchVideoArguments: setting.arguments as WatchVideoArguments,
    ),
    RouteList.favorite: (context) => FavoriteScreen(), */
  };
}