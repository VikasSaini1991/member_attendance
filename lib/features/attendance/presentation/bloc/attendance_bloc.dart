import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_mps.dart';
import '../../domain/usecases/verify_otp.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetMps getMps;
  final VerifyOtp verifyOtp;

  AttendanceBloc({
    required this.getMps,
    required this.verifyOtp,
  }) : super(AttendanceInitial()) {
    on<GetMpsEvent>((event, emit) async {
      emit(AttendanceLoading());
      final result = await getMps(NoParams());
      result.fold(
        (failure) => emit(const AttendanceError(message: 'Server Failure')),
        (mps) => emit(MpsLoaded(mps: mps)),
      );
    });

    on<VerifyOtpEvent>((event, emit) async {
      // We don't want to emit Loading here because it would replace MpsLoaded state in UI if not handled carefully.
      // Or we can use a separate state for OTP verification.
      final result = await verifyOtp(VerifyOtpParams(otp: event.otp, divisionNo: event.mp.divisionNo));
      result.fold(
        (failure) => emit(const OtpInvalid(message: 'Verification failed')),
        (isVerified) {
          if (isVerified) {
            emit(OtpVerified(mp: event.mp));
          } else {
            emit(const OtpInvalid(message: 'Invalid OTP (Use 1234)'));
          }
        },
      );
    });
  }
}
