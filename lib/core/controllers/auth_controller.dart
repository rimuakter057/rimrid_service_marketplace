import 'package:get/get.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/user_model.dart';

/// Mock authentication/session state. No real backend call — just enough
/// state to drive the UI flows (login, signup, logout, profile edits).
class AuthController extends GetxController {
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isProviderMode = false.obs;

  bool get isLoggedIn => user.value != null;

  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 900));
    user.value = MockData.currentUser.copyWith(email: email);
  }

  Future<void> signup({required String name, required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 900));
    user.value = MockData.currentUser.copyWith(name: name, email: email);
  }

  void updateProfile(UserModel updated) => user.value = updated;

  void logout() {
    user.value = null;
    isProviderMode.value = false;
  }

  void toggleProviderMode() => isProviderMode.value = !isProviderMode.value;
}
