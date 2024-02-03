String formatDuration(DateTime startTime, DateTime endTime) {
  Duration difference = endTime.difference(startTime);

  int hours = difference.inHours;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;

  String formattedDuration = '';

  if (hours > 0) {
    formattedDuration += '${_twoDigits(hours)}h ';
  }

  formattedDuration += '${_twoDigits(minutes)}m ${_twoDigits(seconds)}s';

  return formattedDuration;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return '$n';
  } else {
    return '0$n';
  }
}

String formatHour(DateTime dateTime) {
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  String period = (hour < 12) ? 'AM' : 'PM';

  // Convertir la hora al formato de 12 horas
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  // Asegurarse de que los minutos tengan dos dígitos
  String minuteString = (minute < 10) ? '0$minute' : '$minute';

  return '$hour:$minuteString $period';
}
