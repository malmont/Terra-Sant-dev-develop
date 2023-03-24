import 'package:flutter_application_1/models/items_model.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class CandidateFavoriteController extends GetxController {
  final String title = "123";
  //var bookmarkBloc = Provider.of<BookmarkBloc>;

  toggleStar(bookmarkBloc, index) {
    if (itemsList[index]['status'] == "false") {
      bookmarkBloc.addCount();
      ItemModel itemModel = ItemModel(
        id: itemsList[index]['id'],
        title: itemsList[index]['title'],
        subTitle: itemsList[index]['subtitle'],
      );
      bookmarkBloc.addItems(itemModel);
      itemsList[index]['status'] = "true";
    } else {
      bookmarkBloc.removeCount();
      bookmarkBloc.removeItems(itemsList[index]['id']);
      itemsList[index]['status'] = "false";
    }
  }

  List itemsList = [
    {
      'id': 0,
      'title': 'item 1',
      'subtitle': 'this is item 1',
      'status': 'false',
    },
    {
      'id': 1,
      'title': 'item 2',
      'subtitle': 'this is item 2',
      'status': 'false',
    },
    {
      'id': 2,
      'title': 'item 3',
      'subtitle': 'this is item 3',
      'status': 'false',
    },
    {
      'id': 3,
      'title': 'item 4',
      'subtitle': 'this is item 4',
      'status': 'false',
    },
  ];

  navigateToBookmarksPage() {
    Get.toNamed(Routes.bookmarksPage);
  }
}
