import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rajesh_dada_padvi/controllers/authentication_controller.dart';
import 'package:rajesh_dada_padvi/helpers/validators.dart';
import 'package:rajesh_dada_padvi/widgets/custom_filled_text_field.dart';
import 'package:rajesh_dada_padvi/widgets/future_filled_dropdown.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  void dispose() {
    final state = ref.read(authenticationControllerProvider).value;

    state?.firstNameController.dispose();
    state?.middleNameController.dispose();
    state?.lastNameController.dispose();
    state?.whatsappNumberController.dispose();
    state?.mobileNumberController.dispose();
    state?.passwordController.dispose();
    state?.ageController.dispose();
    state?.emailController.dispose();

    super.dispose();
  }

  var formKey = GlobalKey<FormState>();

  Widget getScaffold(AuthenticationState state) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Light bluish background
      appBar: AppBar(
        title: const Text("Register", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create an Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.firstNameController,
                        labelText: "पहिले नाव / First Name *",
                        validator: Validators.validateEmptyField,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.middleNameController,
                        labelText: "मधले नाव / Middle Name",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.lastNameController,
                        labelText: "आडनाव / Last Name *",
                        validator: Validators.validateEmptyField,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: FutureFilledDropdown(
                              items: state.gendersList,
                              controller: state.gendersController,
                              labelText: "लिंग / Gender *",
                              titleBuilder: (item) => item,
                              validator: Validators.validateEmptyField,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: FutureFilledDropdown(
                              items: state.tehsilList,
                              controller: state.tehsilController,
                              labelText: "तालुका / Taluka *",
                              titleBuilder: (item) => item,
                              validator: Validators.validateEmptyField,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: CustomFilledTextField(
                              controller: state.ageController,
                              labelText: "वय / Age *",
                              keyboardType: TextInputType.number,
                              validator: Validators.validateEmptyField,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: FutureFilledDropdown(
                              items: state.bloodGroup,
                              controller: state.bloodGroupController,
                              labelText: "रक्त गट / Blood Group *",
                              titleBuilder: (item) => item,
                              validator: Validators.validateEmptyField,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.emailController,
                        labelText: "ईमेल / Email",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.whatsappNumberController,
                        labelText: "व्हाट्सअँप नं. / Whatsapp No.",
                        validator: Validators.validateMobileNumber,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.mobileNumberController,
                        labelText: "मो. नंबर / Mobile Number*",
                        validator: Validators.validateMobileNumber,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomFilledTextField(
                        controller: state.passwordController,
                        labelText: "पासवर्ड तयार करा / Create Password *",
                        validator: Validators.validateEmptyField,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async { 
                        if (formKey.currentState!.validate()) {
                          try {
                            EasyLoading.show();
                            var successful = await ref
                                .read(authenticationControllerProvider.notifier)
                                .userRegistration();
                            if (successful?.isRegistered == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    successful?.message ?? "",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.green.shade600,
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    successful?.message ??
                                        "Something went wrong",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.red.shade600,
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Something went wrong",
                                  style: TextStyle(color: Colors.black),
                                ),
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.red.shade600,
                              ),
                            );
                          } finally {
                            EasyLoading.dismiss();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("रजिस्टर / Register", style: TextStyle(color: Colors.black),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var asyncSignUpState = ref.watch(authenticationControllerProvider);
    return asyncSignUpState.when(
      data: (state) {
        return getScaffold(state);
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: AlertDialog(
              title: const Text("Something went wrong"),
              content: Text(error.toString()),
            ),
          ),
        );
      },
      loading: () {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}