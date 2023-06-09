import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/features/movie_flow/genre/genre_entity.dart';

@immutable
class Genre {
  final int id;
  final String name;
  final bool isSelected;

  const Genre({this.id = 0, required this.name, this.isSelected = false});
  factory Genre.fromEntity(GenreEntity entity) {
    return Genre(id: entity.id, name: entity.name, isSelected: false);
  }

  Genre toggleSelected() {
    return Genre(
      id: id,
      name: name,
      isSelected: !isSelected,
    );
  }

  @override
  String toString() {
    return 'Genre(id: $id, name:$name, isSelected = $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Genre &&
        other.name == name &&
        other.isSelected == isSelected;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode ^ name.hashCode ^ isSelected.hashCode;
}
