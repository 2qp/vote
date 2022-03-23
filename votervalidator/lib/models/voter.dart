import 'dart:typed_data';

class Voter {
  String id;
  String rid;

  Voter({
    required this.id,
    required this.rid,
  });

  Map<String, dynamic> toMap() {
    print("dd");
    return {
      "nic": id,
      "rid": rid,
    };
  }
}
