
import 'package:flutter/material.dart';
import 'package:manga_app/src/providers.dart/mangas_provider.dart';

class InheritedManga extends InheritedWidget {
  final MangasProvider helper;

  InheritedManga({this.helper, Widget child}) : super(child: child);

  static InheritedManga of(BuildContext context) {
    // ignore: deprecated_member_use
    return context.inheritFromWidgetOfExactType(InheritedManga) as InheritedManga;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

}