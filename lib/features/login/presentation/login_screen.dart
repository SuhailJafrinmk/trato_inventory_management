import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/login/bloc/login_bloc.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/icons.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadedState) {
        } else if (state is LoginErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login Succesfull')));
          Navigator.pushReplacementNamed(context, 'home_screen');
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.backgroundColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width * .9,
                  height: size.height * .7,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if(state is LoginLoadedState){
                        return Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Welcome back',
                            style: signInGreeting,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            height: size.height * .5,
                            width: size.width * .8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white)),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  AppTextfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email';
                                        }
                                        if (!RegexUtils.emailRegExp
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                      labelStyle: labeltextwhite,
                                      inputStyle: inputFieldTextWhite,
                                      obscureText: false,
                                      textEditingController: emailController,
                                      labelText: 'Email',
                                      width: size.width * .7,
                                      padding: 20,
                                      suffixIcon: AppIcons.visibility),
                                  AppTextfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a password';
                                        }
                                        return null;
                                      },
                                      labelStyle: labeltextwhite,
                                      inputStyle: inputFieldTextWhite,
                                      obscureText: false,
                                      textEditingController:
                                          passwordController,
                                      labelText: 'Password',
                                      width: size.width * .7,
                                      padding: 20),
                                  SizedBox(
                                    height: size.height * .04,
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      if (formkey.currentState!.validate()) {
                                        bloc.add(LoginButtonPressedEvent(
                                            userEmail: emailController.text,
                                            userPassword:
                                                passwordController.text));
                                      }
                                    },
                                    height: size.height * .06,
                                    width: size.width * .70,
                                    elevation: 10,
                                    color: AppColors.secondaryColor,
                                    radius: 20,
                                    child: Text(
                                      'Login',
                                      style: buttonText,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'dont have an account',
                                        style: minorText,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, 'signup');
                                          },
                                          child: Text(
                                            'SignUp',
                                            style: textbutton,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
