import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//   home: EditJob(),
// ));

class EditJob extends StatelessWidget{
  int _ratingcontroller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text("edit job"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              SizedBox(height: 20,),
              TextField(

                decoration: InputDecoration(
                    hintText: "Title",
                    labelText: "Job Title",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),

                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true
                ),
                obscureText: false,
              ),

              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(

                    hintText: "Description",
                    labelText: "Description",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true
                ),
                obscureText: false,
                maxLines: 6,
              ),
              SizedBox(height: 20,),

              DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: "Categories",
                      border: InputBorder.none,
                      fillColor: Colors.white54,
                      filled: true
                  ),
                  value: _ratingcontroller,
                  items: [], onChanged: null),
              SizedBox(height: 20,),
              new SizedBox(
                width: 200.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: (){},
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Container(
                    child: Text("Update"),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}