// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/i_auth_facade.dart';
import '../../../domain/auth/value_objects.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(
    this._authFacade,
  ) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) async {
      await event.map(emailChanged: (e) {
        emit(state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none(),
        ));
      }, passwordChanged: (e) {
        emit(state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none(),
        ));
      }, registerWithEmailAndPasswordPressed: (e) async {
        Either<AuthFailure, Unit>? failureOrSuccess;
        final isEmailValid = state.emailAddress.isValid();
        final isPasswordValid = state.password.isValid();
        if (isEmailValid && isPasswordValid) {
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ));

          failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
            emailAddress: state.emailAddress,
            password: state.password,
          );

          // emit(state.copyWith(
          //   isSubmitting: false,
          //   authFailureOrSuccessOption: some(failureOrSuccess),
          // ));
        }
        emit(state.copyWith(
          showErrorMessages: true,
          // optionOf is equivalent to:
          // failureOrSuccess == null ? none() : some(failureOrSuccess)
          authFailureOrSuccessOption: optionOf(failureOrSuccess),
        ));
      }, signInWithEmailAndPasswordPressed: (e) async {
        Either<AuthFailure, Unit>? failureOrSuccess;
        final isEmailValid = state.emailAddress.isValid();
        final isPasswordValid = state.password.isValid();
        if (isEmailValid && isPasswordValid) {
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ));

          failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
            emailAddress: state.emailAddress,
            password: state.password,
          );

          // emit(state.copyWith(
          //   isSubmitting: false,
          //   authFailureOrSuccessOption: some(failureOrSuccess),
          // ));
        }
        emit(state.copyWith(
          showErrorMessages: true,
          // optionOf is equivalent to:
          // failureOrSuccess == null ? none() : some(failureOrSuccess)
          authFailureOrSuccessOption: optionOf(failureOrSuccess),
        ));
      }, signInWithGooglePressed: (e) async {
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ));
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess)));
      });
    });
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Emitter<SignInFormState> emit,
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    }) forwardedCall,
  ) async* {
    Either<AuthFailure, Unit>? failureOrSuccess;
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ));

      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );

      // emit(state.copyWith(
      //   isSubmitting: false,
      //   authFailureOrSuccessOption: some(failureOrSuccess),
      // ));
    }
    emit(state.copyWith(
      showErrorMessages: true,
      // optionOf is equivalent to:
      // failureOrSuccess == null ? none() : some(failureOrSuccess)
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
