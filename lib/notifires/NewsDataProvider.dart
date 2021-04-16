import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_news_task/Utils/service.dart';
import 'package:my_news_task/model/ModelNewsData.dart';


class NewsDataProvider extends ChangeNotifier{

  var isLoading = true;
  ModelNewsData responseOfNewsApi = ModelNewsData();
  ModelNewsData listToDisplay = ModelNewsData();
  ScrollController controller;
  Timer debounceTimer;
  BuildContext context;
  String shortBy ="publishedAt";
  String searchQuery ="";
  var textController = TextEditingController();
  var page =1;

  NewsDataProvider(this.context){
    getNewsList(context);
    controller= new ScrollController()..addListener(scrollListener);
  }

   getNewsList(BuildContext context) async {
    await Service.requestApiWithLoader(Service.baseUrl+"top-headlines?country=in&category=business&apiKey="+Service.API_KEY, context, true)
        .then((response) {
      if (response != null) {
        responseOfNewsApi = ModelNewsData.fromJson(response);
          listToDisplay = responseOfNewsApi;
          isLoading = false;
        notifyListeners();
      }
    });
  }


  void filterSearchResults(String query) {
    List<Articles> temp = <Articles>[];
    if (query.isNotEmpty) {
      listToDisplay.articles.forEach((item) {
        if (item.title.contains(query)) {
          temp.add(item);
        }
      });
        listToDisplay.articles=temp;
        notifyListeners();
    } else {
        listToDisplay=responseOfNewsApi;
        notifyListeners();
    }
  }
  void scrollListener() {

    if (controller.position.extentAfter < responseOfNewsApi.articles.length) {
      page++;
      Service.requestApiWithLoader(Service.baseUrl+"top-headlines?country=us&category=business&page="+page.toString()+"&apiKey="+Service.API_KEY, context, true)
          .then((response) {
        if (response != null) {
          responseOfNewsApi = ModelNewsData.fromJson(response);
          listToDisplay.articles.addAll(responseOfNewsApi.articles);
          isLoading = false;
          notifyListeners();
        }
      });
    }
  }
  void searchByCategory(String category, String type) {
      page=0;
      page++;
      Service.requestApiWithLoader(Service.baseUrl+"top-headlines?"+type+"="+category+"&page="+page.toString()+"&apiKey="+Service.API_KEY, context, true)
          .then((response) {
        if (response != null) {
          responseOfNewsApi = ModelNewsData.fromJson(response);
          listToDisplay= responseOfNewsApi;
          isLoading = false;
          notifyListeners();
        }
      });
  }

  void addShortByForQuery(String name)=> shortBy=name;

  void searchByQuery(String query) {

      Service.requestApiWithLoader(Service.baseUrl+"everything?q="+query+"&shortBy="+shortBy+"&apiKey="+Service.API_KEY, context, true)
          .then((response) {
        if (response != null) {
          responseOfNewsApi = ModelNewsData.fromJson(response);
          listToDisplay= responseOfNewsApi;
          isLoading = false;

          FocusScope.of(context).requestFocus(new FocusNode());
          notifyListeners();
        }
      });
  }

  searchListener(String query) {
    if (debounceTimer?.isActive ?? false) debounceTimer.cancel();

    debounceTimer = Timer(Duration(milliseconds: 800), () {
      searchByQuery(query);
      //   filterSearchResults(controller.text);
    });
  }
}