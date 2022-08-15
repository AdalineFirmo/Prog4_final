import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _imagesQuantityController = TextEditingController();
  int numberOfImagesToBeLoaded = 5;

  Future<List> fetchData() async {
    var uri =
        'https://api.nasa.gov/planetary/apod?count=$numberOfImagesToBeLoaded&api_key=EfDC81je4ESlMwsiVcwq7uDxmO66DJg98o3sbtue';
    var url = Uri.parse(uri);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  String? _imagesQuantityValidator(String? input) {
    input = input ?? '';

    if (input.isEmpty) {
      return 'Informe a quantidade de imagens antes de submeter';
    }
    if (int.tryParse(input) == null) {
      return 'Informe um número inteiro';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    String numOfImages = _imagesQuantityController.text;

    setState(() {
      numberOfImagesToBeLoaded = int.parse(numOfImages);
    });
  }

  @override
  void dispose() {
    _imagesQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nasa Photo of the Day'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Quantidade de imagens',
                      ),
                      keyboardType: TextInputType.number,
                      controller: _imagesQuantityController,
                      validator: _imagesQuantityValidator,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _submit, child: const Text('Salvar'))
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        setState(() {});
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (contex, index) {
                          return ListTile(
                            title: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                snapshot.data![index]['url'],
                                fit: BoxFit.fill,
                              ),
                            ),
                            subtitle: Text(
                              '${snapshot.data![index]['title']}\n${snapshot.data![index]['date']}',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
