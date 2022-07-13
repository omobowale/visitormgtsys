class CustomStringManipulation {
  static String getFullName(String first, String last) {
    return "$first $last";
  }

  static bool validatEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static bool validatPhoneNumber(String phoneNumber) {
    bool phoneNumberValid =
        RegExp(r"^0[7-9][0-1][0-9]{8}$").hasMatch(phoneNumber);
    return phoneNumberValid;
  }
}
