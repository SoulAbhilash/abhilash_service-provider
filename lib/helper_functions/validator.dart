// String? Function(String?)?

import 'package:flutter/material.dart';

import 'email_validator.dart';

String? emailValidator(String? email) {
  // case : 1 -> Copy
  if (email != null && email.trim().isNotEmpty) {
    final bool isEmail = EmailValidator.validate(email);
    if (isEmail) return null;
    return "Invalid email";
  } else {
    return "Please enter email";
  }

  // case : 2
  // if (email == null || email.trim().isEmpty) {
  //   return "Please enter email";
  // } else {
  //   Pattern pattern =
  //       r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
  //   RegExp regexp = RegExp(pattern.toString());
  //   if (regexp.hasMatch(email.trim())) {
  //     return null;
  //   } else {
  //     return "Please enter valid email";
  //   }
  // }
}

String? mobileValidate(String? mobile) {
  if (mobile == null || mobile.trim().isEmpty) {
    return "Please enter mobile number";
  } else {
    if (mobile.trim().length != 10) {
      return "Invalid number";
    } else {
      return null;
    }
  }
}

String? ageValidation(String? age) {
  if (age == null || age.trim().isEmpty) {
    return null;
  } else {
    final i = int.parse(age);
    if (i == 0 || i >= 150) {
      return "Invalid age";
    } else {
      return null;
    }
  }
}

