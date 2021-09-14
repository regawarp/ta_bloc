import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
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
        title: 'MovDB - BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'MovDB'),
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
  Color titleFontColor = Colors.black;
  Color synopsisFontColor = Colors.black;
  double titleFontSize = 20;
  double synopsisFontSize = 10;

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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black45,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text('Ubah background item Card'),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.title),
                  title: Text('Ubah font-size Title'),
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.title),
                  title: Text('Ubah font-color Title'),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text('Ubah font-size Synopsis'),
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text('Ubah font-color Synopsis'),
                ),
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
                      items: <String>['1000', '10000']
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
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (var i in snapshots.data)
                                BlocBuilder<ThemeBloc, ThemeState>(
                                  buildWhen: (previous, current) {
                                    return current is ThemeCardBackgroundPurple;
                                  },
                                  builder: (context, cardstate) {
                                    if (cardstate is ThemeCardBackgroundPurple) {
                                      cardColor = Colors.purple;
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
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          i.image.toString(),
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
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
                                                              is ThemeTitleFontLarge ||
                                                          current
                                                              is ThemeTitleFontPurple;
                                                    },
                                                    builder: (context, state) {
                                                      /* masukin ke variable lalu buildnya di bawah condition*/
                                                      if (state
                                                          is ThemeTitleFontLarge) {
                                                        titleFontSize = 25;                                                            25;
                                                      } else if (state
                                                          is ThemeTitleFontPurple) {
                                                        titleFontColor = Colors.purpleAccent;
                                                      }
                                                      return Text(
                                                        i.title.toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: titleFontSize,
                                                          color: titleFontColor,
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
                                                      child: Text(
                                                            i.genre.toString(),
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
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
                                                              is ThemeSynopsisFontLarge ||
                                                          current
                                                              is ThemeSynopsisFontPurple;
                                                    },
                                                    builder: (context, state) {
                                                      if (state
                                                          is ThemeSynopsisFontLarge) {
                                                        synopsisFontSize = 20;
                                                      } else if (state
                                                          is ThemeSynopsisFontPurple) {
                                                        synopsisFontColor = Colors.purpleAccent;
                                                      }
                                                      return Text(
                                                        i.synopsis,
                                                        style:
                                                        TextStyle(
                                                          fontSize: synopsisFontSize,
                                                          color: synopsisFontColor
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
                          ),
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
        themeBloc.add(ThemeChangeCardBackgroundToPurple());
        break;
      case 1:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTitleFontToLarge());
        break;
      case 2:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTitleFontToPurple());
        break;
      case 3:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeSynopsisFontToLarge());
        break;
      case 4:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeSynopsisFontToPurple());
        break;
    }
  }
}
