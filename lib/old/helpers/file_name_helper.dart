class FileNameHelper {
  static String trimmedFileName(String fileName) {
    String cleanName = fileName.startsWith("scaled_")
        ? fileName.replaceFirst("scaled_", "")
        : fileName;

    if (cleanName.length > 10) {
      return "${cleanName.substring(0, 10)}...${cleanName.split('.').last}";
    } else {
      return cleanName;
    }
  }
}
