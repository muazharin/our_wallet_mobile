String? validationString(String? value) {
  if (value!.isEmpty) {
    return "Tidak boleh kosong";
  }
  return null;
}

String? validationPhoneNumber(String? value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return "Tidak boleh kosong";
  } else if (value.length < 10) {
    return "Minimal 10 digit";
  } else if (!regExp.hasMatch(value)) {
    return "Harus angka";
  }
  return null;
}

String? validationPassword(String? value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Tidak boleh kosong";
  } else if (!regExp.hasMatch(value)) {
    return "Minimal 9 karakter dan harus memiliki minimal 1 huruf kecil, 1 huruf besar,1 angka dan 1 spesial character ( ! @ # \$ & * ~ ) ";
  }
  return null;
}

String? validationEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Tidak boleh kosong";
  } else if (!regExp.hasMatch(value)) {
    return "Tidak valid";
  } else {
    return null;
  }
}

String? validationNumber(String? value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return "Tidak boleh kosong";
  } else if (!regExp.hasMatch(value)) {
    return "Harus angka";
  }
  return null;
}
