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
import '../modules/navigation_bar/bindings/navigation_bar_binding.dart';
import '../modules/navigation_bar/views/navigation_bar_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
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

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
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
      name: _Paths.CHATBOT,
      page: () => ChatbotView(),
      binding: ChatbotBinding(),
    ),
    GetPage(
      name: _Paths.CONSULT,
      page: () => ConsultView(),
      binding: ConsultBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.JOURNAL,
      page: () => JournalView(),
      binding: JournalBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_JOURNAL,
      page: () => CreateJournalView(),
      binding: CreateJournalBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOT_ROOM,
      page: () => ChatbotRoomView(),
      binding: ChatbotRoomBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
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
  ];
}
