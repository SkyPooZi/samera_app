part of 'text_field_cubit.dart';

@freezed
sealed class TextFieldState with _$TextFieldState {
  const factory TextFieldState({
    required bool isInvisible,
  }) = _TextFieldState;
}
