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
    if (int.parse(input) < 1 || int.parse(input) > 20) {
      return 'Informe um número entre 1 e 20';
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
      backgroundColor: const Color(0xFF2B3351),
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () {},
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF7162FC), Color(0xFFB245F2)]),
          ),
        ),
        centerTitle: true,
        title: const Text('Astronomy Picture of the Day'),
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
                        fillColor: Colors.white,
                        labelText: 'Quantidade de imagens',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _imagesQuantityController,
                      validator: _imagesQuantityValidator,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Salvar'),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF7162FC)),
                )
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
                            title: InkWell(
                              onTap: () {
                                debugPrint('${snapshot.data![index]['url']}');
                              },
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: Image.network(
                                        snapshot.data![index]['url'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      width: double.infinity,
                                      child: Text(
                                        snapshot.data![index]['date'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withAlpha(150)),
                                      ),
                                    ),
                                    const Divider(
                                      indent: 5,
                                      endIndent: 305,
                                      thickness: 2,
                                      color: Color(0xFF9156F6),
                                    ),
                                    Text(
                                      snapshot.data![index]['title'],
                                      style: TextStyle(
                                          color: Colors.black.withAlpha(150)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      alignment: Alignment.centerRight,
                                      height: 30,
                                      width: double.infinity,
                                      child: const Icon(
                                        Icons.touch_app,
                                        color: Color(0xFF756EA2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
