class NumberUtils {
  static String getTwoDecimalPos(String val) {
    final value = val.split('.');

    if (value.length > 1) {
      return '${value[0]}.${value[1].substring(1, 3)}';
    } else {
      return value[0];
    }
  }

  static String getSixDecimalPos(String val) {
    final value = val.split('.');

    if (value.length > 1) {
      return '${value[0]}.${value[1].substring(1, 7)}';
    } else {
      return value[0];
    }
  }
}
