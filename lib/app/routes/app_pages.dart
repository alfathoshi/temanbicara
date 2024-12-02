import 'package:get/get.dart';

import '../modules/Tracking/bindings/tracking_binding.dart';
import '../modules/Tracking/views/tracking_view.dart';
import '../modules/Tracking_2/bindings/tracking_2_binding.dart';
import '../modules/Tracking_2/views/tracking_2_view.dart';
import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/article/bindings/article_binding.dart';
import '../modules/article/views/article_view.dart';
import '../modules/assesment_1/bindings/assesment_1_binding.dart';
import '../modules/assesment_1/views/assesment_1_view.dart';
import '../modules/assesment_2/bindings/assesment_2_binding.dart';
import '../modules/assesment_2/views/assesment_2_view.dart';
import '../modules/assesment_3/bindings/assesment_3_binding.dart';
import '../modules/assesment_3/views/assesment_3_view.dart';
import '../modules/assesment_4/bindings/assesment_4_binding.dart';
import '../modules/assesment_4/views/assesment_4_view.dart';
import '../modules/assesment_5/bindings/assesment_5_binding.dart';
import '../modules/assesment_5/views/assesment_5_view.dart';
import '../modules/assesment_6/bindings/assesment_6_binding.dart';
import '../modules/assesment_6/views/assesment_6_view.dart';
import '../modules/assesment_7/bindings/assesment_7_binding.dart';
import '../modules/assesment_7/views/assesment_7_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chatbot/bindings/chatbot_binding.dart';
import '../modules/chatbot/views/chatbot_view.dart';
import '../modules/chatbot_room/bindings/chatbot_room_binding.dart';
import '../modules/chatbot_room/views/chatbot_room_view.dart';
import '../modules/consult/bindings/consult_binding.dart';
import '../modules/consult/views/consult_view.dart';
import '../modules/create_journal/bindings/create_journal_binding.dart';
import '../modules/create_journal/views/create_journal_view.dart';
import '../modules/detail_artikel/bindings/detail_artikel_binding.dart';
import '../modules/detail_artikel/views/detail_artikel_view.dart';
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
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/room_chat/bindings/room_chat_binding.dart';
import '../modules/room_chat/views/room_chat_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/sleep_quality/bindings/sleep_quality_binding.dart';
import '../modules/sleep_quality/views/sleep_quality_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/stress_level/bindings/stress_level_binding.dart';
import '../modules/stress_level/views/stress_level_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/transaction_invoice/bindings/transaction_invoice_binding.dart';
import '../modules/transaction_invoice/views/transaction_invoice_view.dart';
import '../modules/transaction_method/bindings/transaction_method_binding.dart';
import '../modules/transaction_method/views/transaction_method_view.dart';
import '../modules/transaction_payment/bindings/transaction_payment_binding.dart';
import '../modules/transaction_payment/views/transaction_payment_view.dart';
import '../modules/transaction_success/bindings/transaction_success_binding.dart';
import '../modules/transaction_success/views/transaction_success_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

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
      page: () => ArticleView(),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ARTIKEL,
      page: () => DetailArtikelView(),
      binding: DetailArtikelBinding(),
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
      name: _Paths.TRACKING,
      page: () => TrackingView(),
      binding: TrackingBinding(),
    ),
    GetPage(
      name: _Paths.TRACKING_2,
      page: () => const Tracking2View(),
      binding: Tracking2Binding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ARTIKEL,
      page: () => DetailArtikelView(),
      binding: DetailArtikelBinding(),
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
    GetPage(
      name: _Paths.TRANSACTION,
      // ini cuman buat tes data aja
      page: () => const TransactionView(
        namaPsikiater: "dummy",
        topik: "dummy",
        metode: "dummy",
        durasi: 100,
        jmlSesi: 1,
        jadwalSesi: "dummy",
        waktuSesi: "dummy",
        kadaluarsa: "dummy",
        harga: 321671,
      ),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_METHOD,
      page: () => const TransactionMethodView(),
      binding: TransactionMethodBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_PAYMENT,
      page: () => const TransactionPaymentView(),
      binding: TransactionPaymentBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_SUCCESS,
      page: () => const TransactionSuccessView(),
      binding: TransactionSuccessBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_INVOICE,
      page: () => const TransactionInvoiceView(),
      binding: TransactionInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_1,
      page: () => Assesment1View(),
      binding: Assesment1Binding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_2,
      page: () => Assesment2View(),
      binding: Assesment2Binding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_3,
      page: () => Assesment3View(),
      binding: Assesment3Binding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_4,
      page: () => Assesment4View(),
      binding: Assesment4Binding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_5,
      page: () => Assesment5View(),
      binding: Assesment5Binding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_6,
      page: () => Assesment6View(),
      binding: Assesment6Binding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT_7,
      page: () => Assesment7View(),
      binding: Assesment7Binding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () =>  ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_CHAT,
      page: () =>  RoomChatView(),
      binding: RoomChatBinding(),
    ),
  ];
}
