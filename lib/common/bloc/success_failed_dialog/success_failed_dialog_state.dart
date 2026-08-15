part of 'success_failed_dialog_cubit.dart';

@freezed
sealed class SuccessFailedDialogState with _$SuccessFailedDialogState {
  const factory SuccessFailedDialogState({
    required bool isButtonDisabled,
  }) = _SuccessFailedDialogState;
}
