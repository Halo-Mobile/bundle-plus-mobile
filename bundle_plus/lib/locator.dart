import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Services
  // locator.registerSingleton<LocalStorageService>(
  //   await LocalStorageService.getInstance(),
  // );
  // locator.registerSingleton<FirebaseService>(FirebaseService());
  // locator.registerSingleton<ApiService>(ApiService());

  // // Viewmodel
  // locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  // locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  // locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  // locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  // locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
}
