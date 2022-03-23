import 'package:cloud_firestore/cloud_firestore.dart';

class Weapon {
  final int id;
  final String name;
  final String party;
  final String img;

  Weapon({
    required this.id,
    required this.name,
    required this.party,
    required this.img,
  });

  factory Weapon.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    return Weapon(
        id: data['id'] ?? '',
        name: data['name'] ?? '',
        party: data['party'] ?? 0,
        img: data['img'] ?? '');
  }
}
