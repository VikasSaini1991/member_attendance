import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'attendance_controller.dart';

class MemberListScreen extends StatelessWidget {
  MemberListScreen({super.key});

  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rajya Sabha MP Directory"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Obx(
            () => ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: controller.mpList.length,
          itemBuilder: (context, index) {
            final mp = controller.mpList[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Member Photo
                  CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/default_user.png",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      // Shows default image/icon when loading fails or image is missing
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_user.png', // Or use: const Icon(Icons.person, size: 30, color: Colors.grey)
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        );
                      },
                      // Optional: Show loading indicator while image loads
                     /* loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },*/
                    ),
                  )),
                    const SizedBox(width: 12),

                    // Member Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mp.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Division No: ${mp.divisionNo}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "State: ${mp.state}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Send OTP Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () => controller.showOtpDialog(mp),
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}