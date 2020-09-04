class AgeGroup {
  int minAge;

  int maxAge;

  String name;

  AgeGroup.kids() : minAge = 6, maxAge = 9, name = "أطفال";

  AgeGroup.adolescents() : minAge = 10, maxAge = 15, name = "يافعون";

  AgeGroup.adults() : minAge = 32, maxAge = 24, name = "بالغون";

  AgeGroup.teens() : minAge = 15, maxAge = 24, name = "مراهقون";

  AgeGroup.midLife() : minAge = 33, maxAge = 40, name = "منتصف العمر";

  AgeGroup.aged() : minAge = 40, maxAge = 50, name = "مسنون (شوي)";

  AgeGroup.somewhatAged() : minAge = 50, maxAge = 60, name = "مسنون (وسط)";

  AgeGroup.reallyAged() : minAge = 60, maxAge = 70, name = "مسنون (كتير)";

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(other) {
    if (other is AgeGroup)
      return name == other.name;
    return false;
  }

  @override
  int get hashCode => super.hashCode;

}