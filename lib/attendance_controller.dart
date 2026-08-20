import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mp_model.dart';

class AttendanceController extends GetxController {
  // Dummy Rajya Sabha MPs List
  final RxList<MpModel> mpList = <MpModel>[
    MpModel(
      name: "Smt. Nirmala Sitharaman",
      divisionNo: "Div - 102",
      photoUrl: "https://via.placeholder.com/150",
      state: "Karnataka",
    ),
    MpModel(
      name: "Shri Dr. S. Jaishankar",
      divisionNo: "Div - 105",
      photoUrl: "https://via.placeholder.com/150",
      state: "Gujarat",
    ),
    MpModel(
      name: "Shri Piyush Goyal",
      divisionNo: "Div - 108",
      photoUrl: "https://via.placeholder.com/150",
      state: "Maharashtra",
    ),
    MpModel(
      name: "Shri Mallikarjun Kharge",
      divisionNo: "Div - 201",
      photoUrl: "https://via.placeholder.com/150",
      state: "Karnataka",
    ),
    MpModel(
      name: "Shri Raghav Chadha",
      divisionNo: "Div - 215",
      photoUrl: "https://via.placeholder.com/150",
      state: "Punjab",
    ),
  ].obs;

  final TextEditingController otpTextController = TextEditingController();
  final String correctOtp = "1234"; // Fixed OTP for demonstration

  // Step 1: Show OTP Input Dialog
  void showOtpDialog(MpModel mp) {
    otpTextController.clear();
    Get.defaultDialog(
      title: "OTP Verification",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              "Sending OTP for ${mp.name}\n(Division: ${mp.divisionNo})",
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
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => verifyOtp(mp),
        child: const Text("Verify OTP", style: TextStyle(color: Colors.white)),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text("Cancel"),
      ),
    );
  }

  // Step 2: Validate OTP & Handle Flow
  void verifyOtp(MpModel mp) {
    if (otpTextController.text == correctOtp) {
      Get.back(); // Close the current OTP popup
      showSuccessDialog(mp); // Open success popup
    } else {
      Get.snackbar(
        "Invalid OTP",
        "Please enter the correct OTP (Use: 1234)",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
    }
  }

  // Step 3: Show Attendance Success Popup
  void showSuccessDialog(MpModel mp) {
    Get.defaultDialog(
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
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
              onPressed: () => Get.back(),
              child: const Text("Done", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    otpTextController.dispose();
    super.onClose();
  }
}