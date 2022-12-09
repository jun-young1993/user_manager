import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/states/user/user_event.dart';
import 'package:user_manager/states/user/user_state.dart';
import 'package:user_manager/data/repositories/user_repository.dart';

import 'dart:developer';

class UserBloc extends Bloc<UserEvent,UserState> {
    static const int userPerPage = 20;
    final UserRepository _userRepository;
    UserBloc(this._userRepository) : super(UserState.initial()) {
      on<UserLoadStarted>(
        _onLoadStarted, 
        transformer : (events, mapper) => events.switchMap(mapper)
      );
      on<UserSelectChanged>(_onSelectChanged);
      on<UserCreated>(_onCreated);
    }

    void _onLoadStarted(UserLoadStarted event, Emitter<UserState> emit) async {
      try{
        emit(state.asloading());

        final users = await _userRepository.get();

        emit(state.asLoadSuccess(users, canLoadMore: false));

      }on Exception catch (e){
        emit(state.asLoadFailure(e));
      }
    }

    void _onSelectChanged(UserSelectChanged event, Emitter<UserState> emit) async {
      try {
        final userIndex = state.users.indexWhere(
          (users) => users.id == event.id,
        );

        if (userIndex < 0 || userIndex >= state.users.length) return;
        
        final user = await _userRepository.find(event.id);
        
        
        if (user == null) return;

        emit(state.copyWith(
          users: state.users,
          selectedUserIndex: userIndex,
        ));
      } on Exception catch (e) {
        emit(state.asLoadMoreFailure(e));
      }
    }

    void _onCreated(UserCreated event, Emitter<UserState> emit) async {
      try{

        final UserProperty userProperty = event.user;
        final user = await _userRepository.create(userProperty);
        
        
        state.users.insert(0,user);
        emit(state.copyWith(users: state.users));
        
      } on Exception catch (e) {
          
      }
    }



}