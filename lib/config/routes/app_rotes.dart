import 'package:go_router/go_router.dart';
import 'package:inventario/screens/add_maintenace.dart';
import 'package:inventario/screens/add_screen.dart';
import 'package:inventario/screens/asignar_equipo_screen.dart';
import 'package:inventario/screens/details_screen.dart';
import 'package:inventario/screens/home_screen.dart';
import 'package:inventario/screens/inf_screen.dart';
import 'package:inventario/screens/register_screen.dart';

import '../../screens/login_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    //name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/home',
    //name: LoginScreen.name,
    builder: (context, state) => HomeScreen('id'),
  ),
  GoRoute(
    path: '/register',
    //name: LoginScreen.name,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/details',
    //name: LoginScreen.name,
    builder: (context, state) =>  InfoScreen('text'),
  ),
  GoRoute(
    path: '/add',
    //name: LoginScreen.name,
    builder: (context, state) => const AddScreen(),
  ),
  GoRoute(
    path: '/asignar',
    //name: LoginScreen.name,
    builder: (context, state) => AsignarEquipoScreen(),
  ),
  GoRoute(
    path: '/info',
    //name: LoginScreen.name,
    builder: (context, state) => const InfScreen(),
  ),
  GoRoute(
    path: '/maintenace',
    //name: LoginScreen.name,
    builder: (context, state) =>  const AddMaintenace(),
  ),
]);
