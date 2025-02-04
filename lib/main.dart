import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/PostBloc.dart';
import 'Presention/Screens/PaginatedListView.dart';
import 'Service/ApiService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pagination Demo',
      home: BlocProvider(
        create: (_) => PostBloc(repository: PostRepository()),
        child: PostListPage(),
      ),
    );
  }
}