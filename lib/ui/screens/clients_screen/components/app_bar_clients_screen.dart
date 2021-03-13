import 'package:flutter/material.dart';
import 'package:training_app/models/client.dart';
import 'package:training_app/ui/screens/new_client_screen/new_client_screen.dart';

class AppBarClientsScreen extends StatelessWidget
    implements PreferredSizeWidget {
  final Function filterByGender;

  AppBarClientsScreen(this.filterByGender);

  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Clients'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () => goToNewClientScreen(context),
        ),
        PopupMenuButton(
          onSelected: filterByGender,
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            const PopupMenuItem(
              child: Text('Show Only Men'),
              value: Gender.Man,
            ),
            const PopupMenuItem(
              child: Text('Show Only Women'),
              value: Gender.Woman,
            ),
            const PopupMenuItem(
              child: Text('Show All Clients'),
              value: null,
            ),
          ],
        ),
      ],
    );
  }

  Future goToNewClientScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(NewClientScreen.routeName);
}
