
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Network{
bool isconnected =false;
Network(){
  var  ntwk = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{ 
      isconnected = await InternetConnectionChecker().hasConnection;
      
});

}

Stream<bool> checknetworkstream()async *{
  bool temp = isconnected;
while(true){
  if(isconnected!=temp){
    temp = isconnected;
    yield isconnected;
  }

}

}  
  
}