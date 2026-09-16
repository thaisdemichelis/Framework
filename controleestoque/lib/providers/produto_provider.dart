import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutoProvider extends ChangeNotifier {
  final ProdutoService _produtoService = ProdutoService();

  List<Produto> _produtos = [];

  List<Produto> get produtos => _produtos;

  Future<void> carregarProdutos() async {
    _produtos = await _produtoService.buscarProdutos();
    notifyListeners();
  }

  Future<void> cadastrarProduto(
    String nome,
    String categoria,
    int quantidade,
    double preco,
  ) async {
    final produto = Produto(
      nome: nome,
      categoria: categoria,
      quantidade: quantidade,
      preco: preco,
    );
    await _produtoService.cadastrarProduto(produto);
    await carregarProdutos();
  }

  Future<void> incrementarQuantidade(Produto produto) async {
    final novaQuantidade = produto.quantidade + 1;
    await _produtoService.atualizarQuantidade(produto, novaQuantidade);
    await carregarProdutos();
  }

  Future<void> decrementarQuantidade(Produto produto) async {
    if (produto.quantidade <= 0) return;
    final novaQuantidade = produto.quantidade - 1;
    await _produtoService.atualizarQuantidade(produto, novaQuantidade);
    await carregarProdutos();
  }

  Future<void> excluirProduto(Produto produto) async {
    await _produtoService.excluirProduto(produto);
    await carregarProdutos();
  }

  Future<void> mostrarNoTerminal() async {
    await _produtoService.mostrarProdutosNoTerminal();
  }
}
