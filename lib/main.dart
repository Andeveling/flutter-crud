//  Pages
import './pages/home_page.dart';
import './pages/login_register_page.dart';
import './pages/new_contact.dart';
import './pages/update_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => _buildProtectedRoute(context, MyHomePage()),
        '/add': (context) =>
            _buildProtectedRoute(context, const NewContactPage()),
        '/update': (context) =>
            _buildProtectedRoute(context, const UpdateUserPage()),
      },
    );
  }

  Widget _buildProtectedRoute(BuildContext context, Widget child) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra una pantalla de carga mientras se verifica el estado de autenticación
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          // Si el usuario está autenticado, devuelve el widget hijo protegido
          return child;
        } else {
          // Si el usuario no está autenticado, redirige a la pantalla de inicio de sesión
          return const LoginPage();
        }
      },
    );
  }
}

/* 
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/add': (context) => const AddUserPage(),
        '/update': (context) => const UpdateUserPage()
      },
    );
  }
 */