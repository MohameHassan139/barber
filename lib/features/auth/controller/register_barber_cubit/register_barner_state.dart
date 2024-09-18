abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationImagePicked extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final String error;
  RegistrationError(this.error);
}

class PasswordHiddenState extends RegistrationState {
  final bool isPasswordHidden;
  PasswordHiddenState({this.isPasswordHidden = true});
}

class PasswordMatchState extends RegistrationState {
  final bool passwordsMatch;

  PasswordMatchState({
    this.passwordsMatch = true,
  });
}
