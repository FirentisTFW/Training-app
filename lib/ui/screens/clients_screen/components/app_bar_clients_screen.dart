import 'package:flutter/material.dart';
import 'package:training_app/ui/screens/new_client_screen/new_client_screen.dart';

class AppBarClientsScreen extends StatelessWidget
    implements PreferredSizeWidget {
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const AppBarClientsScreen();

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
          onSelected: (value) {},
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: const Text('Show Only Men'),
              value: 'aa',
            ),
            PopupMenuItem(
              child: const Text('Show Only Women'),
              value: 'aa',
            ),
          ],
        ),
      ],
    );
  }

  Future goToNewClientScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(NewClientScreen.routeName);
}
