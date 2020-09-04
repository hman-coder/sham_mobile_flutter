class Author {
  String name;

  String birthYear;

  String deathYear;

  String description;

  Author({this.name, this.birthYear, this.deathYear, this.description});

  @override
  bool operator ==(other) {
    if(other is Author)
      return name == other.name;
    return false;
  }

  @override
  String toString() {
    return name;
  }

  @override
  int get hashCode => super.hashCode;

}