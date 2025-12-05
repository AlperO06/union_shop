import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/user.dart';

void main() {
  group('AppUser Model', () {
    test('should create user from JSON', () {
      final json = {
        'uid': 'test123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'photoUrl': 'https://example.com/photo.jpg',
        'phoneNumber': '+1234567890',
        'createdAt': '2025-01-01T00:00:00.000Z',
        'lastLoginAt': '2025-12-05T12:00:00.000Z',
        'orderHistory': ['order1', 'order2'],
        'preferences': {'theme': 'dark'},
      };

      final user = AppUser.fromJson(json);

      expect(user.uid, 'test123');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
      expect(user.phoneNumber, '+1234567890');
      expect(user.orderHistory, ['order1', 'order2']);
      expect(user.preferences['theme'], 'dark');
    });

    test('should convert user to JSON', () {
      final user = AppUser(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        phoneNumber: '+1234567890',
        orderHistory: ['order1', 'order2'],
        preferences: {'theme': 'dark'},
      );

      final json = user.toJson();

      expect(json['uid'], 'test123');
      expect(json['email'], 'test@example.com');
      expect(json['displayName'], 'Test User');
      expect(json['photoUrl'], 'https://example.com/photo.jpg');
      expect(json['phoneNumber'], '+1234567890');
      expect(json['orderHistory'], ['order1', 'order2']);
      expect(json['preferences']['theme'], 'dark');
    });

    test('should create copy with updated fields', () {
      final user = AppUser(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
      );

      final updatedUser = user.copyWith(displayName: 'Updated User');

      expect(updatedUser.uid, 'test123');
      expect(updatedUser.email, 'test@example.com');
      expect(updatedUser.displayName, 'Updated User');
    });

    test('should generate correct initials', () {
      final user = AppUser(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'John Doe',
      );

      expect(user.initials, 'JD');
    });

    test('should handle null display name for initials', () {
      final user = AppUser(
        uid: 'test123',
        email: 'test@example.com',
      );

      expect(user.initials, 'T');
    });
  });
}
