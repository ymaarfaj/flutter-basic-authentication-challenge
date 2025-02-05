import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/profiles.dart';
import './screens/profile_screen.dart';
import '../screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Profiles>(
          create: (ctx) => Profiles(
            authToken: null,
            mainProfile: null,
            userId: null,
          ),
          update: (ctx, auth, profiles) => Profiles(
            authToken: auth.token,
            userId: auth.userId,
            mainProfile: profiles?.mainProfile,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Profile App',
          theme: ThemeData(
            fontFamily: 'Lato',
            textTheme: const TextTheme(
              headline6: TextStyle(
                color: Colors.white,
              ),
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
              ).copyWith(
                secondary: Colors.indigo,
              ),
            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.pink,
            ).copyWith(
              secondary: const Color.fromRGBO(255, 254, 229, 1),
            ),
          ),
          home: auth.isAuth ? const ProfileScreen() : const AuthScreen(),
        ),
      ),
    );
  }
}
