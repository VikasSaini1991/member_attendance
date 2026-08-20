import 'package:equatable/equatable.dart';
import '../../domain/entities/mp_entity.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetMpsEvent extends AttendanceEvent {}

class VerifyOtpEvent extends AttendanceEvent {
  final String otp;
  final MpEntity mp;

  const VerifyOtpEvent({required this.otp, required this.mp});

  @override
  List<Object> get props => [otp, mp];
}
