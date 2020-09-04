class Category {
  String name;

  Category({this.name});

  @override
  bool operator ==(other) {
    if(other is Category)
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