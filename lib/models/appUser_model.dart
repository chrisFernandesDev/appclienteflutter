import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class ClienteModel {
  final String? key;
  final String ownerKey;
  final String nome;
  final String cpf;
  final String end;
  final String cep;
  final String tel;
  final String email;
  final Uint8List? imagem;

  ClienteModel({
    this.key,
    required this.ownerKey,
    required this.nome,
    required this.end,
    required this.cpf,
    required this.cep,
    required this.tel,
    required this.email,
    this.imagem,
  });

  static ClienteModel fromMap(Map<String, dynamic> map, [String? key]) =>
      ClienteModel(
        key: key,
        ownerKey: map['ownerKey'],
        nome: map['nome'],
        cpf: map['cpf'],
        end: map['end'],
        cep: map['cep'],
        tel: map['tel'],
        email: map['email'],
        imagem: map['imagem']?.bytes,
      );

  Map<String, dynamic> toMap() => {
        'ownerKey': ownerKey,
        'nome': nome,
        'cpf': cpf,
        'end': end,
        'cep': cep,
        'tel': tel,
        'email': email,
        'imagem': imagem != null ? Blob(imagem!) : null,
      };

  @override
  String toString() {
    return 'DiarioModel(key: $key, ownerKey: $ownerKey, nome: $nome, cpf: $cpf, end: $end, cep: $cep, tel: $tel, email: $email)';
  }
}
