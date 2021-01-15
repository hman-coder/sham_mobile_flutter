import 'package:equatable/equatable.dart';
import 'package:sham_mobile/models/summerizable.dart';

class Author extends Equatable with Summarizable {
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