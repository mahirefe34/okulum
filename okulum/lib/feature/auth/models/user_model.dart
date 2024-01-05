import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? photo;
  final String? deviceToken;
  final String? isFirstAccess;

  const User(
      {required this.uid,
      this.email,
      this.name,
      this.phoneNumber,
      this.photo,
      this.deviceToken,
      this.isFirstAccess});

  static const empty = User(uid: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  User copyWith(
      {String? fullName,
      String? email,
      String? name,
      String? phoneNumber,
      String? photo,
      String? deviceToken,
      String? isFirstAccess}) {
    return User(
        uid: uid,
        email: email ?? this.email,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photo: photo ?? this.photo,
        deviceToken: deviceToken ?? this.deviceToken,
        isFirstAccess: isFirstAccess ?? this.isFirstAccess);
  }

  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
      uid: snap.id,
      email: snap['email'],
      name: snap['name'],
      phoneNumber: snap['phoneNumber'],
      photo: snap['photo'],
      deviceToken: snap['deviceToken'],
      isFirstAccess: snap['isFirstAccess'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'photo': photo,
      'deviceToken': deviceToken,
      'isFirstAccess': isFirstAccess
    };
  }

  @override
  List<Object?> get props =>
      [uid, email, name, phoneNumber, photo, deviceToken, isFirstAccess];
}
