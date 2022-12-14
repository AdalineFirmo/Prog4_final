import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prog4_avaliacao3/pages/home_page/components/error_presenter.dart';
import '/core/colors.dart';
import '/pages/home_page/components/astronomy_card.dart';
import '/pages/home_page/components/team_players_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> items = List.generate(20, (item) => item + 1);
  // final _formKey = GlobalKey<FormState>();
  // final _imagesQuantityController = TextEditingController();
  int numberOfImagesToBeLoaded = 5;
  bool isLoading = true;

  Future<List> fetchData() async {
    // 400 'Bad Request: incorrect field passed.'
    // 400 'Bad Request: invalid field combination passed.'
    // 400 str(ex) + "." -> In case of other errors
    // 404 'Sorry, Nothing at this URL.'
    // 500 'Internal Service Error'
    // 500 'Sorry, unexpected error: {}'.format(e) -> In case of other errors

    var uri =
        'https://api.nasa.gov/planetary/apod?thumbs=false&count=$numberOfImagesToBeLoaded&api_key=EfDC81je4ESlMwsiVcwq7uDxmO66DJg98o3sbtue';
    var url = Uri.parse(uri);
    var response = await http.get(url);
    isLoading = false;

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      showDialog(
        context: context,
        builder: (_) => const ErrorPresenter(message: 'Problema com servidor'),
      );
    } else if (response.statusCode == 400) {
      showDialog(
        context: context,
        builder: (_) => const ErrorPresenter(
          message: 'Campo errado informado',
        ),
      );
    }
    throw Exception('Erro ao carregar dados');
  }

  // String? _imagesQuantityValidator(String? input) {
  //   input = input ?? '';

  //   if (input.isEmpty) {
  //     return 'Informe a quantidade de imagens antes de submeter';
  //   }
  //   if (int.tryParse(input) == null) {
  //     return 'Informe um n??mero inteiro';
  //   }
  //   if (int.parse(input) < 1 || int.parse(input) > 20) {
  //     return 'Informe um n??mero entre 1 e 20';
  //   }
  //   return null;
  // }

  // void _submit() {
  //   if (_formKey.currentState?.validate() != true) {
  //     return;
  //   }

  //   String numOfImages = _imagesQuantityController.text;

  //   setState(() {
  //     isLoading = true;
  //     numberOfImagesToBeLoaded = int.parse(numOfImages);
  //   });
  // }

  // @override
  // void dispose() {
  //   _imagesQuantityController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPurple,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const TeamPlayersModal();
              },
            );
          },
          child: Column(
            children: const [
              Icon(Icons.people),
              Text(
                'Equipe',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[kPurple, kAccentColor],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text('Astronomy Picture of the Day'),
        actions: [
          DropdownButton<int>(
            iconSize: 22,
            icon: const Icon(Icons.photo),
            iconEnabledColor: Colors.white,
            dropdownColor: const Color(0xFF2B3351),
            underline: Container(),
            menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
            items: items
                .map((item) => DropdownMenuItem<int>(
                      value: item,
                      child: Text(
                        '$item',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ))
                .toList(),
            value: numberOfImagesToBeLoaded,
            onChanged: ((item) => setState(() {
                  numberOfImagesToBeLoaded = item!;
                  isLoading = true;
                })),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: MediaQuery.of(context).size.width * 0.7,
          //         child: Form(
          //           key: _formKey,
          //           child: TextFormField(
          //             decoration: const InputDecoration(
          //               fillColor: kWhite,
          //               labelText: 'Quantidade de imagens',
          //               labelStyle: TextStyle(color: kWhite),
          //             ),
          //             keyboardType: TextInputType.number,
          //             controller: _imagesQuantityController,
          //             validator: _imagesQuantityValidator,
          //             textInputAction: TextInputAction.next,
          //             style: const TextStyle(color: kWhite),
          //           ),
          //         ),
          //       ),
          //       ElevatedButton(
          //         onPressed: _submit,
          //         style: ElevatedButton.styleFrom(
          //           primary: kPurple,
          //         ),
          //         child: const Text('Salvar'),
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: FutureBuilder<List>(
                future: fetchData(),
                builder: (context, snapshot) {
                  final List data = snapshot.data ?? [];

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () {
                      isLoading = true;
                      setState(() {});
                      return Future.value(null);
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (contex, index) {
                              return AstronomyCard(currentItem: data[index]);
                            },
                          ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isLoading = true;
          setState(() {});
        },
        backgroundColor: kPurple,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
