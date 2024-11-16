import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class LightAppStyle {
  static TextStyle appBar = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.white,
  );
  static TextStyle settingsTabLabel = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.black,
  );
  static TextStyle settingsTabSelectedItem = GoogleFonts.inter(
    color: ColorsManager.blue,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bottomSheetTitle = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );
  static TextStyle textFieldHint = GoogleFonts.inter(
    color: ColorsManager.hint,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle date = GoogleFonts.inter(
    color: ColorsManager.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle taskItemTitle = GoogleFonts.poppins(
    color: ColorsManager.blue,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle taskItemDescription = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle selectedDate = GoogleFonts.roboto(
      fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorsManager.blue);
  static TextStyle unselectedDate = GoogleFonts.roboto(
      fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorsManager.black);
  static TextStyle editingTaskTitle = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle authHint = GoogleFonts.poppins(
    color: ColorsManager.black.withOpacity(.7),
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );
  static TextStyle authTitle = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  static TextStyle authButton = GoogleFonts.poppins(
    color: ColorsManager.blue,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );
  static TextStyle haveAccount = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  static TextStyle controller = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontSize: 18.sp,
  );
  static TextStyle saveButton = GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w400, color: ColorsManager.white);
  static TextStyle doneStatus = GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.w700, color: ColorsManager.green);
  static TextStyle taskItemDoneTitle = GoogleFonts.poppins(
    color: ColorsManager.green,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
}

class DarkAppStyle {
  static TextStyle appBar = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.darkScaffoldBg,
  );
  static TextStyle settingsTabLabel = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.white,
  );
  static TextStyle settingsTabSelectedItem = GoogleFonts.inter(
    color: ColorsManager.blue,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bottomSheetTitle = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
  );
  static TextStyle textFieldHint = GoogleFonts.inter(
    color: ColorsManager.hint,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle date = GoogleFonts.inter(
    color: ColorsManager.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle taskItemTitle = GoogleFonts.poppins(
    color: ColorsManager.blue,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle taskItemDescription = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle selectedDate = GoogleFonts.roboto(
      fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorsManager.blue);
  static TextStyle unselectedDate = GoogleFonts.roboto(
      fontSize: 16.sp, fontWeight: FontWeight.w700, color: ColorsManager.white);
  static TextStyle editingTaskTitle = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle authHint = GoogleFonts.poppins(
    color: ColorsManager.black.withOpacity(.7),
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );
  static TextStyle authTitle = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  static TextStyle authButton = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );
  static TextStyle haveAccount = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  static TextStyle controller = GoogleFonts.poppins(
    color: ColorsManager.white,
  );
  static TextStyle saveButton = GoogleFonts.inter(
      fontSize: 18, fontWeight: FontWeight.w400, color: ColorsManager.white);
  static TextStyle doneStatus = GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.w700, color: ColorsManager.green);
  static TextStyle taskItemDoneTitle = GoogleFonts.poppins(
    color: ColorsManager.green,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
}
