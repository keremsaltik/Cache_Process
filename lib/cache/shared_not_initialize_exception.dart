//If shared preferences not initialize this exception will  throw
class SharedNotInitializedException implements Exception {
  @override
  String toString() {
    // TODO: implement toString
    return "Your shared preferences hasn't initialized";
  }
}
