import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/produto_provider.dart';

class CadastroProdutoPage extends StatefulWidget {
  const CadastroProdutoPage({super.key});

  @override
  State<CadastroProdutoPage> createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  final _nomeController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _precoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _categoriaController.dispose();
    _quantidadeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    final nome = _nomeController.text.trim();
    final categoria = _categoriaController.text.trim();
    final quantidade = int.tryParse(_quantidadeController.text.trim()) ?? 0;
    final preco = double.tryParse(
          _precoController.text.trim().replaceAll(',', '.'),
        ) ??
        0.0;

    await context.read<ProdutoProvider>().cadastrarProduto(
          nome,
          categoria,
          quantidade,
          preco,
        );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _categoriaController,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _quantidadeController,
                  decoration: const InputDecoration(labelText: 'Quantidade'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _precoController,
                  decoration: const InputDecoration(labelText: 'Preço'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _cadastrar,
                    child: const Text('CADASTRAR PRODUTO'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
