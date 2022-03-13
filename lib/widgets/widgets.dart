import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Widgets{

  static Widget latestPostsImages(){
    return CachedNetworkImage(
      imageUrl:
      'https://picsum.photos/id/${Random().nextInt(200)}/200/300',
      imageBuilder: (context, imageProvider) => Container(
        width: MediaQuery.of(context).size.width / 3 - 15,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) =>
      const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}