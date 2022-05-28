import 'package:bundle_plus/services/firebase_service.dart';
import 'package:bundle_plus/viewmodel/admin_home_viewmodel.dart';
import 'package:bundle_plus/viewmodel/registration_verify_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:bundle_plus/viewmodel/reset_password_viewmodel.dart';

GetIt locator = GetIt.instance;

// Add Viewmodel to the singleton
Future<void> setUpLocator() async {
  // Services
  // locator.registerSingleton<LocalStorageService>(
  //   await LocalStorageService.getInstance(),
  // );
  locator.registerSingleton<FirebaseService>(FirebaseService());
  // locator.registerSingleton<ApiService>(ApiService());

  // // Viewmodel
  locator
      .registerFactory<ResetPasswordViewModel>(() => ResetPasswordViewModel());
  locator.registerFactory<AdminHomeViewModel>(() => AdminHomeViewModel());
  locator.registerFactory<RegistrationVerifyViewModel>(
      () => RegistrationVerifyViewModel());

  // locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  // locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  // locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  // locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  // locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
}
