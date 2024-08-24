import 'package:get/get.dart';

import 'package:temanbicara/app/modules/article/bindings/article_binding.dart';
import 'package:temanbicara/app/modules/article/views/article_view.dart';
import 'package:temanbicara/app/modules/chatbot/bindings/chatbot_binding.dart';
import 'package:temanbicara/app/modules/chatbot/views/chatbot_view.dart';
import 'package:temanbicara/app/modules/consult/bindings/consult_binding.dart';
import 'package:temanbicara/app/modules/consult/views/consult_view.dart';
import 'package:temanbicara/app/modules/home/bindings/home_binding.dart';
import 'package:temanbicara/app/modules/home/views/home_view.dart';
import 'package:temanbicara/app/modules/journal/bindings/journal_binding.dart';
import 'package:temanbicara/app/modules/journal/views/journal_view.dart';
import 'package:temanbicara/app/modules/navigation_bar/bindings/navigation_bar_binding.dart';
import 'package:temanbicara/app/modules/navigation_bar/views/navigation_bar_view.dart';
import 'package:temanbicara/app/modules/profile/bindings/profile_binding.dart';
import 'package:temanbicara/app/modules/profile/views/profile_view.dart';

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
  ];
}
