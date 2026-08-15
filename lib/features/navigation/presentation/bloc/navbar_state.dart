part of 'navbar_cubit.dart';

@freezed
sealed class NavbarState with _$NavbarState {
  const factory NavbarState({
    required int tabIndex,
  }) = _NavbarState;
}
