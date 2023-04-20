import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:domain_driven_design/domain/core/failures.dart';
import 'package:domain_driven_design/domain/core/value_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain_driven_design/domain/core/value_objects.dart';


class EmailAddress extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);

}

class Password extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);

}
















































// void showingTheEmailAddressOrFailure() {
//   final emailAddress = EmailAddress("");
//   String emailText = emailAddress.value.getOrElse(() => "Invalid Email");
// }
