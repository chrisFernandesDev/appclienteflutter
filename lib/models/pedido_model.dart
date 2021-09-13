class PedidoModel {
  // final String key;
  final String clienteKey;
  final String clienteNome;
  final List<dynamic> pedido;


  PedidoModel({
    // required this.key,
    required this.clienteKey,
    required this.pedido,
    required this.clienteNome
  });

  static PedidoModel fromMap(Map<String, dynamic> map) =>
      PedidoModel(
        // key: map['key'],
        clienteKey: map['clienteKey'],
        pedido: map['pedido'],
        clienteNome: map['clienteNome'],
      );

       Map<String, dynamic> toMap() => {
        // 'key': key,
        'clienteKey': clienteKey,
        'pedido': pedido,
        'clienteNome': clienteNome,
      };
}