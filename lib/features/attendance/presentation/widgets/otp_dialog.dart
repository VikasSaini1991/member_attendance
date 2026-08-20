import 'package:flutter/material.dart';
import '../../domain/entities/mp_entity.dart';

class OtpDialog extends StatefulWidget {
  final MpEntity mp;
  final Function(String) onVerify;

  const OtpDialog({super.key, required this.mp, required this.onVerify});

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final TextEditingController otpTextController = TextEditingController();

  @override
  void dispose() {
    otpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("OTP Verification", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sending OTP for ${widget.mp.name}\n(Division: ${widget.mp.divisionNo})",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: otpTextController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "Enter 4-digit OTP",
              border: OutlineInputBorder(),
              counterText: "",
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => widget.onVerify(otpTextController.text),
          child: const Text("Verify OTP", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
