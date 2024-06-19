import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/register/bloc/register_bloc.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/icons.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<RegisterBloc>(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
        } else if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Register success')));
          Navigator.pushReplacementNamed(context, 'add_store');
        } else if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(color: AppColors.backgroundColor),
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: AppColors.secondaryColor),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width * .9,
                  // height: size.height * .9,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Register',
                          style: signInGreeting,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: size.width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                AppTextfield(
                                  validateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username is required.';
                                    }
                                    if (!RegexUtils.username.hasMatch(value)) {
                                      return 'Username must contain only alphanumeric characters and underscores.';
                                    }
                                    if (value.length < 3 || value.length > 20) {
                                      return 'Username must be between 3 and 20 characters long.';
                                    }
                                    return null;
                                  },
                                  textEditingController: usernameController,
                                  labelStyle: labeltextwhite,
                                  inputStyle: inputFieldTextWhite,
                                  obscureText: false,
                                  labelText: 'Username',
                                  width: size.width * .7,
                                  padding: 20,
                                ),
                                AppTextfield(
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required.';
                                      }
                                      if (!RegexUtils.emailRegExp
                                          .hasMatch(value)) {
                                        return 'Invalid email address.';
                                      }
                                      return null;
                                    },
                                    textEditingController: emailController,
                                    labelStyle: labeltextwhite,
                                    inputStyle: inputFieldTextWhite,
                                    obscureText: false,
                                    labelText: 'Email',
                                    width: size.width * .7,
                                    padding: 20),
                                AppTextfield(
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters long';
                                      }
                                      if (!RegexUtils.atLeastAnUppercase
                                          .hasMatch(value)) {
                                        return 'Password must contain at least one uppercase letter';
                                      }
                                      if (!RegexUtils.atLeastANumber
                                          .hasMatch(value)) {
                                        return 'Password must contain at least one number';
                                      }
                                      if (!RegexUtils.specialChar
                                          .hasMatch(value)) {
                                        return 'Password must contain at least one special character';
                                      }
                                      return null;
                                    },
                                    textEditingController: passwordController,
                                    labelStyle: labeltextwhite,
                                    inputStyle: inputFieldTextWhite,
                                    obscureText: false,
                                    labelText: 'Password',
                                    width: size.width * .7,
                                    padding: 20,
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                        ))),
                                AppTextfield(
                                  validateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter a password';
                                    }
                                    if (value != passwordController.text) {
                                      return 'passwords didnt match';
                                    }
                                    return null;
                                  },
                                  labelStyle: labeltextwhite,
                                  inputStyle: inputFieldTextWhite,
                                  obscureText: false,
                                  labelText: 'Confirm password',
                                  width: size.width * .7,
                                  padding: 20,
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )),
                                ),
                                CustomButton(
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      bloc.add(RegisterButtonClickedEvent(
                                        userName: usernameController.text,
                                        useEmail: emailController.text,
                                        password: passwordController.text,
                                      ));
                                    }
                                  },
                                  height: size.height * .06,
                                  width: size.width * .70,
                                  elevation: 0,
                                  color: AppColors.secondaryColor,
                                  radius: 20,
                                  child: BlocBuilder<RegisterBloc, RegisterState>(
                                    builder: (context, state) {
                                      if(state is RegisterLoadingState){
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Registering...',style: TextStyle(fontSize: 20,color: Colors.white),),
                                            LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 25),
                                          ],
                                        );
                                      }
                                      return Text(
                                        'Submit',
                                        style: buttonText,
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Already have an account',style: TextStyle(color: Colors.white38),),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, 'login');
                                        },
                                        child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
