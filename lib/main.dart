import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/bookmark_model.dart';
import 'package:flutter_application_1/modules/app/app.bindings.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookmarkBloc()),
      ],
      child: GetMaterialApp(
        title: 'TerraSante',
        theme: ThemeUtils.themeData,
        // darkTheme: ThemeUtils.themeDataDark,
        getPages: AppPages.routes,
        initialRoute: Routes.onBoard,
        initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
