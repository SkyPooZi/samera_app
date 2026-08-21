import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/bloc/logout/logout_cubit.dart';
import '../common/bloc/success_failed_dialog/success_failed_dialog_cubit.dart';
import '../common/bloc/text_field/text_field_cubit.dart';
import '../features/account/presentation/bloc/account/account_event.dart';
import '../features/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/usecases/login.dart';
import '../features/auth/domain/usecases/register.dart';
import '../features/auth/presentation/bloc/login/login_bloc.dart';
import '../features/auth/presentation/bloc/register/register_bloc.dart';
import '../features/auth/presentation/bloc/splash/splash_cubit.dart';
import '../features/navigation/presentation/bloc/navbar_cubit.dart';
import '../features/favorite/presentation/bloc/favorite/favorite_cubit.dart';
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
import '../features/trip_planner/presentation/bloc/trip_planner/trip_planner_bloc.dart';
import '../features/trip_planner/domain/usecases/generate_trip_plan.dart';
import '../features/trip_planner/domain/usecases/save_trip_plan.dart';
import '../features/trip_planner/domain/usecases/delete_trip_plan.dart';
import '../features/trip_planner/data/repositories/trip_planner_repository_impl.dart';
import '../features/trip_planner/data/datasources/local/trip_planner_local_data_source.dart';
import '../features/trip_planner/domain/usecases/get_saved_trip_plans.dart';
import '../features/account/presentation/bloc/account/account_bloc.dart';

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
    BlocProvider<FavoriteCubit>(
      create: (context) {
        return FavoriteCubit();
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
    BlocProvider<TripPlannerBloc>(
      create: (context) {
        final localDataSource = TripPlannerLocalDataSourceImpl();
        final repository = TripPlannerRepositoryImpl(localDataSource: localDataSource);
        return TripPlannerBloc(
          generateTripPlan: GenerateTripPlan(repository),
          saveTripPlanUseCase: SaveTripPlan(repository),
          deleteTripPlanUseCase: DeleteTripPlan(repository),
        );
      },
    ),
    BlocProvider<AccountBloc>(
      create: (context) {
        final localDataSource = TripPlannerLocalDataSourceImpl();
        final repository = TripPlannerRepositoryImpl(localDataSource: localDataSource);
        return AccountBloc(
          getSavedTripPlans: GetSavedTripPlans(repository),
        )..add(LoadSavedTripPlans());
      },
    ),
  ];
}
