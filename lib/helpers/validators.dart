abstract class Validators{

  static String? validateEmptyField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mandatory field*";
    }
    return null;
  }


   static String? validateMobileNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Mobile number is required";
  } else if (value.length != 10) {
    return "Mobile number must be 10 digits";
  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    return "Only digits allowed";
  }
  return null;
}


   static String? usernameOrEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    final usernameRegex = RegExp(r'^[a-zA-Z0-9._]{3,}$');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!usernameRegex.hasMatch(value) && !emailRegex.hasMatch(value)) {
      return 'Enter a valid username or email';
    }

    return null;
  }
}