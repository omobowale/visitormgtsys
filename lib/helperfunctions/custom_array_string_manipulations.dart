class CustomArrayStringManipulations {
  static String convertArrayToString(List<dynamic> arr) {
    String returnedString = "";
    for (var i = 0; i < arr.length; i++) {
      returnedString += arr[i].toString();
      if (i < arr.length - 1) {
        returnedString += ", ";
      }
    }
    return returnedString;
  }
}
