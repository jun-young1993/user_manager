import 'package:user_manager/domain/entities/user.dart';

enum UserStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}
class UserState {
    final UserStateStatus status;
    final List<User> users;
    final int selectedUserIndex;
    final int page;
    final Exception? error;
    final bool canLoadMore;

    User get selectedUser => users[selectedUserIndex];

    const UserState._({
      this.status = UserStateStatus.initial,   
      this.users = const [],
      this.selectedUserIndex = 0,
      this.page = 1,
      this.canLoadMore = true,
      this.error,
    });

    const UserState.initial() : this._();
    

    UserState asloading() {
      return copyWith(
        status : UserStateStatus.loading
      );
    }

    UserState asLoadSuccess(List<User> users, {bool canLoadMore = true}) {
      return copyWith(
        status: UserStateStatus.loadSuccess,
        users: users,
        page: 1,
        canLoadMore: canLoadMore,
      );
    }

    UserState asLoadFailure(Exception e) {
        return copyWith(
          status: UserStateStatus.loadFailure,
          error: e,
        );
    }

    UserState asLoadMoreSuccess(List<User> newPokemons, {bool canLoadMore = true}) {
      return copyWith(
        status: UserStateStatus.loadMoreSuccess,
        users: [...users, ...newPokemons],
        page: canLoadMore ? page + 1 : page,
        canLoadMore: canLoadMore,
      );
    }

    UserState asLoadMoreFailure(Exception e) {
      return copyWith(
        status: UserStateStatus.loadMoreFailure,
        error: e,
      );
    }

    UserState copyWith({
      UserStateStatus? status,
      List<User>? users,
      int? selectedUserIndex,
      int? page,
      bool? canLoadMore,
      Exception? error,
    }) {
      return UserState._(
          status: status ?? this.status,
          users: users ?? this.users,
          selectedUserIndex: selectedUserIndex ?? this.selectedUserIndex,
          page: page ?? this.page,
          canLoadMore: canLoadMore ?? this.canLoadMore,
          error: error ?? this.error,
      );
    }
}