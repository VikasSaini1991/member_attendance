import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/bloc/theme_event.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../widgets/mp_list_tile.dart';
import '../widgets/otp_dialog.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rajya Sabha MP Directory"),
        elevation: 2,
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            Navigator.pop(context); // Close OTP Dialog
            _showSuccessDialog(context, state.mp);
          } else if (state is OtpInvalid) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceInitial) {
            context.read<AttendanceBloc>().add(GetMpsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MpsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: state.mps.length,
              itemBuilder: (context, index) {
                final mp = state.mps[index];
                return MpListTile(
                  mp: mp,
                  onSendOtp: () => _showOtpDialog(context, mp),
                );
              },
            );
          } else if (state is AttendanceError) {
            return Center(child: Text(state.message));
          }
          // Default: show list if we are in verification states
          // This happens because BlocConsumer builder doesn't remember previous MpsLoaded state automatically
          // unless we handle it in the Bloc (by yielding list in verification states) or by checking state.
          // For simplicity in this mock, we assume mps are already loaded if we reached here.
          return const SizedBox.shrink(); 
        },
        buildWhen: (previous, current) => current is MpsLoaded || current is AttendanceLoading || current is AttendanceError || current is AttendanceInitial,
      ),
    );
  }

  void _showOtpDialog(BuildContext context, mp) {
    showDialog(
      context: context,
      builder: (dialogContext) => OtpDialog(
        mp: mp,
        onVerify: (otp) {
          context.read<AttendanceBloc>().add(VerifyOtpEvent(otp: otp, mp: mp));
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, mp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 12),
              const Text(
                "Attendance Marked!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Attendance for ${mp.name} (${mp.divisionNo}) has been marked successfully.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Done", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
