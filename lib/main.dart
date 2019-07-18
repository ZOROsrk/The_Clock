import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      title: 'the_clock',
      home: new HomePage(),
    ));

//homepage
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  HomePageState();

  String _currentTime() {
    return "${DateTime.now().hour}: ${DateTime.now().minute}:${DateTime.now().second}";
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this,duration: new Duration(seconds: 1));
    animationController.addListener((){
      if(animationController.isCompleted){
        animationController.reverse();
      }
      else if(animationController.isDismissed){
        animationController.forward();
      }
      setState(() {
      });
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation = new CurvedAnimation(parent: animationController,curve: Curves.easeInOut);
    animation = new Tween(begin: -0.5,end: 0.5).animate(animation);
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
            child: new Text(
          "Clock",
        )),
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
      ),
      body: new Container(
        color: Colors.deepOrange,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Material(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                elevation:40.0,
                color: Colors.brown.shade900,
                child: Container(
                    width: 320,
                    height: 320,
                    child: new Center(
                        child: new Text(
                      _currentTime(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.0),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: new Image.asset("assets/pandulum.png", height: 200,
                  width:500,)
                 
                ),
              )
            ]),
      ),
    );
  }
}
