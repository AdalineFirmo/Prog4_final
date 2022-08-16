import 'package:flutter/material.dart';
import 'package:prog4_avaliacao3/core/colors.dart';

class TeamPlayersModal extends StatelessWidget {
  const TeamPlayersModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: kWhite,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text(
              'Integrantes da equipe:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Adaline Nogueira Fernandes Firmo'),
                Divider(),
                Text('Matheus da Costa da Silva'),
                Divider(),
                Text('Thiago Vinicios Lima de Araujo Sousa'),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(primary: kPurple),
              child: const SizedBox(
                width: 150,
                child: Text(
                  'Fechar',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
