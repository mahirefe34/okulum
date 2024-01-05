part of 'school_bloc.dart';

abstract class SchoolEvent extends Equatable {
  const SchoolEvent();

  @override
  List<Object> get props => [];
}

class LoadSchool extends SchoolEvent {}

class UpdateSchool extends SchoolEvent {
  final List<School> schools;

  const UpdateSchool(this.schools);

  @override
  List<Object> get props => [schools];
}
