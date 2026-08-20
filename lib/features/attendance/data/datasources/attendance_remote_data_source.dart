import '../models/mp_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<MpModel>> getMps();
  Future<bool> verifyOtp(String otp, String divisionNo);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  @override
  Future<List<MpModel>> getMps() async {
    // Mocking remote data
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
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
    ];
  }

  @override
  Future<bool> verifyOtp(String otp, String divisionNo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return otp == "1234";
  }
}
