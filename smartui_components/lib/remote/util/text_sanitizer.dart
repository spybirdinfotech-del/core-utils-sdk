class TextSanitizer {
  static String clean(String input) {
    return input
        .replaceAll('�', "'")
        .replaceAll("'", "'")
        .replaceAll('"', '"')
        .replaceAll('"', '"')
        .replaceAll('–', '-')
        .replaceAll(RegExp(r'[^\x09\x0A\x0D\x20-\x7E\u0080-\uFFFF₹€£¥$]'), '');
  }
}
/*
\x09\x0A\x0D\x20-\x7E -> ASCII printable range (English, punctuation, numbers)
\u0900-\u097F	-> Devanagari Unicode range (Hindi, Marathi, Sanskrit)
\u0080-\uFFFF → all extended Unicode characters (covers all languages, symbols, emojis, etc.)
₹€£¥$	->Currency symbols retained
*/