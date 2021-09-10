import 'package:appclienteflutter/models/produto_model.dart';
import 'package:flutter/material.dart';

final produtoController = ProdutoController();

class ProdutoController extends ChangeNotifier{
  List<Map<String, dynamic>> produto = [];
  late ProdutoModel model;

  void addProduto(Map<String, dynamic> param){
    produto.add(param);
  notifyListeners();
  }
  void removeProduto(Map<String, dynamic> param){
    produto.remove(param);
  notifyListeners();
  }
  void clearProduto(){
    produto.clear();
  notifyListeners();
  }
}


