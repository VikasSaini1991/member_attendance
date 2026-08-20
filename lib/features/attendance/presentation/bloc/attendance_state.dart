import 'package:equatable/equatable.dart';
import '../../domain/entities/mp_entity.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class MpsLoaded extends AttendanceState {
  final List<MpEntity> mps;

  const MpsLoaded({required this.mps});

  @override
  List<Object> get props => [mps];
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpVerified extends AttendanceState {
  final MpEntity mp;

  const OtpVerified({required this.mp});

  @override
  List<Object> get props => [mp];
}

class OtpInvalid extends AttendanceState {
  final String message;

  const OtpInvalid({required this.message});

  @override
  List<Object> get props => [message];
}
