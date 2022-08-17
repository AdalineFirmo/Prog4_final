import 'package:flutter/material.dart';
import 'package:prog4_avaliacao3/core/colors.dart';

class ErrorPresenter extends StatelessWidget {
  final String message;

  const ErrorPresenter({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Houve um erro'),
      content: Text(message),
      actions: [
        TextButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}
