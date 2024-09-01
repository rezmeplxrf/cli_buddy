import 'package:objectbox/objectbox.dart';

@Entity()
class ChatSessionObj {
  @Id()
  int id = 0;

  String? name;

  @Transient() // Ignore this property, not stored in the database.
  int? computedProperty;
}
