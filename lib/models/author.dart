import 'package:equatable/equatable.dart';

class Author extends Equatable {
  String name;

  String birthYear;

  String deathYear;

  String description;

  Author({this.name, this.birthYear, this.deathYear, this.description});

  @override
  String toString() {
    return name;
  }

  @override
  List<Object> get props => [name];

}