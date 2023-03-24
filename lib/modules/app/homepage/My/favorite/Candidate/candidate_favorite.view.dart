import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/bookmark_model.dart';
import 'package:flutter_application_1/modules/app/homepage/My/favorite/Candidate/candidate_favorite.controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CandidateFavoriteView extends GetView<CandidateFavoriteController> {
  const CandidateFavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark Flutter"),
        actions: [
          Row(
            children: [
              Text(bookmarkBloc.count.toString()),
              IconButton(
                icon: const Icon(Icons.star),
                onPressed: () {
                  controller.navigateToBookmarksPage();
                },
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.itemsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    controller.toggleStar(bookmarkBloc, index);
                  },
                  title: Text(controller.itemsList[index]['title']),
                  subtitle: Text(controller.itemsList[index]['subtitle']),
                  trailing: controller.itemsList[index]['status'] == "false"
                      ? const Icon(Icons.star_border)
                      : const Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
