import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:member_attendance/core/error/failures.dart';
import 'package:member_attendance/core/usecases/usecase.dart';
import 'package:member_attendance/features/attendance/domain/entities/mp_entity.dart';
import 'package:member_attendance/features/attendance/domain/usecases/get_mps.dart';
import 'package:member_attendance/features/attendance/domain/usecases/verify_otp.dart';
import 'package:member_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:member_attendance/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:member_attendance/features/attendance/presentation/bloc/attendance_state.dart';

class MockGetMps extends Mock implements GetMps {}
class MockVerifyOtp extends Mock implements VerifyOtp {}

void main() {
  late AttendanceBloc bloc;
  late MockGetMps mockGetMps;
  late MockVerifyOtp mockVerifyOtp;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(const VerifyOtpParams(otp: '', divisionNo: ''));
  });

  setUp(() {
    mockGetMps = MockGetMps();
    mockVerifyOtp = MockVerifyOtp();
    bloc = AttendanceBloc(getMps: mockGetMps, verifyOtp: mockVerifyOtp);
  });

  tearDown(() {
    bloc.close();
  });

  const tMp = MpEntity(
    name: 'Test MP',
    divisionNo: '101',
    photoUrl: 'http://example.com',
    state: 'State',
  );
  final tMpsList = [tMp];

  test('initialState should be AttendanceInitial', () {
    expect(bloc.state, equals(AttendanceInitial()));
  });

  group('GetMpsEvent', () {
    blocTest<AttendanceBloc, AttendanceState>(
      'should emit [AttendanceLoading, MpsLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetMps(any())).thenAnswer((_) async => Right(tMpsList));
        return bloc;
      },
      act: (bloc) => bloc.add(GetMpsEvent()),
      expect: () => [
        AttendanceLoading(),
        MpsLoaded(mps: tMpsList),
      ],
      verify: (_) {
        verify(() => mockGetMps(NoParams())).called(1);
      },
    );

    blocTest<AttendanceBloc, AttendanceState>(
      'should emit [AttendanceLoading, AttendanceError] when getting data fails',
      build: () {
        when(() => mockGetMps(any())).thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetMpsEvent()),
      expect: () => [
        AttendanceLoading(),
        const AttendanceError(message: 'Server Failure'),
      ],
    );
  });

  group('VerifyOtpEvent', () {
    const tOtp = '1234';
    const tParams = VerifyOtpParams(otp: tOtp, divisionNo: '101');

    blocTest<AttendanceBloc, AttendanceState>(
      'should emit [OtpVerified] when OTP is verified successfully',
      build: () {
        when(() => mockVerifyOtp(any())).thenAnswer((_) async => const Right(true));
        return bloc;
      },
      act: (bloc) => bloc.add(const VerifyOtpEvent(otp: tOtp, mp: tMp)),
      expect: () => [
        const OtpVerified(mp: tMp),
      ],
      verify: (_) {
        verify(() => mockVerifyOtp(tParams)).called(1);
      },
    );

    blocTest<AttendanceBloc, AttendanceState>(
      'should emit [OtpInvalid] when OTP is incorrect',
      build: () {
        when(() => mockVerifyOtp(any())).thenAnswer((_) async => const Right(false));
        return bloc;
      },
      act: (bloc) => bloc.add(const VerifyOtpEvent(otp: 'wrong', mp: tMp)),
      expect: () => [
        const OtpInvalid(message: 'Invalid OTP (Use 1234)'),
      ],
    );
  });
}

class ServerFailure extends Failure {}
