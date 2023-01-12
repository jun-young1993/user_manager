enum LoginStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure
}

class LoginState {
  final LoginStateStatus status;  
  final Exception? error;

  const LoginState._({
    this.status = LoginStateStatus.initial,
         this.error,
  });
  const LoginState.initial() : this._();

  LoginState asloading() {
    return copyWith(
      status : LoginStateStatus.loading
    );
  }

  LoginState asLoadSuccess() {
    return copyWith(
      status: LoginStateStatus.loadSuccess,
    );
  }
    

  LoginState asLoadFailure(Exception e) {
    return copyWith(
      status: LoginStateStatus.loadFailure,
      error: e,
    );
  }

  LoginState asLoadInit(){
    return copyWith(
      status: LoginStateStatus.initial,
    );
  }

 

  LoginState copyWith({
    LoginStateStatus? status,
        Exception? error,
  }) {
    return LoginState._(
        status: status ?? this.status,
                  error: error ?? this.error,
    );
  }
}