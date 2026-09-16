import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/usuario_provider.dart';
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    final provider = context.read<UsuarioProvider>();
    final sucesso = await provider.login(
      _emailController.text.trim(),
      _senhaController.text.trim(),
    );
    if (sucesso && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final erro = context.watch<UsuarioProvider>().erroLogin;
    return Scaffold(
      appBar: AppBar(title: const Text('Área Restrita')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                if (erro != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      erro,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _entrar,
                    child: const Text('ENTRAR'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.read<UsuarioProvider>().limparErros();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastroPage(),
                      ),
                    );
                  },
                  child: const Text('Ainda não possui conta? CRIAR CONTA'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
