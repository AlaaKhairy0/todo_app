import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/assets_manager.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/constants_manager.dart';
import 'package:todo_app/core/utils/routes_manager.dart';
import 'package:todo_app/core/utils/strings_manager.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:todo_app/presentation/screens/auth/widgets/custom_text_field.dart';
import '../../../../core/utils/dialogs/dialogs.dart';
import '../../../../core/utils/email_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../providers/theme_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: REdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: SvgPicture.asset(
                  AssetsManager.routeLogo,
                  width: 237.w,
                  height: 70.h,
                ),
              ),
              SizedBox(
                height: 120.h,
              ),
              Text(AppLocalizations.of(context)!.email,
                  style: themeProvider.isLightMode()
                      ? LightAppStyle.authTitle
                      : DarkAppStyle.authTitle),
              SizedBox(
                height: 6.h,
              ),
              CustomTextField(
                hint: AppLocalizations.of(context)!.emailHint,
                controller: emailController,
                keyboard: TextInputType.emailAddress,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'please enter your email';
                  }
                  if (!isValidEmail(input)) {
                    return "email doesn't support the format";
                  }
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(AppLocalizations.of(context)!.password,
                  style: themeProvider.isLightMode()
                      ? LightAppStyle.authTitle
                      : DarkAppStyle.authTitle),
              SizedBox(
                height: 6.h,
              ),
              CustomTextField(
                hint: AppLocalizations.of(context)!.passwordHint,
                controller: passwordController,
                keyboard: TextInputType.visiblePassword,
                isHidden: true,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'please enter your password';
                  }
                },
              ),
              SizedBox(
                height: 60.h,
              ),
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(ColorsManager.white),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            side: BorderSide(color: ColorsManager.white),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))))),
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: themeProvider.isLightMode()
                          ? LightAppStyle.authButton
                          : DarkAppStyle.authButton,
                    )),
              ),
              SizedBox(
                height: 16.h,
              ),
              Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesManager.register);
                    },
                    child: Text(
                  AppLocalizations.of(context)!.createAccount,
                  style: themeProvider.isLightMode()
                      ? LightAppStyle.haveAccount
                      : DarkAppStyle.haveAccount,
                ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      MyDialog.showLoading(context, text: 'Waiting...');
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.currentUser = await getUserAccount(credential.user!.uid);
      if (mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(
          context,
          body: 'User logged-in successfully',
          posActionTitle: 'Ok',
          posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.home);
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      late String message;
      if (mounted) {
        MyDialog.hide(context);
      }
      if (e.code == ConstantsManager.wrongEmailOrPassword) {
        message = StringsManager.wrongEmailOrPassword;
      }
      if (mounted) {
        MyDialog.showMessage(
          context,
          title: 'Error',
          body: message,
          posActionTitle: 'Try again',
        );
      }
    } catch (e) {
      if (mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(context,
            title: 'Error', body: e.toString(), posActionTitle: 'Try again');
      }
    }
  }

  Future<UserDM> getUserAccount(uid) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = userCollection.doc(uid);
    DocumentSnapshot userSnapShot = await userDocument.get();
    Map<String, dynamic> json = userSnapShot.data() as Map<String, dynamic>;
    UserDM user = UserDM.getUserFromFireStore(json);
    return user;
  }
}
