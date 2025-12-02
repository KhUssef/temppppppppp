import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static const _kEmail = 'current_user_email';
  static const _kName = 'current_user_name';

  /// Save user data to SharedPreferences
  Future<void> saveCurrentUser(User user) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kEmail, user.email);
    await sp.setString(_kName, user.fullName);
    print('User Saved Successfully');
  }

  /// Return the current user, or null if not found
  Future<User?> getCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    final email = sp.getString(_kEmail);
    if (email == null) return null;
    final fullName = sp.getString(_kName) ?? '';
    return User(email: email, fullName: fullName);
  }

  /// Remove stored user data
  Future<void> clearCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kEmail);
    await sp.remove(_kName);
    print('User cleared from SharedPreferences');
  }
}
