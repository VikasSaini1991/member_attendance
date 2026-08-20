import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class VerifyOtp implements UseCase<bool, VerifyOtpParams> {
  final AttendanceRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<Either<Failure, bool>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.otp, params.divisionNo);
  }
}

class VerifyOtpParams extends Equatable {
  final String otp;
  final String divisionNo;

  const VerifyOtpParams({required this.otp, required this.divisionNo});

  @override
  List<Object?> get props => [otp, divisionNo];
}
