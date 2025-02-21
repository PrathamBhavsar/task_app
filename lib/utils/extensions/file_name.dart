extension FileNameExtension on String {
  String get trimmedFileName {
    String cleanName =
        startsWith("scaled_") ? replaceFirst("scaled_", "") : this;

    if (cleanName.length > 10) {
      return "${cleanName.substring(0, 10)}...${cleanName.split('.').last}";
    } else {
      return cleanName;
    }
  }
}
