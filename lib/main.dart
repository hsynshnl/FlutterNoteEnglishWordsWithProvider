import 'package:flutter/material.dart';
import 'package:learn_english/view/add_page/add_view.dart';
import 'package:provider/provider.dart';

import 'core/providers/words_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WordsProvider(),
      child: Builder(builder: (BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Note English Words',
          home: AddPage(),
        );
      }),
    );
  }
}
