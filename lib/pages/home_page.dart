import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_lab2/auth/bloc/auth_bloc.dart';
import 'package:mobile_dev_lab2/pages/favorites_page.dart';
import 'package:mobile_dev_lab2/pages/recognized_song.dart';
import 'package:mobile_dev_lab2/record/bloc/record_bloc.dart';

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
              child: BlocConsumer<RecordBloc, RecordState>(
                  builder: ((context, state) {
            if (state is RecordLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            RecordEvent event;
            if (state is Recording) {
              event = StopRecordingEvent();
            } else {
              event = StartRecordingEvent();
            }

            Widget button = Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                    iconSize: 150,
                    onPressed: () {
                      BlocProvider.of<RecordBloc>(context).add(event);
                    },
                    icon: const Icon(
                      Icons.music_note,
                      color: Colors.purple,
                    )));
            if (state is Recording) {
              return AvatarGlow(
                  child: button,
                  glowColor: Colors.white,
                  endRadius: 190.0,
                  showTwoGlows: true);
            } else {
              return button;
            }
          }), listener: (context, state) {
            if (state is RecordingFinished) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          RecognizedSong(songData: state.songData))));
              return;
            }
            if (state is RecordingFailedRecognition) {
              // alert dialog of failed recognition
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Song not recognized"),
                        content: const Text("Please try again"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<RecordBloc>(context)
                                    .add(CleanRecordingEvent());
                                Navigator.of(context).pop();
                              },
                              child: const Text("Ok"))
                        ],
                      ));

              return;
            }
          })),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavoritesPage()));
                        },
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
                        onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Cerrar sesión'),
                                content: const Text(
                                    'Al serrar sesión sera redireccionado a la '
                                    'pantalla de inicio de sesión y no tendrá '
                                    'acceso a la funcionalidad de la app hasta '
                                    'volver a iniciar sesión. ¿Está seguro?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(SignOutEvent());
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
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
