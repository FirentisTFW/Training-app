import 'package:flutter/material.dart';

class PopUpMenu {
  static Future<String> createPopUpMenuAndChooseOption(
    BuildContext context,
    Offset tapPosition,
  ) async {
    return await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        tapPosition.dx + 1,
        tapPosition.dy + 1,
      ),
      items: <PopupMenuEntry<String>>[
        _buildMenuItem(
          value: 'delete',
          icon: Icon(Icons.delete),
          text: 'Delete',
        ),
        _buildMenuItem(
          value: 'edit',
          icon: Icon(Icons.edit),
          text: 'Edit',
        ),
      ],
    );
  }

  static PopupMenuItem<String> _buildMenuItem({
    String value,
    Icon icon,
    String text,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: <Widget>[
          icon,
          const SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
