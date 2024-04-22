class Validation {
  static String? validateNick(String nick) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9가-힣!@#$%^*+=\- ]+$');
    if (nick.isEmpty) {
      return '반드시 입력해야해요';
    }
    if (!regex.hasMatch(nick)) {
      return '입력할 수 없는 문자가 있어요';
    }
    if (nick.length < 4) {
      return '4글자 이상 입력해야해요';
    }
    if (nick.length > 13) {
      return '13글자까지만 가능해요';
    }
    return null;
  }

  static String? validateId(String id) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9_\.]+$');
    if (id.isEmpty) {
      return '반드시 입력해야해요';
    }
    if (!regex.hasMatch(id)) {
      return '입력할 수 없는 문자가 있어요';
    }
    if (id.length < 4) {
      return '4글자 이상 입력해야해요';
    }
    if (id.length > 20) {
      return '20글자까지 입력할 수 있어요';
    }
    return null;
  }

  static String? validatePassword(String pw) {
    if (pw.isEmpty) {
      return '반드시 입력해야해요';
    }
    RegExp regex = RegExp(r'^[a-zA-Z0-9!@#$%^*+=-]+$');
    if (!regex.hasMatch(pw)) {
      return '입력할 수 없는 문자가 있어요';
    }
    if (pw.length < 8) {
      return '8글자 이상 입력해야해요';
    }
    return null;
  }

  static String? validatePasswordCheck(String pw, String pwChk) {
    if (pwChk.isEmpty) {
      return '반드시 입력해야해요';
    }
    if (pwChk.length < 8) {
      return '8글자 이상 입력해야해요';
    }
    if (pwChk.compareTo(pw) != 0) {
      return '비밀번호가 일치하지 않아요';
    }
    return null;
  }
}
