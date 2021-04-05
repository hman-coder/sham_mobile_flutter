/// A simple class that helps in editing a value.
/// A use case would be when you want to edit the name of some user but would
/// like to also keep their original (unedited) name in case they "reset to
/// default" etc.
class ValueEditor<T> {
  final T originalValue;

  T editedValue;

  ValueEditor(this.originalValue);
}