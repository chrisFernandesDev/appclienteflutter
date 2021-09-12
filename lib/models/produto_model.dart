import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProdutoModel {
  final String? key;
  final String ownerKey;
  final String nome;
  final String marca;
  final double preco;
  final String tamanho;
  final String cor;
  final String categoria;
  final String descricao;
  final Uint8List? imagem;
  // final List<dynamic> produtos;

  ProdutoModel({
    this.key,
    required this.ownerKey,
    required this.nome,
    required this.marca,
    required this.preco,
    required this.tamanho,
    required this.cor,
    required this.categoria,
    required this.descricao,
    this.imagem,
    // required this.produtos,
  });

  static ProdutoModel fromMap(Map<String, dynamic> map, [String? key]) =>
      ProdutoModel(
        key: key,
        ownerKey: map['ownerKey'],
        nome: map['nome'],
        marca: map['marca'],
        preco: map['preco'],
        tamanho: map['tamanho'],
        cor: map['cor'],
        categoria: map['categoria'],
        descricao: map['descricao'],
        imagem: map['imagem']?.bytes,
        // produtos: map['produtos'],
      );

  Map<String, dynamic> toMap() => {
        'ownerKey': ownerKey,
        'nome': nome,
        'marca': marca,
        'preco': preco,
        'tamanho': tamanho,
        'cor': cor,
        'categoria': categoria,
        'descricao': descricao,
        'imagem': imagem != null ? Blob(imagem!) : null,
        // 'produtos': produtos
      };
}