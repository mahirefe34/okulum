import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:okulum/feature/schools/repository/school_repository.dart';

import '../model/school_model.dart';

part 'school_event.dart';
part 'school_state.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final SchoolRepository _schoolRepository;
  StreamSubscription? _schoolSubscription;

  SchoolBloc({required SchoolRepository schoolRepository})
      : _schoolRepository = schoolRepository,
        super(SchoolLoading()) {
    on<LoadSchool>(_onLoadSchool);
    on<UpdateSchool>(_onUpdateSchool);
  }

  void _onLoadSchool(event, Emitter<SchoolState> emit) {
    _schoolSubscription?.cancel();
    _schoolSubscription = _schoolRepository.getAllSchools().listen(
          (schools) => add(
            UpdateSchool(schools),
          ),
        );
  }

  void _onUpdateSchool(UpdateSchool event, Emitter<SchoolState> emit) {
    emit(SchoolLoaded(schools: event.schools));
  }
}
