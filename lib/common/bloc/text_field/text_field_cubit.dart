import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_state.dart';

part 'text_field_cubit.freezed.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(const TextFieldState(isInvisible: true));

  void toggleVisible() {
    emit(TextFieldState(isInvisible: !state.isInvisible));
  }
}
