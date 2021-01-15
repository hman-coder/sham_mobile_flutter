import 'package:equatable/equatable.dart';
import 'package:sham_mobile/models/summerizable.dart';

class Category extends Equatable with Summarizable {
  final String name;

  Category({this.name});

  @override
  String toString() {
    return name;
  }

  @override
  List<Object> get props => [name];


}