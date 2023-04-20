import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain_driven_design/domain/core/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain_driven_design/domain/auth/i_auth_facade.dart';
import 'package:domain_driven_design/domain/auth/value_objects.dart';

import '../../../../domain/auth/auth_failure.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  SignInFormState get initialState => SignInFormState.initial();

  @override
  Stream<SignInFormState> mappEventToState(SignInFormEvent event) async* {
    yield* event.map(
        emailChanged: (e) async* {
          yield state.copyWith(
            emailAddress: EmailAddress(e.emailStr),
            authFailureOrSuccessOption: none(),
          );
        },
        passWord: (e) async* {
          yield state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccessOption: none(),
          );
        },
        registerWithEmailAndPasswordPressed: (e) async* {
          final isEmailValid = state.emailAddress.isValid();
          final isPasswordValid = state.password.isValid();

          if (isEmailValid && isPasswordValid) {
            yield state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            );

            final failureOrSuccess =
                await _authFacade.registerWithEmailAndPassword(
              emailAddress: state.emailAddress,
              password: state.password,
            );
            yield state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(failureOrSuccess),
            );

          }
           yield state.copyWith(
            showErrorMessages: true,
            authFailureOrSuccessOption: none(),
           );
        },
        signInWithEmailAndPasswordPressed: (e) async* {},
        signInWithGooglePressed: (e) async* {
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          );
          final failureOrSuccess = await _authFacade.signInWithGoogle();
          yield state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess),
          );
        });
  }
}
