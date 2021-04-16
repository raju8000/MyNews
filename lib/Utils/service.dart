import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Utils.dart';

class Service{

  static String baseUrl="https://newsapi.org/v2/";
  static String API_KEY="8127b3d1c69d438599cd2962cf485925";


  static Future<dynamic> requestApiWithLoader(String urlInString, BuildContext context,bool isLoading) async {

    var connectivityResult = await Connectivity().checkConnectivity();
    var responseBody;

    if (connectivityResult == ConnectivityResult.mobile ||  connectivityResult == ConnectivityResult.wifi ) {
      if (isLoading)
        Utils.showLoadingDialog(context);
      print("Url: " + urlInString);
      var url = Uri.parse(urlInString);

      try {
        final response = await http.get(url);

        print("Response: " + response.body);
        if (response.statusCode == 200) {
          if (isLoading)
            Navigator.pop(context);
          responseBody = json.decode(response.body);
        }
        else {
          if (isLoading)
            Navigator.pop(context);
          Utils.showMessageDialog(context,'Something went wrong');
        }
      }
      catch(e){
        if (isLoading)
          Navigator.pop(context);
        Utils.showMessageDialog(context, "Exception Generated: "+e.toString());
      }
      return responseBody;
    }
    else
      Utils.showMessageDialog(context, "No internet connection");
      return null;
  }
}