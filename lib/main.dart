import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_bloc/models/Movie.dart';
import 'package:ta_bloc/services/MovieService.dart';

import 'bloc/theme_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: MaterialApp(
        title: 'BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'BLoC'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MovieService _movieService = MovieService();
  Future<List<Movie>> _movieList;
  String dropdownValue = '1000';
  Color cardColor = Colors.white;
  Color titleColor = Colors.black;
  double themeFontSize = 10;
  String themeFontFamily = "Arial";

  @override
  void initState() {
    super.initState();
    print("init");
    _movieList = getMovies(1000);
  }

  Future<List<Movie>> getMovies(int limit) async {
    print('getMovies');
    return await _movieService.readMovies(limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Purple Title'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('Black Title'),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text('White Card'),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text('Purple Card'),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Text('Small Font'),
              ),
              PopupMenuItem<int>(
                value: 5,
                child: Text('Large Font'),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: Text('Arial Font'),
              ),
              PopupMenuItem<int>(
                value: 7,
                child: Text('Roboto Font'),
              ),
              PopupMenuItem<int>(
                value: 8,
                child: Text('Small Picture'),
              ),
              PopupMenuItem<int>(
                value: 9,
                child: Text('Big Picture'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Jumlah data:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      items: <String>['100', '1000', '10000']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.right,
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          _movieList = getMovies(int.parse(newValue));
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: FutureBuilder(
                    future: _movieList,
                    builder: (context, snapshots) {
                      if (snapshots.hasError) {
                        return Text(
                            'Error while retrieving data from database');
                      } else if (snapshots.hasData) {
                        return Column(
                          children: [
                            for (var i in snapshots.data)
                              BlocBuilder<ThemeBloc, ThemeState>(
                                buildWhen: (previous, current) {
                                  return current is ThemeCardBackgroundPurple ||
                                      current is ThemeCardBackgroundWhite;
                                },
                                builder: (context, cardstate) {
                                  if (cardstate is ThemeCardBackgroundPurple) {
                                    cardColor = Colors.purpleAccent;
                                  } else if (cardstate
                                      is ThemeCardBackgroundWhite) {
                                    cardColor = Colors.white;
                                  }
                                  return Card(
                                    color: cardColor,
                                    elevation: 5,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            height: 120,
                                            color: Colors.lightBlue,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BlocBuilder<ThemeBloc,
                                                    ThemeState>(
                                                  buildWhen:
                                                      (previous, current) {
                                                    return current
                                                            is ThemeTextPurple ||
                                                        current
                                                            is ThemeTextBlack;
                                                  },
                                                  builder: (context, state) {
                                                    /* masukin ke variable lalu buildnya di bawah condition*/
                                                    if (state
                                                        is ThemeTextPurple) {
                                                      titleColor =
                                                          Colors.purple;
                                                    } else if (state
                                                        is ThemeTextBlack) {
                                                      titleColor = Colors.black;
                                                    }
                                                    return Text(
                                                      i.title.toString() +
                                                          " " +
                                                          i.id.toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: titleColor,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: Colors.amber,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: BlocBuilder<
                                                        ThemeBloc, ThemeState>(
                                                      buildWhen:
                                                          (previous, current) {
                                                        return current
                                                                is ThemeTextFontArial ||
                                                            current
                                                                is ThemeTextFontRoboto;
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is ThemeTextFontArial) {
                                                          themeFontFamily =
                                                              "Arial";
                                                        } else if (state
                                                            is ThemeTextFontRoboto) {
                                                          themeFontFamily =
                                                              "Roboto";
                                                        }
                                                        return Text(
                                                          i.genre.toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                themeFontFamily,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                BlocBuilder<ThemeBloc,
                                                    ThemeState>(
                                                  buildWhen:
                                                      (previous, current) {
                                                    return current
                                                            is ThemeTextFontSmall ||
                                                        current
                                                            is ThemeTextFontLarge ||
                                                        current
                                                            is ThemeTextFontArial ||
                                                        current
                                                            is ThemeTextFontRoboto;
                                                  },
                                                  builder: (context, state) {
                                                    if (state
                                                        is ThemeTextFontSmall) {
                                                      themeFontSize = 10;
                                                    } else if (state
                                                        is ThemeTextFontLarge) {
                                                      themeFontSize = 20;
                                                    }
                                                    return Text(
                                                      i.synopsis.toString(),
                                                      style: TextStyle(
                                                        fontSize: themeFontSize,
                                                        fontFamily:
                                                            themeFontFamily,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTextToPurple());
        break;
      case 1:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTextToBlack());
        break;
      case 2:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeCardBackgroundWhite());
        break;
      case 3:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeCardBackgroundPurple());
        break;
      case 4:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTextFontSmall());
        break;
      case 5:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTextFontLarge());
        break;
    }
  }
}
