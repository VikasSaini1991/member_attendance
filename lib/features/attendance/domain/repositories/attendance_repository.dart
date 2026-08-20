import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/mp_entity.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, List<MpEntity>>> getMps();
  Future<Either<Failure, bool>> verifyOtp(String otp, String divisionNo);
}
