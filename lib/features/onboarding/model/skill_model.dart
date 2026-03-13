import 'package:cloud_firestore/cloud_firestore.dart';

class SkillModel {
  final String id;
  final String name;

  SkillModel({required this.id, required this.name});

  factory SkillModel.fromDoc(QueryDocumentSnapshot doc) {
    // avoid nullsafty issue (qds)
    final data = doc.data() as Map<String, dynamic>;

    return SkillModel(id: doc.id, name: data['name']);
  }
}
