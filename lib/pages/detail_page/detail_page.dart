import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/core/colors.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final receivedData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    debugPrint(receivedData.toString());

    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Text(
              DateFormat('dd MMMM yyyy')
                  .format(DateTime.parse(receivedData['date']))
                  .toString(),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        elevation: 0,
        backgroundColor: kDarkPurple,
        title: const Text('Voltar'),
      ),
      body: Center(
        child: Column(children: [
          Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                receivedData['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                ),
                color: kBlack.withAlpha(150),
              ),
              child: Text('${receivedData['copyright']}',
                  style: const TextStyle(
                      color: kWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
          Container(
            padding: const EdgeInsets.only(top: 3),
            width: double.infinity,
            height: 25,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kDarkPurple,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
              color: kWhite,
            ),
            child: Text(
              receivedData['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kBlack.withAlpha(175),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //Text(receivedData['date']),
          Expanded(
            child: Container(
              color: kDarkPurple.withAlpha(200),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Text(
                  receivedData['description'],
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18, color: kWhite),
                ),
              ),
            ),
          ),
          //Text(receivedData['copyright']),
        ]),
      ),
    );
  }
}
