String? emailValidator(String? value) {
  if (value!.isEmpty || !value.contains('@')) {
    return 'Please Enter a valid email address';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value!.isEmpty || value.length < 4) {
    return 'Please enter at least 4 characters';
  }
  return null;
}

String? genderValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please Choose Your Gender';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value!.isEmpty || value.length < 6) {
    return "Please Enter longer password";
  }
  return null;
}

String? confirmPasswordValidator(String? value, String? password) {
  if (value! != password) {
    return "passwords doesn't match";
  }
  return null;
}

String? accountTypeValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please Choose Your Gender';
  }
  return null;
}

String? emptyValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a value';
  }
  return null;
}
