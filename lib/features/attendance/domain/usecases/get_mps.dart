import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/mp_entity.dart';
import '../repositories/attendance_repository.dart';

class GetMps implements UseCase<List<MpEntity>, NoParams> {
  final AttendanceRepository repository;

  GetMps(this.repository);

  @override
  Future<Either<Failure, List<MpEntity>>> call(NoParams params) async {
    return await repository.getMps();
  }
}
