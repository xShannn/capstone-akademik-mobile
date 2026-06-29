class Helper {
  static String getInitials(String name) {
    final words = name.split(' ');

    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}';
    }

    return words[0][0];
  }
}
