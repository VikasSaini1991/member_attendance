import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:member_attendance/core/theme/bloc/theme_bloc.dart';
import 'package:member_attendance/core/theme/bloc/theme_event.dart';
import 'package:member_attendance/core/theme/bloc/theme_state.dart';
import 'package:member_attendance/features/attendance/domain/entities/mp_entity.dart';
import 'package:member_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:member_attendance/features/attendance/presentation/bloc/attendance_event.dart';
import 'package:member_attendance/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:member_attendance/features/attendance/presentation/pages/member_list_page.dart';

class MockAttendanceBloc extends MockBloc<AttendanceEvent, AttendanceState> implements AttendanceBloc {}
class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState> implements ThemeBloc {}

void main() {
  late MockAttendanceBloc mockAttendanceBloc;
  late MockThemeBloc mockThemeBloc;

  setUp(() {
    mockAttendanceBloc = MockAttendanceBloc();
    mockThemeBloc = MockThemeBloc();
  });

  const tMps = [
    MpEntity(
      name: 'John Doe',
      divisionNo: '101',
      photoUrl: '',
      state: 'State A',
    ),
  ];

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AttendanceBloc>.value(value: mockAttendanceBloc),
        BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should show loading indicator when state is AttendanceLoading', (tester) async {
    when(() => mockAttendanceBloc.state).thenReturn(AttendanceLoading());
    when(() => mockThemeBloc.state).thenReturn(const ThemeState(ThemeMode.light));

    await tester.pumpWidget(makeTestableWidget(const MemberListPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show list of MPs when state is MpsLoaded', (tester) async {
    when(() => mockAttendanceBloc.state).thenReturn(const MpsLoaded(mps: tMps));
    when(() => mockThemeBloc.state).thenReturn(const ThemeState(ThemeMode.light));

    await tester.pumpWidget(makeTestableWidget(const MemberListPage()));

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Division No: 101'), findsOneWidget);
  });

  testWidgets('should show error message when state is AttendanceError', (tester) async {
    when(() => mockAttendanceBloc.state).thenReturn(const AttendanceError(message: 'Error occurred'));
    when(() => mockThemeBloc.state).thenReturn(const ThemeState(ThemeMode.light));

    await tester.pumpWidget(makeTestableWidget(const MemberListPage()));

    expect(find.text('Error occurred'), findsOneWidget);
  });
}
