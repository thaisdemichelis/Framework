import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';
import 'providers/produto_provider.dart';
import 'providers/usuario_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsuarioProvider()),
        ChangeNotifierProvider(create: (context) => ProdutoProvider()),
      ],
      child: MaterialApp(
        title: 'Controle de Estoque',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
