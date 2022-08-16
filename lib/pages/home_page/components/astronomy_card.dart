import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog4_avaliacao3/core/app_routes.dart';

class AstronomyCard extends StatelessWidget {
  final Map currentItem;
  final String imgNotFound = 'https://i.imgur.com/QQ98IZy.jpeg';

  const AstronomyCard({Key? key, required this.currentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: () {
          debugPrint('${currentItem['url']}');
          Navigator.of(context).pushNamed(AppRoutes.detail, arguments: {
            'imageUrl': currentItem['url'],
            'title': currentItem['title'],
            'date': currentItem['date'],
            'description': currentItem['explanation'],
            'copyright': currentItem['copyright'] ?? 'Sem direitos autorais',
          });
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
                  currentItem['url'].contains(".jpg") ||
                          currentItem['url'].contains(".gif")
                      ? currentItem['url']
                      : imgNotFound,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 5,
                  top: 5,
                ),
                width: double.infinity,
                child: Text(
                  DateFormat.yMMMMd('pt_BR')
                      .format(DateTime.parse(currentItem['date']))
                      .toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              const Divider(
                indent: 5,
                endIndent: 305,
                thickness: 2,
                color: Color(0xFF9156F6),
              ),
              Text(
                currentItem['title'],
                style: TextStyle(
                  color: Colors.black.withAlpha(150),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, bottom: 10),
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
  }
}
