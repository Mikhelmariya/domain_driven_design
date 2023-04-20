
import 'package:flutter/foundation.dart';

abstract class IAuthFacade(){

Future<void> regidterWithEmailAndPassword({
  required EmailAddress emailAddress,
  required Password password,
});

Future<void> signInWithEmailAndPassword({
  required EmailAddress emailAddress,
  required Password password,
});

//Future<void> signInWithGoogle();
}