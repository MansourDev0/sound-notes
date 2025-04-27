class RecordModel {
  final String recordPath;
  final String title;
  final String description;
  final DateTime time;

  RecordModel({
    required this.recordPath,
    required this.title,
    required this.description,
    required this.time,
  });

  // لتحويله إلى Map للتخزين
  Map<String, dynamic> toJson() => {
    'recordPath': recordPath,
    'title': title,
    'description': description,
    'time': time.toIso8601String(),
  };

  // لاسترجاعه من Map
  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
    recordPath: json['recordPath'],
    title: json['title'],
    description: json['description'],
    time: DateTime.parse(json['time']),
  );
}
