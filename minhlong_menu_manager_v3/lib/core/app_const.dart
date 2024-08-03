import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultPadding = 16;
const double defaultMargin = 16;
const double textFieldBorderRadius = 6;
const double defaultBorderRadius = 20;
const double defaultButtonHeight = 48;

String? fontFamily() => GoogleFonts.lato().fontFamily;

const List<DropdownMenuItem<String>> itemsDropdown = [
  DropdownMenuItem(value: '10', child: Text('10')),
  DropdownMenuItem(value: '20', child: Text('20')),
  DropdownMenuItem(value: '30', child: Text('30')),
  DropdownMenuItem(value: '40', child: Text('40')),
  DropdownMenuItem(value: '50', child: Text('50')),
];
