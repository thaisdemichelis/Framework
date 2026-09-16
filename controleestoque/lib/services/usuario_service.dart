import '../models/usuario.dart';
import 'database_service.dart';

class UsuarioService {
  final DatabaseService _databaseService = DatabaseService();

  Future<bool> emailExiste(String email) async {
    final db = await _databaseService.database;
    final resultado = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    return resultado.isNotEmpty;
  }

  Future<int> cadastrarUsuario(Usuario usuario) async {
    final db = await _databaseService.database;
    final mapa = usuario.toMap()..remove('id');
    final id = await db.insert('usuarios', mapa);
    print('INSERT → Usuário cadastrado: ${usuario.nome}');
    return id;
  }

  Future<Usuario?> login(String email, String senha) async {
    final db = await _databaseService.database;
    print('SELECT → Procurando usuário: $email');
    final resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    if (resultado.isNotEmpty) {
      final usuario = Usuario.fromMap(resultado.first);
      print('SELECT → Usuário encontrado: ${usuario.nome}');
      return usuario;
    }
    print('SELECT → Usuário não encontrado');
    return null;
  }
}
