import 'package:flutter/cupertino.dart';

class FlaggedObject<T> extends ChangeNotifier {
  bool _flagged;

  T value;

  FlaggedObject({@required this.value, bool flagged = false}) : _flagged = flagged;

  set isFlagged(bool flag) {
    _flagged = flag;
    notifyListeners();
  }

  bool get isFlagged => _flagged;

  void switchFlag() {
    _flagged = ! _flagged;
    notifyListeners();
  }
}