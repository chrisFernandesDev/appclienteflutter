import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class VendedorModel {
  final String? key;
  final String nome;
  final Uint8List? imagem;

  VendedorModel({
    this.key,
    required this.nome,
    this.imagem
  });

  static VendedorModel fromMap(Map<String, dynamic> map, [String? key]) =>
  VendedorModel(
    key: key,
    nome: map['nome'],
    imagem: map['imagem']?.bytes,
    );

    Map<String, dynamic> toMap() => {
      'key': key,
      'nome': nome,
      'imagem': imagem != null ? Blob(imagem!) : null,
    };

    
}