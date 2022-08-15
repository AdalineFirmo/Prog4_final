import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final receivedData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    debugPrint(receivedData.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(receivedData['title']),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.network(
              receivedData['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Text(receivedData['date']),
          Text(receivedData['description']),
          Text(receivedData['copyright']),
        ]),
      ),
    );
  }
}
