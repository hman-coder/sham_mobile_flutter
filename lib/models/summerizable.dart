/// A class that reduces boilerplate code needed to
/// list the items in a list.
///
/// For instance, to summarize a list of summarizable
/// use the extension on that list. The output will
/// be something like item1; item2; etc , depending
/// on the separator you use
abstract class Summarizable {
  String get name;
}

extension Summarize<T extends Summarizable> on List<T> {
  String summarize({String separator}) {
    return this.map<String>((e) => e.name)
        .reduce((element1, element2) => '$element1${separator ?? ';'} $element2');
  }
}