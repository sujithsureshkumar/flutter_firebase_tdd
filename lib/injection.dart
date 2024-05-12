import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(asExtension: false)
FutureOr<GetIt> configureInjection() {
  return init(getIt, environment: Environment.prod);
}
