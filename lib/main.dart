import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/cubit/social/social_cubit.dart';
import 'package:social_application/layouts/social_layout.dart';
import 'package:social_application/local/cache_helper.dart';
import 'package:social_application/screens/social_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.ini();

  uId = CacheHelper.getData(key: 'uId');

  Widget screen;
  if (uId == null) {
    screen = SocialLoginScreen();
  } else {
    screen = const SocialLayout();
  }

  runApp(MyApp(screen: screen));
}

class MyApp extends StatelessWidget {
  Widget screen;
  MyApp({required this.screen, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserDate())
      ],
      child: MaterialApp(
        title: 'SocialApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.grey),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: screen,
      ),
    );
  }
}
