import 'package:get_it/get_it.dart';
import 'package:shocase/Providers/auth.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<Auth>(Auth());
}