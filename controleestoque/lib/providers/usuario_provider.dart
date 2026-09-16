import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/usuario_service.dart';

class UsuarioProvider extends ChangeNotifier {
  final UsuarioService _usuarioService = UsuarioService();

  Usuario? _usuarioLogado;
  String? _erroLogin;
  String? _erroCadastro;

  Usuario? get usuarioLogado => _usuarioLogado;
  String? get erroLogin => _erroLogin;
  String? get erroCadastro => _erroCadastro;

  Future<bool> cadastrar(String nome, String email, String senha) async {
    final existe = await _usuarioService.emailExiste(email);
    if (existe) {
      _erroCadastro = 'E-mail já cadastrado.';
      notifyListeners();
      return false;
    }
    final usuario = Usuario(nome: nome, email: email, senha: senha);
    await _usuarioService.cadastrarUsuario(usuario);
    _erroCadastro = null;
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String senha) async {
    final usuario = await _usuarioService.login(email, senha);
    if (usuario == null) {
      _erroLogin = 'E-mail ou senha incorretos.';
      _usuarioLogado = null;
      notifyListeners();
      return false;
    }
    _usuarioLogado = usuario;
    _erroLogin = null;
    notifyListeners();
    return true;
  }

  void sair() {
    _usuarioLogado = null;
    notifyListeners();
  }

  void limparErros() {
    _erroLogin = null;
    _erroCadastro = null;
  }
}
