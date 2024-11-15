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
import 'package:todo_app/core/utils/dialogs/dialogs.dart';
import 'package:todo_app/core/utils/routes_manager.dart';
import 'package:todo_app/core/utils/strings_manager.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:todo_app/presentation/screens/auth/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/email_validation.dart';
import '../../../../providers/theme_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                height: 20.h,
              ),
              Center(
                child: SvgPicture.asset(
                  AssetsManager.routeLogo,
                  width: 237.w,
                  height: 70.h,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(AppLocalizations.of(context)!.fullName,
                  style: themeProvider.isLightMode()
                      ? LightAppStyle.authTitle
                      : DarkAppStyle.authTitle),
              SizedBox(
                height: 6.h,
              ),
              CustomTextField(
                hint: AppLocalizations.of(context)!.fullNameHint,
                controller: fullNameController,
                keyboard: TextInputType.name,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'please enter your full name';
                  }
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(AppLocalizations.of(context)!.userName,
                  style: themeProvider.isLightMode()
                      ? LightAppStyle.authTitle
                      : DarkAppStyle.authTitle),
              SizedBox(
                height: 6.h,
              ),
              CustomTextField(
                hint: AppLocalizations.of(context)!.userNameHint,
                controller: userNameController,
                keyboard: TextInputType.name,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'please enter your user name';
                  }
                },
              ),
              SizedBox(
                height: 8.h,
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
                height: 8.h,
              ),
              Text(AppLocalizations.of(context)!.confirmPassword,
                  style: themeProvider.isLightMode()
                      ? LightAppStyle.authTitle
                      : DarkAppStyle.authTitle),
              SizedBox(
                height: 6.h,
              ),
              CustomTextField(
                hint: AppLocalizations.of(context)!.confirmPasswordHint,
                controller: confirmPasswordController,
                keyboard: TextInputType.visiblePassword,
                isHidden: true,
                validator: (input) {
                  if (input != passwordController.text) {
                    return "Password doesn't match";
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
                      register();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
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
                      Navigator.pushReplacementNamed(context, RoutesManager.login);
                    },
                    child: Text(
                  AppLocalizations.of(context)!.haveAccount,
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

  void register() async {
    if (formKey.currentState?.validate() == false) return;
    try {
      MyDialog.showLoading(context, text: 'Waiting...');
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      createUserAccount(credential.user!.uid);
      if (mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(
          context,
          body: 'Account created successfully',
          posActionTitle: 'Ok',
          posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.login);
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      late String message;
      if (mounted) {
        MyDialog.hide(context);
      }
      if (e.code == ConstantsManager.weakPassword) {
        message = StringsManager.weakPassword;
      } else if (e.code == ConstantsManager.emailInUse) {
        message = StringsManager.emailInUse;
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

  void createUserAccount(uid) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = userCollection.doc(uid);
    UserDM user = UserDM(
        id: uid,
        fullName: fullNameController.text,
        userName: userNameController.text,
        email: emailController.text);
    await userDocument.set(user.addUserToFireStore());
  }
}
