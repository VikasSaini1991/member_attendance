import '../../domain/entities/mp_entity.dart';

class MpModel extends MpEntity {
  const MpModel({
    required super.name,
    required super.divisionNo,
    required super.photoUrl,
    required super.state,
  });

  factory MpModel.fromJson(Map<String, dynamic> json) {
    return MpModel(
      name: json['name'],
      divisionNo: json['divisionNo'],
      photoUrl: json['photoUrl'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'divisionNo': divisionNo,
      'photoUrl': photoUrl,
      'state': state,
    };
  }
}
