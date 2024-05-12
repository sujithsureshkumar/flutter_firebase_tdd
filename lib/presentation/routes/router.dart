import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/notes/note.dart';
import '../notes/note_form/note_form_page.dart';
import '../notes/notes_overview/notes_overview_page.dart';
import '../sign_in/sign_in_page.dart';
import '../splash/splash_page.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: SplashRoute.page),
        AutoRoute(path: '/sign_in', page: SignInRoute.page),
        AutoRoute(path: '/notes_overview', page: NotesOverviewRoute.page),
        AutoRoute(path: '/notes_form_page', page: NoteFormRoute.page)
      ];
}
