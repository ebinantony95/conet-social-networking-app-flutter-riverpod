import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/skill_model.dart';

class OnboardingService {
  final firestore = FirebaseFirestore.instance;
  // getting skills....
  Future<List<SkillModel>> getSkills() async {
    final snapshot = await firestore.collection("skills").get();

    return snapshot.docs.map((doc) => SkillModel.fromDoc(doc)).toList();
  }

  // getting  interest....
  Future<List<SkillModel>> getInterests() async {
    final snapshot = await firestore.collection("interest").get();

    return snapshot.docs.map((doc) => SkillModel.fromDoc(doc)).toList();
  }
}
