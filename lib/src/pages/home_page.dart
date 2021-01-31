import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final parameter = ModalRoute.of(context).settings.arguments.toString();
  final idUser = parameter.replaceAll('{', '').replaceAll('}','');
  final String getData = """
     query getPhoto(\$id: ID!) {
      user(id: \$id) {
        id
        name
        email
        albums (options: {paginate: {page: 1, limit:1 }}) {
          data{
            photos(options: {paginate: {page: 1, limit: 12}}){
              data{
                url
              }
            }
          }
        }
      }
    }
  """;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[

          Container(
            padding: EdgeInsets.all(6.0),
            child: Icon(Icons.chat, color: Colors.white, size: 40.0,),
          ),

          Container(
            padding: EdgeInsets.all(6.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1018943227791982592/URnaMrya.jpg'),
              radius: 25.0,
            ),
          ),
        ],
      ),
      body: 
            Query(options: QueryOptions( documentNode: gql(getData), 
            variables: {
              "id": int.parse(idUser)
            }),
            builder: (QueryResult result, {fetchMore, refetch}) {
            if(result.hasException){
              return Text(result.exception.toString());
            }

            if(result.loading){
              return Center(child: CircularProgressIndicator());
            }

            var user = result.data["user"];

            List photosList = result.data["user"]["albums"]["data"][0]["photos"]["data"];

            return ListView.builder(
              itemCount: photosList.length, itemBuilder: (context, index){

                final photo = photosList[index]["url"];
                return _card(photo, user);
              }
            );
          }
          ), 
    );
  }

    Widget _card(final photo, dynamic user) { 
    final card = Container(
      // clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0,),
          Row(
            children: [
              Container(
              padding: EdgeInsets.only(right: 20.0),
              child:  FadeInImage(
              image: NetworkImage('$photo'),
              placeholder: AssetImage('assets/loader.gif'),
              fadeInDuration: Duration( milliseconds: 200 ),
              height: 60.0,
              fit: BoxFit.cover,
          ),), 
          Container(
            child: Text(user['name'] + '  -  ' + user['email'])
          ),
            ],
          ),      

        ],
      ),
    );


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}