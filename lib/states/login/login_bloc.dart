import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/data/repositories/login_repository.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/states/login/login_event.dart';
import 'package:user_manager/states/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginState.initial()) {
    on<LoginStarted>(_onLoadStarted);
    on<LogoutStarted>(_onLogoutStarted);
  }

  void _onLogoutStarted(
    LogoutStarted event, Emitter<LoginState> emit
  ) async {
    try{
      emit(state.asLoadInit());
      
      AppNavigator.pop();
      AppNavigator.push(Routes.login);
      
    } on Exception catch (e) {

    }
      
  }

  void _onLoadStarted(
    LoginStarted event, Emitter<LoginState> emit
  ) async {
    try{
      emit(state.asloading());
      _loginRepository.login();
      emit(state.asLoadSuccess());
      
      AppNavigator.pop();
      AppNavigator.push(Routes.home);
      
    } on Exception catch (e) {
      if(e.toString() == 'CANCEL'){
        emit(state.asLoadInit());
      }else{
        emit(state.asLoadFailure(e));
      }
      
    }
    
  }
}