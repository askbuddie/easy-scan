import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: Myclip(),
            child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.purple),
                child: Center(
                  child: Text('Easy-Scan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      )),
                )),
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.network(
                      'https://th.bing.com/th/id/OIP.oJcVK-0dh6ruhQ2UAl-thgHaE6?w=271&h=180&c=7&o=5&dpr=1.25&pid=1.7'),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 50),
                  child: Image.network(
                      'https://www.internationalrivers.org/sites/default/files/images/book/elizabeth_brink/kissimmee.gif'),
                ),
                Container(
                    height: MediaQuery.of(context).size.width / 2,
                    width: MediaQuery.of(context).size.width * .7,
                    child: Icon(Icons.add)),
              ],
            ),
          ))
        ],
      ),
      floatingActionButton: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.purple,
        onPressed: () {},
        child: Text('Convert'),
      ),
    );
  }
}

class Myclip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    Offset midpoint = Offset(size.width / 2, size.height);
    Offset nxtPoint = Offset(size.width, size.height / 2);
    path.quadraticBezierTo(midpoint.dx, midpoint.dy, nxtPoint.dx, nxtPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
