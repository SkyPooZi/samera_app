import 'package:flutter/material.dart';

class ValidateHelper {
  static String? isPasswordValidate(String value, BuildContext context) {
    if (value.isEmpty) {
      return null;
    }
    if (value.length >= 8) {
      return null;
    }
    return "Password minimal 8 karakter";
  }

  static String? isEmailValidate(String value, BuildContext context) {
    if (value.isEmpty) {
      return null;
    }
    if (value.contains("@")) {
      if (value.contains(".com")) {
        return null;
      }
    }
    return "Alamat email tidak valid";
  }

  static String? isPhoneNumberValidate(String value, BuildContext context) {
    if (value.isEmpty) {
      return null;
    }
    RegExp regex = RegExp(r'^0');
    bool hasZero = regex.hasMatch(value);
    String cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    if (!hasZero && cleanedValue.length > 8 && cleanedValue.length <= 14) {
      return null;
    }
    return "Nomor HP tidak valid";
  }

  static String? isNormalValidate(
      String value, String? title, BuildContext context) {
    if (value.isEmpty) {
      return "$title${"Tidak boleh kosong"}";
    }
    return null;
  }

  static bool isPasswordValidateBool(String value) {
    if (value.isEmpty) {
      return true;
    }
    if (value.length >= 8) {
      return true;
    }
    return false;
  }

  static bool isEmailValidateBool(String value) {
    if (value.isEmpty) {
      return true;
    }
    if (value.contains("@")) {
      if (value.contains(".com")) {
        return true;
      }
    }
    return false;
  }

  static bool isPhoneNumberValidateBool(String value) {
    if (value.isEmpty) {
      return true;
    }
    RegExp regex = RegExp(r'^0');
    bool hasZero = regex.hasMatch(value);
    String cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    if (!hasZero && cleanedValue.length > 8 && cleanedValue.length <= 14) {
      return true;
    }
    return false;
  }

  static bool isNormalValidateBool(
    String value,
  ) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }
}
