import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'logout_state.dart';

part 'logout_cubit.freezed.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(const LogoutState.initial());

  void logoutEvent() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('name');
    emit(
      LogoutState.initial(),
    );
  }
}
