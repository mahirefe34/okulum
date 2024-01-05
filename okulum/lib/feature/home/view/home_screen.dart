import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enums.dart';
import '../../../core/logic/cubit/internet_cubit.dart';
import '../../../core/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = context.read<AuthService>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<InternetCubit, InternetState>(
            builder: (internetCubitBuilderContext, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Wifi) {
                return Text(
                  'Wi-Fi',
                  style: Theme.of(internetCubitBuilderContext)
                      .textTheme
                      .headline3
                      ?.copyWith(
                        color: Colors.green,
                      ),
                );
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Mobile',
                  style: Theme.of(internetCubitBuilderContext)
                      .textTheme
                      .headline3
                      ?.copyWith(
                        color: Colors.red,
                      ),
                );
              } else if (state is InternetDisconnected) {
                return Text(
                  'Disconnected',
                  style: Theme.of(internetCubitBuilderContext)
                      .textTheme
                      .headline3
                      ?.copyWith(
                        color: Colors.grey,
                      ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
          const Text('You\'re in the Home Screen'),
          Text(currentUser.uid),
          Text(currentUser.email ?? "1"),
          Text(currentUser.phoneNumber ?? "2"),
          Text((currentUser.emailVerified).toString()),
          Text(currentUser.refreshToken ?? "3"),
          Text(currentUser.displayName ?? "4"),
          Text((currentUser.providerData).toList().toString()),
          Text((currentUser.metadata).toString()),
          Center(
            child: ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                await context
                    .read<AuthService>()
                    .signOutWithContext(context: context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
