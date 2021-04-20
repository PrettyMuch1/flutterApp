import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var a = true;
    return MaterialApp(

      title: 'Firebase Restaurant',
      home: Scaffold(
        appBar: AppBar(title: Text("Firebase Restaurant")),

        body: StreamBuilder(

          stream: a == true ? Firestore.instance.collection('productos').orderBy('Delivery').snapshots():
          Firestore.instance.collection('productos').orderBy('Price').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            List<DocumentSnapshot> docs = snapshot.data.documents;
            return ListView.builder(
              itemCount:docs.length,
              itemBuilder: (context, index){
                Map<String, dynamic> data = docs[index].data;
                return Card(
                  elevation: 10.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Image.network(data['Image'], height: 150),
                      SizedBox(height: 10.0),
                      Text(data['Name']),
                      SizedBox(height: 10.0),
                      Text(data['Description']),
                      SizedBox(height: 10.0),
                      Text("Price:"),
                      Text(r'$'+data['Price'].toString()),
                      SizedBox(height: 10.0),
                      Text("Estimated arrival:"),
                      Text(data['Delivery'].toString()+" mins"),
                    ],
                  ),
                );

              }
            );
          }
        ),

          floatingActionButton: Stack(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left:31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: () {
a = false;
      },
        child: const Icon(Icons.attach_money),
        backgroundColor: Colors.green,
      ),
                ),),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
a = true;
    },
      child: const Icon(Icons.alarm),
      backgroundColor: Colors.green,
    ),
              ),
            ],
          ),
      ),
    );
  }
}


