import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:okulum/feature/schools/model/school_model.dart';

class SchoolRepository {
  final FirebaseFirestore _firebaseFirestore;

  SchoolRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<School>> getAllSchools() {
    return _firebaseFirestore.collection('schools').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => School.fromSnapshot(e)).toList();
    });
  }
}
