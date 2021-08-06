
import 'package:flutter/material.dart';
import 'package:house_client_application/Widgets/model/main_menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemFirst = [
    itemAllCategories,
  ];

  static const List<MenuItem> itemSecond = [
    itemExit,
  ];

  static const itemAllCategories = MenuItem(
    text: 'Все меню',
    icon: Icons.menu_book
  );

  static const itemExit = MenuItem(
      text: 'Вихiд',
      icon: Icons.exit_to_app,
  );

  addItemFirst(String text) {
    itemFirst.add( MenuItem(
        text: text,
        icon: Icons.ramen_dining));
  }

}