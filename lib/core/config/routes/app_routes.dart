import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/domain/entities/note.dart';
import '../../../features/presentation/pages/views.dart';
import '../enum/enum.dart';

abstract class AppRouter {
  AppRouter._();

  static final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRouterName.home.path,
    routes: [
      GoRoute(
        name: AppRouterName.home.name,
        path: AppRouterName.home.path,
        pageBuilder: (_, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
        routes: [
          GoRoute(
            name: AppRouterName.note.name,
            path: AppRouterName.note.path,
            pageBuilder: (_, state) {
              return MaterialPage(
                key: state.pageKey,
                child: NotePage(
                  note: state.extra as Note,
                ),
              );
            },
          ),
          GoRoute(
            name: AppRouterName.setting.name,
            path: AppRouterName.setting.path,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const SettingPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: AppRouterName.trash.name,
        path: AppRouterName.trash.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const TrashPage(),
          );
        },
      ),
      GoRoute(
        name: AppRouterName.archive.name,
        path: AppRouterName.archive.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ArchivePage(),
          );
        },
      )
    ],
  );

  static GoRouter get router => _router;
}
