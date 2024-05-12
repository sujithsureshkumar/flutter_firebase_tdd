import 'package:dartz/dartz.dart';
import 'package:flutter_firebase_ddd/domain/auth/value_objects.dart';

import 'auth_failure.dart';
import 'user.dart';

abstract class IAuthFacade {
  Option<User> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<void> signOut();
}
