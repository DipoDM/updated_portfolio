class UrlUtils {
  static String sanitizeForUrl(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .trim();
  }
  
  static String createSectionId(String title) {
    return sanitizeForUrl(title);
  }
}
