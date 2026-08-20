import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/bloc/logout/logout_cubit.dart';
import '../common/bloc/success_failed_dialog/success_failed_dialog_cubit.dart';
import '../common/bloc/text_field/text_field_cubit.dart';
import '../features/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/usecases/login.dart';
import '../features/auth/domain/usecases/register.dart';
import '../features/auth/presentation/bloc/login/login_bloc.dart';
import '../features/auth/presentation/bloc/register/register_bloc.dart';
import '../features/auth/presentation/bloc/splash/splash_cubit.dart';
import '../features/navigation/presentation/bloc/navbar_cubit.dart';
import '../features/home/data/datasources/local/home_local_data_source.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/usecases/get_recommendations.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/home/presentation/bloc/home_event.dart';
import '../features/explore/data/datasources/local/explore_local_data_source.dart';
import '../features/explore/data/repositories/explore_repository_impl.dart';
import '../features/explore/domain/usecases/get_regions.dart';
import '../features/explore/domain/usecases/get_destinations_by_region.dart';
import '../features/explore/presentation/bloc/explore/explore_bloc.dart';
import '../features/explore/presentation/bloc/explore/explore_event.dart';
import '../features/explore/domain/usecases/get_destinations_by_category.dart';
import '../features/explore/presentation/bloc/category_destination/category_destination_bloc.dart';

class AppProviders {
  final providers = [
    BlocProvider<SplashCubit>(
      create: (context) {
        return SplashCubit();
      },
    ),
    BlocProvider<TextFieldCubit>(
      create: (context) {
        return TextFieldCubit();
      },
    ),
    BlocProvider<LogoutCubit>(
      create: (context) {
        return LogoutCubit();
      },
    ),
    BlocProvider<SuccessFailedDialogCubit>(
      create: (context) {
        return SuccessFailedDialogCubit();
      },
    ),
    BlocProvider<NavbarCubit>(
      create: (context) {
        return NavbarCubit();
      },
    ),
    BlocProvider<LoginBloc>(
      create: (context) {
        final authRepository = AuthRepositoryImpl(
          authRemoteDataSource: AuthRemoteDataSourceImpl(),
        );
        return LoginBloc(
          login: Login(
            authRepository: authRepository,
          ),
        );
      },
    ),
    BlocProvider<RegisterBloc>(
      create: (context) {
        final authRepository = AuthRepositoryImpl(
          authRemoteDataSource: AuthRemoteDataSourceImpl(),
        );
        return RegisterBloc(
          register: Register(
            authRepository: authRepository,
          ),
        );
      },
    ),
    BlocProvider<HomeBloc>(
      create: (context) {
        final repository = HomeRepositoryImpl(
          localDataSource: HomeLocalDataSourceImpl(),
        );
        return HomeBloc(
          getRecommendations: GetRecommendations(repository),
        )..add(LoadRecommendations());
      },
    ),
    BlocProvider<ExploreBloc>(
      create: (context) {
        final repository = ExploreRepositoryImpl(
          localDataSource: ExploreLocalDataSourceImpl(),
        );
        return ExploreBloc(
          getRegions: GetRegions(repository),
          getDestinationsByRegion: GetDestinationsByRegion(repository),
        )..add(LoadRegions());
      },
    ),
    BlocProvider<CategoryDestinationBloc>(
      create: (context) {
        final repository = ExploreRepositoryImpl(
          localDataSource: ExploreLocalDataSourceImpl(),
        );
        return CategoryDestinationBloc(
          getDestinationsByCategory: GetDestinationsByCategory(repository),
        );
      },
    ),
  ];
}
