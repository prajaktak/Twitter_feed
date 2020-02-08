import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api/twitter_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
  
}

class HomePageState extends State<HomePage>{
  Future<String> getFeeds() async{
    String consumerApiKey = "UoA2TXUyi0NngaW5a7aUqsRgx";
    String consumerApiSecret = "FN5mxRQcJ0nsXEnPxzTqt03zqRq5UIJqaxQOlciDoTbA8D0Ehi";
    String accessToken = "96678665-L6qvwfLtREKlzsUquNtRivPqfAkbeUjudBBbANAT5";
    String accessTokenSecret = "tDFUgkIRXeyV7hfwFB3WzOWbznITiNPlCf0ilEbBqfJe7";

    final _twitterOauth = new twitterApi(
      consumerKey: consumerApiKey,
     consumerSecret: consumerApiSecret,
     token: accessToken,
      tokenSecret: accessTokenSecret
    );

    Future twitterRequest = _twitterOauth.getTwitterRequest(
      // Http Method
      "GET", 
      // Endpoint you are trying to reach
      "statuses/user_timeline.json", 
      // The options for the request
      options: {
        "user_id": "19025957",
        "screen_name": "TTCnotices",
        "count": "20",
        "trim_user": "true",
        "tweet_mode": "extended", // Used to prevent truncating tweets
      },
    );

    var res = await twitterRequest;

    print(res.statusCode); 
    print(res.body);

    var tweets = json.decode(res.body);
    print(tweets);


    // var response = await http.get(
    //   Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
    //   //Uri.encodeFull("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=kPrajakta&count=2"),
    //   headers: {
    //     "Accept": "application/json"
    //   }
    // );

    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text("Get Feeds"),
          onPressed: getFeeds,
        )
      ),
    );
  }

}
