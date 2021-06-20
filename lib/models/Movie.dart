import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String title;
  final String synopsis;
  final String image;
  final String genre;
  final int rating;

  Movie(
      this.id, this.title, this.synopsis, this.image, this.genre, this.rating);

  toMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['synopsis'] = synopsis;
    mapping['image'] = image;
    mapping['genre'] = genre;
    mapping['rating'] = rating;
    return mapping;
  }
}
