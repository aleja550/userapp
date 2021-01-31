import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/src/pages/home_page.dart';
import 'package:userapp/src/pages/login_page.dart';
import 'package:userapp/src/pages/splash_page.dart';
import 'package:userapp/src/pages/welcome_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  final HttpLink httpLink = HttpLink(uri: 'https://graphqlzero.almansi.me/api');

  @override
  Widget build(BuildContext context) {

    ValueNotifier<GraphQLClient> cliente = ValueNotifier(
      GraphQLClient(
        cache: InMemoryCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: cliente,
      child: 
        MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'splash',
        routes: {
          'splash': (BuildContext context) => SplashScreenPage(),
          'welcome': (BuildContext context) => WelcomePage(),
          'login': ( BuildContext context) => LoginPage(),
          'home': ( BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFFFEDD7C)
        ),
      )
    );
  }
}