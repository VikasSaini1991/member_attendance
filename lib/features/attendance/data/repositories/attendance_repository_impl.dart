import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/mp_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MpEntity>>> getMps() async {
    try {
      final remoteMps = await remoteDataSource.getMps();
      return Right(remoteMps);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String otp, String divisionNo) async {
    try {
      final isVerified = await remoteDataSource.verifyOtp(otp, divisionNo);
      return Right(isVerified);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
