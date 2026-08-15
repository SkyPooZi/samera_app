part of 'splash_cubit.dart';

@freezed
sealed class SplashState with _$SplashState {
  const factory SplashState({
    required bool isLogin,
    required double opacity,
  }) = _SplashState;
}
