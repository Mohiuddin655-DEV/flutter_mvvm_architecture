import 'package:flutter_mvvm_architecture/repository/user_repository.dart';
import 'package:flutter_mvvm_architecture/utils/dependency_injection.dart';
import 'package:get/get.dart';

import '../../data/model/user_model.dart';

class ProfileController extends GetxController {
  final UserRepository _repository = locator<UserRepository>();
  var user = const UserModel().obs;
  RxString lastFourDigitsOfPhone = "Loading...".obs;

  void fetchUser() {
    _repository.getCurrentUser().then((value) {
      user.value = value;
    });
  }

  void fetchUserLastDigitsOfPhone() {
    _repository.getLastFourNumbersPhone().then((value) {
      lastFourDigitsOfPhone.value = value ?? "";
    });
  }
}
