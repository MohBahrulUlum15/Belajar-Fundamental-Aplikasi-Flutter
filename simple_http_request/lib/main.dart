import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Fetch Data Example',
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: AlbumPage(),
   );
 }
}
 
class Album {
 final int userId;
 final int id;
 final String title;
 
 Album({required this.userId, required this.id, required this.title});
 
 factory Album.fromJson(Map<String, dynamic> json) {
   return Album(
     userId: json['userId'],
     id: json['id'],
     title: json['title'],
   );
 }
}
 
class AlbumPage extends StatefulWidget {
 @override
 State<AlbumPage> createState() => _AlbumPageState();
}
 
class _AlbumPageState extends State<AlbumPage> {
 late Future<Album> _futureAlbum;
 
 @override
 void initState() {
   super.initState();
   _futureAlbum = fetchAlbum();
 }
 
 Future<Album> fetchAlbum() async {
   final response =
       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
   if (response.statusCode == 200) {
     return Album.fromJson(json.decode(response.body));
   } else {
     throw Exception('Failed to load album');
   }
 }
 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Fetch Data Example'),
     ),
     body: Center(
       child: FutureBuilder<Album>(
         future: _futureAlbum,
         builder: (context, snapshot) {
           var state = snapshot.connectionState;
           if (state != ConnectionState.done) {
             return Center(child: CircularProgressIndicator());
           } else {
             if (snapshot.hasData) {
               return Text(snapshot.data!.title);
             } else if (snapshot.hasError) {
               return Center(child: Text("${snapshot.error}"));
             } else {
               return Text('');
             }
           }
         },
       ),
     ),
   );
 }
}