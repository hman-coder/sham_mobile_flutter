enum Gender {
  male, female, undefined
}

extension GenderConverters on Gender {
  static Gender fromString(String value) {
    switch(value.toLowerCase()) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.undefined;
    }
  }

  static String convertToString(Gender value) {
    switch(value) {
      case Gender.female:
        return 'female';
      case Gender.male:
        return 'male';
      default:
        return null;
    }
  }

  static Gender fromInt(int value) {
    switch(value) {
      case 1:
        return Gender.male;
      case 2:
        return Gender.female;
      default:
        return Gender.undefined;
    }
  }

  static int toInt(Gender value) {
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