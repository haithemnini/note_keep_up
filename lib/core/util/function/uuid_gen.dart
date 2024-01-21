import 'package:uuid/uuid.dart';

class UUIDGen {
  UUIDGen._();

  static String generate() {
    return const Uuid().v1();
  }
}
