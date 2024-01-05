import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:okulum/feature/schools/bloc/school_bloc.dart';
import 'package:okulum/feature/schools/repository/school_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'bloc_observer.dart';
import 'core/constants/app_router.dart';
import 'core/logic/cubit/counter_cubit.dart';
import 'core/logic/cubit/internet_cubit.dart';
import 'core/logic/cubit/settings_cubit.dart';
import 'core/services/auth_service.dart';
import 'firebase_options.dart';
import 'product/widgets/auth_widget.dart';
import 'product/widgets/auth_widget_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    )),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().onAuthStateChanges,
          initialData: null,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (internetCubitContext) =>
                InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<CounterCubit>(
            create: (counterCubitContext) => CounterCubit(),
          ),
          BlocProvider<SettingsCubit>(
            create: (counterCubitContext) => SettingsCubit(),
          ),
          BlocProvider<SchoolBloc>(
            create: (schoolContext) => SchoolBloc(
              schoolRepository: SchoolRepository(),
            )..add(LoadSchool()),
          )
        ],
        child: AuthWidgetBuilder(
          onPageBuilder: (context, AsyncSnapshot<User?> snapShot) =>
              MaterialApp(
            title: 'Flutter Auth Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AuthWidget(snapShot: snapShot),
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
