import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildHeader(),
          _buildDrawerItem(icon: Icons.contacts, text: 'Contacts', onTap: () {})
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 75.0,
              height: 75.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.weskilled.com/wp-content/uploads/2019/07/male-gravatar-compressor.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: new Text(
                "Aleksandr Kharchenko",
                style: TextStyle(fontSize: 15.0),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: new Row(children: <Widget>[
        Icon(icon),
        Padding(
            padding: EdgeInsets.only(left: 0.8),
            child: new Padding(
                padding: EdgeInsets.only(left: 10),
                child: new Text(
                  text,
                  style: TextStyle(fontSize: 16.0),
                )))
      ]),
      onTap: onTap,
    );
  }
}
