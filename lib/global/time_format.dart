String formatDuration(DateTime startTime, DateTime endTime) {
  Duration difference = endTime.difference(startTime);

  int hours = difference.inHours;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;

  String formattedDuration = '';

  if (hours > 0) {
    formattedDuration += '${_twoDigits(hours)}:';
  }

  formattedDuration += '${_twoDigits(minutes)}:${_twoDigits(seconds)}';

  return formattedDuration;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return '$n';
  } else {
    return '0$n';
  }
}
