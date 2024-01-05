import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okulum/core/logic/cubit/internet_cubit.dart';

import '../bloc/school_bloc.dart';
import '../model/school_model.dart';

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({Key? key}) : super(key: key);

  static const String routeName = '/schools';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SchoolScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference _schools =
        FirebaseFirestore.instance.collection('schools');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _schools.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Flexible(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot docSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                      color: Colors.amber,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(docSnapshot['imageUrl']),
                        ),
                        title: Text(docSnapshot['name']),
                      ));
                },
              ),
            );
          }
          return const Text('No data');
        },
      ),

      /* BlocBuilder<SchoolBloc, SchoolState>(
        builder: (context, state) {
          if (state is SchoolLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SchoolLoaded) {
            return 

            /* ListView.builder(
              itemCount: state.schools.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amber,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(state.schools[index].imageUrl ?? '$index'),
                    ),
                    title: Text(state.schools[index].name ?? ''),
                    subtitle: Text(state.schools[index].phoneNumber ?? ''),
                  ),
                );
              },
            ); */
          } else {
            return const Text('Hata oluştu');
          } 
        },*/
    );
  }
}
