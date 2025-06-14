import 'package:flutter_test/flutter_test.dart';
import 'package:temanbicara/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/utils/localstorage.dart';

class FakeStorage implements LocalStorage {
  final Map<String, dynamic> _store = {};

  @override
  bool has(String key) => _store.containsKey(key);

  @override
  read(String key) => _store[key];

  @override
  void write(String key, value) => _store[key] = value;
}

void main() {
  group('SplashScreenController', () {
    late FakeStorage fakeStorage;
    late String? routedTo;

    setUp(() {
      fakeStorage = FakeStorage();
      routedTo = null;
    });

    test('navigates to onboarding if first time', () async {
      final controller = SplashScreenController(
        storage: fakeStorage,
        delay: Duration.zero,
        navigate: (route, {arguments}) => routedTo = route,
      );

      controller.onReady();
      await Future.delayed(Duration.zero);

      expect(routedTo, Routes.ON_BOARDING);
    });

    test('navigates to login if token null', () async {
      fakeStorage.write('firstTime', false);

      final controller = SplashScreenController(
        storage: fakeStorage,
        delay: Duration.zero,
        navigate: (route, {arguments}) => routedTo = route,
      );

      controller.onReady();
      await Future.delayed(Duration.zero);

      expect(routedTo, Routes.LOGIN);
    });
  });
}
