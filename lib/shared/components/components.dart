import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_udemy/modules/news_app/webview/webview.dart';

Widget BuildArticles(article,context){
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewScreen('${article['url']}')));
      },
      child: Container(
        color: Colors.white,
        width: width *1,
        height: height*0.25,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(

            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${article['title']}',style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)
                        ,maxLines: 2,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 10.0,),
                      Expanded(child: ('${article['description']}' !=  null )? Text('${article['description']}',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        maxLines: 3,overflow: TextOverflow.ellipsis,) : Text('')),
                      Text('${article['publishedAt']}')
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15.0,),
              Container(
                  height: height*0.30,
                  width: 180,
                  child: ('${article['urlToImage']}' == null )?
                  Container(color: Colors.red.shade900,) :
                  Image(image:NetworkImage('${article['urlToImage']}'),fit: BoxFit.fill,)
              ),

            ],
          ),
        ),
      ),
    ),
  ) ;
}
Widget defaultMaterialButton({bool? upBar, String? text, var function}){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.indigo,
    ),
    child: MaterialButton(
        child: Text(
          upBar! ? text!.toUpperCase() : text!.toLowerCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 15.0),
        ),
        onPressed: function
    ),
  );
}

