import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news_task/Utils/filterHelper.dart';
import 'package:my_news_task/model/ModelFilterValues.dart';
import 'package:my_news_task/model/ModelNewsData.dart';
import 'package:my_news_task/notifires/NewsDataProvider.dart';
import 'package:my_news_task/screen/NewsDetail.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text("My News")),backgroundColor: Colors.green,),
        body:
            ChangeNotifierProvider(
                create:(_) => NewsDataProvider(context),
              child: NewsListWidget(key: UniqueKey()),
            ),
      )
    );
  }
}


class NewsListWidget extends StatelessWidget {
  const NewsListWidget({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Articles> articles = <Articles>[];
    var dataForSearch= Provider.of<NewsDataProvider>(context,listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            color: Colors.white,
            child: TextField(
              // controller: _textController,
              onChanged: (value){
                if(value.isNotEmpty)
                dataForSearch.searchListener(value);
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Category List'),
                            content: setupAlertDialogContainer(FilterHelper.getShortByItem(),dataForSearch,"shortBy"),
                          );
                        });
                  },
                  icon: Icon(Icons.short_text_sharp),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Consumer<NewsDataProvider>(
              builder:(context, newsDataProvider, _){
                articles = newsDataProvider.listToDisplay.articles;
                return newsDataProvider.listToDisplay.articles==null || newsDataProvider.listToDisplay.articles.isEmpty
                    ? Container()
                    :Container(
                  color: Colors.green,
                      child: Column(
                        children: [
                          SizedBox(height: 0.6.h,),
                          Center(child: Text("Filter By",style: TextStyle(color: Colors.white,fontSize: 12.0.sp),),),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 1.0.w),
                            child: Row(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                                child: RaisedButton(onPressed:(){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Category List'),
                                          content: setupAlertDialogContainer(FilterHelper.getCategory(),newsDataProvider,"category"),
                                        );
                                      });
                                },
                                  child: Text("Category"),),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                                child: RaisedButton(onPressed:(){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Country List'),
                                          content: setupAlertDialogContainer(FilterHelper.getCountryList(),newsDataProvider,"country"),
                                        );
                                      });
                                },
                                  child: Text("Country"),),
                              ),
                            ],),
                          ),
                          Expanded(
                            child: Container(
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              },
                              child: Column(
                                children: [

                                  Expanded(child: articles.isEmpty ?
                                  Container():
                                  ListView.builder(
                                    padding: new EdgeInsets.all(8.0),
                                    itemCount: articles.length??0,
                                    controller: newsDataProvider.controller,
                                    itemBuilder: (_, int index) {
                                      return NewsListItem(articles: articles[index]);
                                    },
                                  )),
                                ],
                              ),
                            )),
                          ),
                        ],
                      ),
                    );
              }),
        ),
      ],
    );
  }
}


class NewsListItem extends StatelessWidget {
  final Articles articles;
  double width;
  NewsListItem({this.articles});
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        articles.urlToImage=articles.urlToImage??"";
        articles.author=articles.author??"";
        articles.description=articles.description??"";
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => NewsDetail(
              articles: articles,)
        ));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 2.0.h),
          child: Column(
            children: [
              FadeInImage(
                image: NetworkImage(articles.urlToImage?? ""),
                placeholder: Image.asset("assets/icon_holder_img.png").image,
                width: double.maxFinite,fit: BoxFit.cover,height: 16.0.h,
              ),
              SizedBox(height: 2.0.h,),
              Text(articles.title,softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget setupAlertDialogContainer(List<ModelFilterValues> list, NewsDataProvider newsDataProvider,String type) {
  return Container(
    height: 60.0.h, // Change as per your requirement
    width: 75.0.w, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: RaisedButton(color: Colors.green,
            onPressed: (){
            if(type=="shortBy")
              newsDataProvider.addShortByForQuery(list[index].value);
              else
              newsDataProvider.searchByCategory(list[index].value,type);
            Navigator.pop(context);
            },
              child: Text(list[index].label,style: TextStyle(color: Colors.white,fontSize: 12.0.sp)),),
        );
      },
    ),
  );
}



