// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:flutter_firebase_ddd/application/auth/auth/auth_bloc.dart'
    as _i14;
import 'package:flutter_firebase_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart'
    as _i13;
import 'package:flutter_firebase_ddd/application/notes/note_actor/note_actor_bloc.dart'
    as _i10;
import 'package:flutter_firebase_ddd/application/notes/note_form/note_form_bloc.dart'
    as _i11;
import 'package:flutter_firebase_ddd/application/notes/note_watcher/note_watcher_bloc.dart'
    as _i12;
import 'package:flutter_firebase_ddd/domain/auth/i_auth_facade.dart' as _i6;
import 'package:flutter_firebase_ddd/domain/notes/i_note_repository.dart'
    as _i8;
import 'package:flutter_firebase_ddd/infrastructure/auth/firebase_auth_facade.dart'
    as _i7;
import 'package:flutter_firebase_ddd/infrastructure/core/firebase_injectable_module.dart'
    as _i15;
import 'package:flutter_firebase_ddd/infrastructure/notes/note_repository.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i5.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i6.IAuthFacade>(() => _i7.FirebaseAuthFacade(
        gh<_i3.FirebaseAuth>(),
        gh<_i5.GoogleSignIn>(),
      ));
  gh.lazySingleton<_i8.INoteRepository>(
      () => _i9.NoteRepository(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i10.NoteActorBloc>(
      () => _i10.NoteActorBloc(gh<_i8.INoteRepository>()));
  gh.factory<_i11.NoteFormBloc>(
      () => _i11.NoteFormBloc(gh<_i8.INoteRepository>()));
  gh.factory<_i12.NoteWatcherBloc>(
      () => _i12.NoteWatcherBloc(gh<_i8.INoteRepository>()));
  gh.factory<_i13.SignInFormBloc>(
      () => _i13.SignInFormBloc(gh<_i6.IAuthFacade>()));
  gh.factory<_i14.AuthBloc>(() => _i14.AuthBloc(gh<_i6.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjectableModule extends _i15.FirebaseInjectableModule {}
