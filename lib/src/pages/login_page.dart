import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/src/bloc/provider.dart';
import 'package:userapp/src/models/usuario_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginBloc bloc;

  @override
  void initState(){
      super.initState();
      bloc = LoginBloc();
  }

  @override
  void dispose(){
      bloc?.dispose();
      super.dispose();
  }

  final String getUsers = """
  query getUsers {
    users{
      data{
        id
        username
        phone   
      }
    }
  }
  """;

  List<UsuarioModel> usuariosList = new List();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   
          Query(options: QueryOptions( documentNode: gql(getUsers)), builder: (QueryResult result, {fetchMore, refetch}) {
            if(result.hasException){
              return Text(result.exception.toString());
            }

            if(result.loading){
              return Center(child: CircularProgressIndicator());
            }

            List users = result.data["users"]["data"];

            users.forEach( (u){
              final uTemp = UsuarioModel.fromJson(u);
              usuariosList.add( uTemp );
            });

            return Container(
              child: Stack(
                children: <Widget>[
                  _crearFondo(context),
                  _loginForm(context)
                ],
              ),
            );
          }
          ), 
    );
  }

  Widget _loginForm(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 380.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 9.0,
                  offset: Offset(0.0, 6.0),
                  spreadRadius: 2.0
                ),
              ]
            ),
            child: Column(
              children: <Widget>[
                _inputUsuario(bloc),
                SizedBox(height: 10.0,),
                _inputPassword(bloc),
                SizedBox(height: 20.0,),
                _botonSignUp(bloc),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputUsuario(LoginBloc bloc) {

     return StreamBuilder(
       stream: bloc.usuarioStream,
       builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              icon: Icon(Icons.person_outline_sharp, color: Color(0xFFFEDD7C)),
              labelText: 'Usuario',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeUsuario,
          ),    
        );
      },
    );

  }

    Widget _inputPassword(LoginBloc bloc) {

      return StreamBuilder(
       stream: bloc.passwordStream,
       builder: (BuildContext context, AsyncSnapshot snapshot) {
         return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Color(0xFFFEDD7C)),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),     
        );
      },
    );

  }

  Widget _botonSignUp(LoginBloc bloc) {
      return StreamBuilder(
       stream: bloc.formValidStream,
       builder: (BuildContext context, AsyncSnapshot snapshot) {
         return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
            child: Text('SIGN IN'),
          ),
          shape: StadiumBorder(),
          elevation: 0.0,
          color: Color(0xFFFEDD7C),
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null,
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    usuariosList.forEach((u) => {
      if(bloc.usuario.toLowerCase() == u.username.toLowerCase() && bloc.password.toLowerCase() == u.phone.toLowerCase()){
        Navigator.pushReplacementNamed(context, 'home', arguments: {u.id})
      }
    });     

    return null;
  }

  Widget _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final parteNaranja = Container(
      height: size.height * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:<Color> [
            Color(0xFFFEDD7C),
            Color(0xFFFEDD7C) 
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.2)
      ),
    );

    return Stack(
      children: <Widget>[
        parteNaranja,
        Positioned(top: 90.0, left: 30.0, child: circulo,),
        Positioned(top: -40.0, right: -30.0, child: circulo,),
        Positioned(bottom: -50.0, right: -10.0, child: circulo,),

        Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 110)),
              Image(image: AssetImage("assets/robot.png"),  height: 325, width: 500),  
            ],
          ),
        )
      ],  
    );
  }
}