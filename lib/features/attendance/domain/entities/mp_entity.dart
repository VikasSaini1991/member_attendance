import 'package:equatable/equatable.dart';

class MpEntity extends Equatable {
  final String name;
  final String divisionNo;
  final String photoUrl;
  final String state;

  const MpEntity({
    required this.name,
    required this.divisionNo,
    required this.photoUrl,
    required this.state,
  });

  @override
  List<Object?> get props => [name, divisionNo, photoUrl, state];
}
