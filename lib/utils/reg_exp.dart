bool checkEmailValidation(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool checkPasswordValidation(String password) {
  return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
      .hasMatch(password);
}

bool checkNumberValidation(String numb) {
  return RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(numb);
}

bool checkNameValidation(String name) {
  return RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
      .hasMatch(name);
}

bool checkAadharValidation(String num) {
  return RegExp(r'[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(num);
}

bool checkPincodeValidation(String pin) {
  return RegExp(r'^[1-9]{1}[0-9]{2}\s{0,1}[0-9]{3}$').hasMatch(pin);
}

