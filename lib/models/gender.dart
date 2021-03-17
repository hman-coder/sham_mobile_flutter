enum Gender {
  male, female, undefined
}

extension GenderStringConverter on String {
  Gender toGender() {
    switch(this.toLowerCase()) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.undefined;
    }
  }
}

extension GenderIntConverter on int {
  Gender toGender() {
    switch(this) {
      case 1:
        return Gender.male;
      case 2:
        return Gender.female;
      default:
        return Gender.undefined;
    }
  }
}

extension GenderToOther on Gender {
  String toRawString() {
    switch(this) {
      case Gender.female:
        return 'female';
      case Gender.male:
        return 'male';
      default:
        return 'undefined';
    }
  }

  String toTranslationString() {
    switch(this) {
      case Gender.female:
        return 'gender_female';
      case Gender.male:
        return 'gender_male';
      default:
        return 'gender_undefined';
    }
  }

  int toInt(Gender value) {
    switch(value) {
      case Gender.female:
        return 2;
      case Gender.male:
        return 1;
      default:
        return 0;
    }
  }

}