import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'success_failed_dialog_state.dart';

part 'success_failed_dialog_cubit.freezed.dart';

class SuccessFailedDialogCubit extends Cubit<SuccessFailedDialogState> {
  SuccessFailedDialogCubit()
      : super(const SuccessFailedDialogState(isButtonDisabled: false));

  void toggleVisible() {
    final bool isButtonDisabled = true;
    emit(
      SuccessFailedDialogState(isButtonDisabled: isButtonDisabled),
    );
  }
}
