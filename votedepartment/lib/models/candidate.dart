class Candidate {
  int id;
  String name;
  String party;

  Candidate({
    required this.id,
    required this.name,
    required this.party,
  });

  // model for firestore
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "party": party,
    };
  }
}
