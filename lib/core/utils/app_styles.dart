import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class LightAppStyle {
  static TextStyle appBar = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: ColorsManager.white,
  );
  static TextStyle settingsTabLabel = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ColorsManager.black,
  );
  static TextStyle settingsTabSelectedItem = GoogleFonts.inter(
    color: ColorsManager.blue,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bottomSheetTitle = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
  static TextStyle textFieldHint = GoogleFonts.inter(
    color: ColorsManager.hint,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle date = GoogleFonts.inter(
    color: ColorsManager.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle taskItemTitle = GoogleFonts.poppins(
    color: ColorsManager.blue,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static TextStyle taskItemDescription = GoogleFonts.poppins(
    color: ColorsManager.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
