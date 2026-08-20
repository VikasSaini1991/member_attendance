import 'package:flutter_test/flutter_test.dart';
import 'package:member_attendance/features/attendance/domain/entities/mp_entity.dart';

void main() {
  const tMpEntity = MpEntity(
    name: 'Test MP',
    divisionNo: '101',
    photoUrl: 'http://example.com/photo.jpg',
    state: 'Test State',
  );

  test('should support value equality', () {
    expect(
      tMpEntity,
      const MpEntity(
        name: 'Test MP',
        divisionNo: '101',
        photoUrl: 'http://example.com/photo.jpg',
        state: 'Test State',
      ),
    );
  });

  test('props should contain all fields', () {
    expect(
      tMpEntity.props,
      ['Test MP', '101', 'http://example.com/photo.jpg', 'Test State'],
    );
  });
}
