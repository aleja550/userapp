import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _botonDisponible = false;
  
  @override
  Widget build(BuildContext context) {
    
    _solicitarUbicacion(context); 

    return Container(
      decoration: BoxDecoration(color: Color(0xFFFEDD7C)),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: 
              Text('USERAPP', 
              style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'Montserrat',
                ) 
              ),             
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(22, 20, 22, 10),
              child: 
                Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontFamily: 'Montserrat',
                ) 
              ),             
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: 370.0,
              height: 80.0,
              child: 
                RaisedButton(
                  splashColor: Colors.grey,
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text("IR A LOGIN", style: TextStyle(fontFamily: 'Montserrat', fontSize: 20)),
                  shape: StadiumBorder(),
                  onPressed: () => _irLogin(context),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: 
                Image(
                  image: AssetImage("assets/yellowrobot.png"), 
                  height: 215,
              ),       
            ),
          ),
          
        ],
      ),
    );
  }
  
  void _irLogin(BuildContext context)  {
    _solicitarUbicacion(context);
    if(_botonDisponible){
      Navigator.pushNamed(context, 'login');
    }
  }

  Future<void> _solicitarUbicacion(BuildContext context) async {
    Location location = new Location();
    PermissionStatus _permissionGranted;
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    
    if (!_serviceEnabled) {
       _serviceEnabled = await location.requestService();   

      if (!_serviceEnabled) {
        _botonDisponible = false;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
         _botonDisponible = false;
      }
    } else {
      _botonDisponible = true;
    }
  }
}
