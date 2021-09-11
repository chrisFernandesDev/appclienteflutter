import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class UserModel {
  final String nome;
  final String email;
  final String cpf;
  final String end;
  final String cep;
  final String tel;
  final String? key;
  final Uint8List? imagem;

  UserModel({
    required this.nome,
    required this.email,
    required this.end,
    required this.cpf,
    required this.cep,
    required this.tel,
    this.key,
    this.imagem
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      email: map['email'],
      cpf: map['cpf'],
      end: map['end'],
      cep: map['cep'],
      tel: map['tel'],
      key: map['key'],
      imagem: map['imagem']?.bytes,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'end': end,
      'cep': cep,
      'tel': tel,
      'key': key,
      'imagem': imagem != null ? Blob(imagem!) : null,

    };
  }
}