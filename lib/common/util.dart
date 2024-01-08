
/// 날짜 시간 스트링 DateTime 변환
String convertToFormattedString(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDateTime = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  return formattedDateTime;
}

/// 퍼센트 계산
String getPercent(int leftCount, int totalCount) {
  if (totalCount == 0) {
    return "0.0";
  }

  double percent = leftCount / totalCount * 100;
  return percent.toStringAsFixed(1);
}
