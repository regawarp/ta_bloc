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
        title: 'BLoC',
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
  Color titleColor = Colors.black;
  double themeFontSize = 10;
  String themeFontFamily = "Arial";
  List<double> imageSize = [100.0, 120.0];

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
                  leading: Icon(Icons.title),
                  title: Text('Purple Title'),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.title),
                  title: Text('Black Title'),
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text('White Card'),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text('Purple Card'),
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.text_fields),
                  title: Text('Small Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 5,
                child: ListTile(
                  leading: Icon(Icons.format_size),
                  title: Text('Large Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: ListTile(
                  leading: Icon(Icons.text_format),
                  title: Text('Arial Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 7,
                child: ListTile(
                  leading: Icon(Icons.text_format),
                  title: Text('Roboto Font'),
                ),
              ),
              PopupMenuItem<int>(
                value: 8,
                child: ListTile(
                  leading: Icon(Icons.zoom_out),
                  title: Text('Small Picture'),
                ),
              ),
              PopupMenuItem<int>(
                value: 9,
                child: ListTile(
                  leading: Icon(Icons.zoom_in),
                  title: Text('Large Picture'),
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
                      items: <String>['1000', '5000', '10000']
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
                                            child: BlocBuilder<ThemeBloc,
                                                ThemeState>(
                                              buildWhen: (previous, current) {
                                                return current
                                                        is ThemeImageSmall ||
                                                    current is ThemeImageLarge;
                                              },
                                              builder: (context, state) {
                                                if (state is ThemeImageSmall) {
                                                  imageSize = [100.0, 120.0];
                                                } else if (state
                                                    is ThemeImageLarge) {
                                                  imageSize = [120.0, 140.0];
                                                }
                                                return Container(
                                                  height: imageSize[1],
                                                  width: imageSize[0],
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          i.image.toString(),
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                );
                                              },
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
                                                        i.title.toString(),
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
                                                      } else if(state is ThemeTextFontArial){
                                                        themeFontFamily = "Arial";
                                                      } else if(state is ThemeTextFontRoboto){
                                                        themeFontFamily = "Roboto";
                                                      }
                                                      return Text(
                                                        i.synopsis,
                                                        style:
                                                        TextStyle(
                                                          fontSize: themeFontSize,
                                                          fontFamily: themeFontFamily,
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
      case 6:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTextFontArial());
        break;
      case 7:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeTextFontRoboto());
        break;
      case 8:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeImageSmall());
        break;
      case 9:
        final themeBloc = context.read<ThemeBloc>();
        themeBloc.add(ThemeChangeImageLarge());
        break;
    }
  }
}
