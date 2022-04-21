import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey[900],
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
              child: Center(
                  child: Text(
            "Toque para escuchar",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ))),
          Expanded(
            child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                    iconSize: 150,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.music_note,
                      color: Colors.purple,
                    ))),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: const ShapeDecoration(
                        color: Colors.white, shape: CircleBorder()),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    decoration: const ShapeDecoration(
                        color: Colors.white, shape: CircleBorder()),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.power_settings_new_sharp,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
