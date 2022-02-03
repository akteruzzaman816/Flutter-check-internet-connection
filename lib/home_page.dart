import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((event) { });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Check Connection"),
          onPressed: (){
            checkConnection();
          },
        ),
      ),
    );
  }


  Future checkConnection() async{
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.mobile){
      showSnackBar("Mobile");
    }else if(result == ConnectivityResult.wifi){
      showSnackBar("Wifi");
    }else{
      showSnackBar("No internet connection");
    }
  }

  void showSnackBar(String message){
    var snackBar = SnackBar(
      backgroundColor: Colors.blue,
      content: Text(message)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}
