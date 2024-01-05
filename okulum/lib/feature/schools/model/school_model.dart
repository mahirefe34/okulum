import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class School extends Equatable {
  final String? webUrl;
  final String? name;
  final String? phoneNumber;
  final String? imageUrl;
  final String? location;
  final String? numberOfClass;
  final String? openingHours;

  const School({
    this.webUrl,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.location,
    this.numberOfClass,
    this.openingHours,
  });

  static School fromSnapshot(DocumentSnapshot snap) {
    School school = School(
      webUrl: snap['webUrl'],
      name: snap['name'],
      phoneNumber: snap['phoneNumber'],
      imageUrl: snap['imageUrl'],
      location: snap['location'],
      numberOfClass: snap['numberOfClass'],
      openingHours: snap['openingHours'],
    );
    return school;
  }

  Map<String, Object?> toDocument() {
    return {
      'webUrl': webUrl,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'location': location,
      'numberOfClass': numberOfClass,
      'openingHours': openingHours
    };
  }

  @override
  List<Object?> get props => [
        webUrl,
        name,
        phoneNumber,
        imageUrl,
        location,
        numberOfClass,
        openingHours
      ];
}
