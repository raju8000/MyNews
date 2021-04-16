import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news_task/Utils/Utils.dart';
import 'package:my_news_task/model/ModelNewsData.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  static const String pageName= "newsDetail";
  final Articles articles;
  NewsDetail({this.articles});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("News"),centerTitle: true,backgroundColor: Colors.green,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w,vertical: 2.0.h),
        child: SingleChildScrollView(
          child: Column(children: [
            FadeInImage(
              image: NetworkImage(articles.urlToImage!=null? articles.urlToImage:"https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png"),
              placeholder: Image.asset("assets/icon_holder_img.png").image,
              width: double.maxFinite,fit: BoxFit.cover,height: 40.0.h,
            ),
            SizedBox(height: 1.0.h,),
            Text("Author: "+articles.author?? "No Author", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0.sp),),
            SizedBox(height: 1.0.h,),
            Text(articles.title??"",softWrap: true,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.0.sp),
            ),
            SizedBox(height: 1.0.h,),
            Text(articles.description??"",softWrap: true,
              style: TextStyle(fontSize: 12.0.sp),
            ),

            SizedBox(height: 3.0.h,),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 6.0.h),
              child: Align( alignment: Alignment.center,
                  child: Container(height:50,width: double.infinity,
                      child: RaisedButton(color: Colors.green,onPressed: () async {
                        var url = articles.url;
                        if (await canLaunch(url) != null) {
                        await launch(url);
                        }
                        else
                        Utils.showMessageDialog(context, "Unable to open browser");
                      },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Align(alignment:Alignment.center,child: Text("Open in browser",style: TextStyle(color: Colors.white,fontSize: 19),)),))),
            ),

          ],),
        ),
      ),
    ));
  }
}

