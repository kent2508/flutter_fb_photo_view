extension ImageSourcePath on String {
  bool get isNetworkSource => startsWith('http://') || startsWith('https://');
}
