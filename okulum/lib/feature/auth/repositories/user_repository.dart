import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/models.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(user.toDocument());
  }

  Stream<User> getUser(String userId) {
    print('Getting user data from Cloud Firestore');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update(user.toDocument())
        .then(
          (value) => print('User document updated.'),
        );
  }
}
