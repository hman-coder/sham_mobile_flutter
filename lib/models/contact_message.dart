/// A message that would be sent to either library
/// management or app management or both.
class ContactMessage {
  String subject;
  String content;
  bool toLibrary;
  bool toApp;

  ContactMessage({this.subject = '', this.content = '', this.toLibrary = true, this.toApp = false});
}
