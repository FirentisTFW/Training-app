import 'package:flutter/material.dart';
import '../../../../screens/client_profile_screen.dart';

class ClientItem extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;

  ClientItem(this.id, this.firstName, this.lastName);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToClientProfileScreen(context),
      child: Container(
        height: 90,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              personIcon,
              Expanded(
                child: Center(
                  child: Text(
                    '$firstName $lastName',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final personIcon = Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Icon(
      Icons.person,
      size: 30,
    ),
  );

  Future goToClientProfileScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(
        ClientProfileScreen.routeName,
        arguments: id,
      );
}
