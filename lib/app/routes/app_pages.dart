import 'package:get/get.dart';

import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/chatbot/bindings/chatbot_binding.dart';
import '../modules/chatbot/views/chatbot_view.dart';
import '../modules/chatbot_room/bindings/chatbot_room_binding.dart';
import '../modules/chatbot_room/views/chatbot_room_view.dart';
import '../modules/consult/bindings/consult_binding.dart';
import '../modules/consult/views/consult_view.dart';
import '../modules/create_journal/bindings/create_journal_binding.dart';
import '../modules/create_journal/views/create_journal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/journal/bindings/journal_binding.dart';
import '../modules/journal/views/journal_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mood_report/bindings/mood_report_binding.dart';
import '../modules/mood_report/views/mood_report_view.dart';
import '../modules/mood_tracker/bindings/mood_tracker_binding.dart';
import '../modules/mood_tracker/views/mood_tracker_view.dart';
import '../modules/navigation_bar/bindings/navigation_bar_binding.dart';
import '../modules/navigation_bar/views/navigation_bar_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/sleep_quality/bindings/sleep_quality_binding.dart';
import '../modules/sleep_quality/views/sleep_quality_view.dart';
import '../modules/stress_level/bindings/stress_level_binding.dart';
import '../modules/stress_level/views/stress_level_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.REPORT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_BAR,
      page: () => NavigationBarView(),
      binding: NavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE,
      page: () => const ArticleView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOT,
      page: () => const ChatbotView(),
      binding: ChatbotBinding(),
    ),
    GetPage(
      name: _Paths.CONSULT,
      page: () => const ConsultView(),
      binding: ConsultBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.JOURNAL,
      page: () => const JournalView(),
      binding: JournalBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_JOURNAL,
      page: () => const CreateJournalView(),
      binding: CreateJournalBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOT_ROOM,
      page: () => const ChatbotRoomView(),
      binding: ChatbotRoomBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.MOOD_REPORT,
      page: () => const MoodReportView(),
      binding: MoodReportBinding(),
    ),
    GetPage(
      name: _Paths.SLEEP_QUALITY,
      page: () => const SleepQualityView(),
      binding: SleepQualityBinding(),
    ),
    GetPage(
      name: _Paths.STRESS_LEVEL,
      page: () => const StressLevelView(),
      binding: StressLevelBinding(),
    ),
    GetPage(
      name: _Paths.MOOD_TRACKER,
      page: () => const MoodTrackerView(),
      binding: MoodTrackerBinding(),
    ),
  ];
}
