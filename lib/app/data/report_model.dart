import 'dart:convert';

class ReportModel {
  final String mood;
  final String sleep;
  final String stress;
  final String screenTime;
  final String activity;
  final String assessment;
  final int matrix;
  final String closing;
  final List<String> shortTerm;
  final List<String> longTerm;
  final String moodTracking;
  final String screenTracking;
  final String bedTracking;
  final int stressTracking;
  final String activityTracking;

  ReportModel({
    required this.activityTracking,
    required this.screenTracking,
    required this.stressTracking,
    required this.moodTracking,
    required this.bedTracking,
    required this.matrix,
    required this.mood,
    required this.sleep,
    required this.stress,
    required this.screenTime,
    required this.activity,
    required this.assessment,
    required this.closing,
    required this.shortTerm,
    required this.longTerm,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    final track = json['track_journal_response'] ?? {};
    final tracking = json['track_journal_response']['tracking'] ?? {};
    return ReportModel(
        mood: json['mood'] ?? '',
        sleep: json['sleep'] ?? '',
        stress: json['stress'] ?? '',
        screenTime: json['screen_time'] ?? '',
        activity: json['activity'] ?? '',
        assessment: track['assesment'] ?? '',
        matrix: track['metrix'] ?? 0,
        closing: track['closing'] ?? '',
        shortTerm: track['short_term'] != null
            ? List<String>.from(jsonDecode(track['short_term']))
            : [],
        longTerm: track['long_term'] != null
            ? List<String>.from(jsonDecode(track['long_term']))
            : [],
        moodTracking: tracking['mood_level'] ?? '',
        bedTracking: tracking['bed_time'] ?? '',
        stressTracking: tracking['stress_level'] ?? 0,
        screenTracking: tracking['screen_time'] ?? '',
        activityTracking: tracking['activity'] ?? '');
  }
}
