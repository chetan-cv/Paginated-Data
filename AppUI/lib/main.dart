import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models.dart';
import 'apiCall.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.deepPurple,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginatedClass(),
    );
  }
}

class PaginatedClass extends StatefulWidget {
  @override
  PaginatedClassState createState() => PaginatedClassState();
}

ScrollController _scrollController = new ScrollController();

class PaginatedClassState extends State<PaginatedClass>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool _loading;
  Future _getObj;
  String paginatedUrl;

  @override
  void initState() {
    paginatedUrl = 'Your URL will come here';
    _loading = false;

    //for animated Circular Progress Indicator
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();

    //getting api data
    _getObj = getData(paginatedUrl);

    //Scroll Controller event. It will get triggered once the end of scroll is reached.
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {

        //Start a circular loader
        if (!_loading && mounted) {
          setState(() {
            _loading = true;
          });
        }

        print('reached max cap');

        //Below is through which we get other data of paginated api
        _getObj.then((value) async {
          if (value.next != 'null') {
            DataModel _paginatedData =
                await ApiBackend().getApiData(value.next);
            if (mounted) {
              setState(() {
                for (var i = 0; i < _paginatedData.results.length; i++) {
                  //updating list of products
                  value.results.add(_paginatedData.results[i]);
                }
                value.next = _paginatedData.next;
              });
            }
          } else {}
        });
        //Scroll Controller end
        await Future.delayed(Duration(seconds: 2));
        //To stop showing loading sign and continue to show data
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      }
    });
    super.initState();
  }

  getData(paginatedUrl) async {
    return await ApiBackend().getApiData(paginatedUrl);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Paginated View'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepPurple[700],
          ),
          body: FutureBuilder(
            future: _getObj,
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? ListView.builder(
                      itemCount: snapshot.data.results.length + 1,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index == snapshot.data.results.length)
                          return Center(
                            child: Opacity(
                              opacity: _loading ? 1.0 : 0.0,
                              child: CircularProgressIndicator(
                                valueColor: animationController.drive(
                                    ColorTween(
                                        begin: Colors.blueAccent,
                                        end: Colors.red)),
                              ),
                            ),
                          );
                        else
                          return Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data.results[index].title),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                      snapshot.data.results[index].subTitle),
                                ),
                              ),
                              Divider()
                            ],
                          );
                      })
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: animationController.drive(ColorTween(
                            begin: Colors.blueAccent, end: Colors.red)),
                      ),
                    );
            },
          )),
    );
  }
}
