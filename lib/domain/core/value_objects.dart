import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:domain_driven_design/domain/auth/value_objects.dart';
import 'package:domain_driven_design/domain/core/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


@immutable
abstract class ValueObject<T> {
  const ValueObject();
   Either<ValueFailure<T>, T>get  value;

 

  @override
  String toString() => 'Value($value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}