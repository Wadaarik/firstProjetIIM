import 'package:firebase_core/firebase_core.dart';
import 'package:firstprojetimmw/functions/firestoreHelper.dart';
import 'package:firstprojetimmw/view/dashboard.dart';
import 'package:firstprojetimmw/view/inscription.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting("fr_FR");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? mail;
  String? password;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bienvenue"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
          child: bodyPage()
      ),
    );
  }


  Widget bodyPage(){
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        //Image du profil

        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("w_zodiac-monsters-fantasy-digital-art-damon-hellandbrand-2.jpg"),
              fit: BoxFit.fill
            )
          )
        ),

        ////////////////////////////////




        SizedBox(height: 15,),
        TextField(
          onChanged: (String text){
            setState(() {
              mail = text;
            });

          },
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            ),

            
          ),


        ),
        SizedBox(height: 15,),


        TextField(
          obscureText: true,
          onChanged: (String text){
            setState(() {
              password = text;
            });

          },
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),


          ),


        ),
        SizedBox(height: 15,),
        ElevatedButton(
            onPressed: (){
              FirestoreHelper().ConnectUser(mail: mail!, password: password!).then((value){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context){
                      return dashboard(mail, password);
                    }
                ));
              }).catchError((error){
                print(error);
              });



            },
            child: Text("Connexion")
        ),
        SizedBox(height: 15,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return register();
                }
            ));

          },
          child: Text("Inscription",style: TextStyle(color: Colors.blue),),
        ),
      ],
    );



  }
}
