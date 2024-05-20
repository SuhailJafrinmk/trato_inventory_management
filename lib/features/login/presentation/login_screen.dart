import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/icons.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
  final size=MediaQuery.of(context).size;
    return Scaffold(
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
                  width: size.width*.9,
                  height: size.height*.7,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20)
                  ), 
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text('Welcome back',
                        style: signInGreeting,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: Container(
                         height: size.height * .5,
                         width: size.width * .8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white
                            )
                          ),
                          child: Column(
                            children: [
                              AppTextfield(
                                labelStyle: labeltextwhite,
                                inputStyle: inputFieldTextWhite,
                                obscureText: false,
                                textEditingController:emailController,
                                labelText: 'Email',
                                width: size.width*.7,
                                padding: 20,
                                suffixIcon: AppIcons.visibility
                                ),
                              AppTextfield(
                                labelStyle: labeltextwhite,
                                inputStyle: inputFieldTextWhite,
                                obscureText: false,
                                textEditingController: passwordController,
                                labelText: 'Password',
                                width: size.width*.7,
                                padding: 20),
                              SizedBox(height: size.height*.04,),
                              CustomButton(
                                onTap: () => Navigator.pushNamed(context, 'add_store'),
                                height: size.height*.06,
                                 width: size.width*.70,
                                 elevation: 0,
                                 color: AppColors.secondaryColor,
                                 radius: 20,
                                 child: Text('Submit',style: buttonText,),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [Text('dont have an account',style: minorText,),TextButton(onPressed: (){
                                 Navigator.pushNamed(context,'signup');
                                }, child: Text('SignUp',style: textbutton,))],)
                            ],
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
      );
  }
}