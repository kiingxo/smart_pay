extension StringStuff on String {
  captilizeFirst() {}

  bool isValidEmail() {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-]+.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this);
  }

  String maskHalfString() {
    final length = this.length;
    final halfLength = length ~/ 2;

    final maskedString = StringBuffer();
    for (int i = 0; i < halfLength; i++) {
      maskedString.write("*");
    }
    maskedString.write(substring(halfLength));
    return maskedString.toString();
  }

  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsSpecialCharacter =>
      contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get containsDigit => contains(RegExp(r'[0-9]'));
}
