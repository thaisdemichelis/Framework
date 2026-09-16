import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/produto.dart';
import '../providers/produto_provider.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<ProdutoProvider>();
      provider.carregarProdutos();
      provider.mostrarNoTerminal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final produtos = context.watch<ProdutoProvider>().produtos;
    return Scaffold(
      appBar: AppBar(title: const Text('Estoque')),
      body: produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: produtos.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return _ProdutoTile(produto: produto);
              },
            ),
    );
  }
}

class _ProdutoTile extends StatelessWidget {
  final Produto produto;

  const _ProdutoTile({required this.produto});

  @override
  Widget build(BuildContext context) {
    final estoqueBaixo = produto.quantidade <= 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          produto.nome,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(produto.categoria),
        Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
        if (estoqueBaixo)
          const Text(
            'ESTOQUE BAIXO',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<ProdutoProvider>().decrementarQuantidade(produto);
              },
              icon: const Icon(Icons.remove),
            ),
            Text('Quantidade: ${produto.quantidade}'),
            IconButton(
              onPressed: () {
                context.read<ProdutoProvider>().incrementarQuantidade(produto);
              },
              icon: const Icon(Icons.add),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.read<ProdutoProvider>().excluirProduto(produto);
              },
              child: const Text('EXCLUIR'),
            ),
          ],
        ),
      ],
    );
  }
}
