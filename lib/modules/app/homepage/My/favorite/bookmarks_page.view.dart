import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/bookmark_model.dart';
import 'package:flutter_application_1/modules/app/homepage/My/favorite/bookmarks_page.controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BookmarksPageView extends GetView<BookmarksPageController> {
  const BookmarksPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: bookmarkBloc.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bookmarkBloc.items[index].title),
                  subtitle: Text(bookmarkBloc.items[index].subTitle),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
