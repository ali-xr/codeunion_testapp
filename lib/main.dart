import 'dart:async';
import 'dart:io';

import 'package:codeunion_testapp/core/data/singletons/service_locator.dart';
import 'package:codeunion_testapp/core/data/singletons/storage.dart';
import 'package:codeunion_testapp/core/data/singletons/store_keys.dart';
import 'package:codeunion_testapp/features/auth/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:codeunion_testapp/features/auth/presentation/bloc/login_sign_up_bloc/login_sign_up_bloc.dart';
import 'package:codeunion_testapp/features/auth/presentation/pages/login.dart';
import 'package:codeunion_testapp/features/auth/presentation/pages/splash.dart';
import 'package:codeunion_testapp/features/auth/presentation/widgets/fade.dart';
import 'package:codeunion_testapp/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupLocator();
  // FlutterError.onError =
  //     fire.FirebaseCrashlytics.instance.recordFlutterFatalError;
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(create: (context) => ShowPopUpBloc()),
        BlocProvider(create: (_) => LoginSignUpBloc()),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (!StorageRepository.getBool(StoreKeys.onBoarding,
                  defValue: false)) {
                navigator.pushAndRemoveUntil(
                    fade(page: const LoginScreen()), (route) => false);
              } else {
                navigator.pushAndRemoveUntil(
                    fade(
                        page: Container(
                      color: Colors.blue,
                    )),
                    (route) => false);
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        ),
      ),
    );
  }
}
