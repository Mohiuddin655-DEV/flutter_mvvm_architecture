import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/res/components/appbar_title.dart';
import 'package:flutter_mvvm_architecture/res/components/auth_text_field.dart';
import 'package:flutter_mvvm_architecture/res/components/rounded_button.dart';
import 'package:flutter_mvvm_architecture/viewmodel/controllers/login_view_model.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppbarTitle(
          text: "login".tr,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 32,
        ),
        child: Column(
          children: [
            AuthTextField(
              controller: viewModel.etUsername.value,
              text: "2088888",
              hint: "username_hint".tr,
              inputType: TextInputType.number,
            ),
            AuthTextField(
              controller: viewModel.etPassword.value,
              hint: "password_hint".tr,
              text: "ral11lod",
              inputType: TextInputType.visiblePassword,
            ),
            Obx(() {
              return RoundedButton(
                text: "login".tr,
                loading: viewModel.loading.value,
                onClick: (con) => viewModel.login(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
