import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/presentation/home/home_screen.dart';

import '../../presentation/auth/forgot_password/forgot_password_screen.dart';
import '../../presentation/auth/sign_in/sign_in_screen.dart';
import '../../presentation/auth/sign_up/sign_up_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../constants/route_constants.dart';
import '../providers/firebase_providers.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
Future<void> splashDelay(Ref ref) async {
  await Future.delayed(const Duration(seconds: 3));
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);
  final splashDelayState = ref.watch(splashDelayProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteConstants.splashPath,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final hasError = authState.hasError;
      final isLoggedIn = authState.value != null;

      final isSplash = state.uri.toString() == RouteConstants.splashPath;

      final isAuthRoute =
          state.uri.toString() == RouteConstants.loginPath ||
          state.uri.toString() == RouteConstants.registerPath ||
          state.uri.toString() == RouteConstants.forgotPasswordPath;

      if (isLoading || hasError) {
        return null;
      }

      if (isSplash && splashDelayState.isLoading) {
        return null;
      }

      if (!isLoggedIn) {
        if (isSplash) {
          return RouteConstants.loginPath;
        }

        if (isAuthRoute) {
          return null;
        }

        return RouteConstants.loginPath;
      }

      if (isLoggedIn) {
        if (isSplash || isAuthRoute) {
          return RouteConstants.homePath;
        }
      }

      return null;
    },

    routes: [
      GoRoute(
        path: RouteConstants.splashPath,
        name: RouteConstants.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: RouteConstants.loginPath,
        name: RouteConstants.login,
        builder: (context, state) => const SignInScreen(),
      ),

      GoRoute(
        path: RouteConstants.registerPath,
        name: RouteConstants.register,
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: RouteConstants.forgotPasswordPath,
        name: RouteConstants.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: RouteConstants.homePath,
        name: RouteConstants.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
