import '../models/produto.dart';
import 'database_service.dart';

class ProdutoService {
  final DatabaseService _databaseService = DatabaseService();

  Future<int> cadastrarProduto(Produto produto) async {
    final db = await _databaseService.database;
    final mapa = produto.toMap()..remove('id');
    final id = await db.insert('produtos', mapa);
    print('INSERT → Produto cadastrado: ${produto.nome}');
    return id;
  }

  Future<List<Produto>> buscarProdutos() async {
    final db = await _databaseService.database;
    final resultado = await db.query('produtos');
    print('SELECT → Produtos encontrados:');
    for (final item in resultado) {
      print(item);
    }
    return resultado.map((mapa) => Produto.fromMap(mapa)).toList();
  }

  Future<void> atualizarQuantidade(Produto produto, int novaQuantidade) async {
    final db = await _databaseService.database;
    print('UPDATE → ${produto.nome}');
    print('Quantidade anterior: ${produto.quantidade}');
    print('Nova quantidade: $novaQuantidade');
    await db.update(
      'produtos',
      {'quantidade': novaQuantidade},
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  Future<void> excluirProduto(Produto produto) async {
    final db = await _databaseService.database;
    await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [produto.id],
    );
    print('DELETE → Produto excluído: ${produto.nome}');
  }

  Future<void> mostrarProdutosNoTerminal() async {
    final db = await _databaseService.database;
    final produtos = await db.query('produtos');
    print('===== PRODUTOS NO BANCO =====');
    for (final produto in produtos) {
      print(produto);
    }
  }
}
