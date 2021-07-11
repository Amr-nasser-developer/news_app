import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_udemy/layout/news_app/cubit/cubit.dart';
import 'package:news_app_udemy/layout/news_app/cubit/states.dart';
import 'package:news_app_udemy/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var search = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'inputData';
                      }
                        return null;

                    },
                    controller: NewsCubit.get(context).searchController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value){},
                    onChanged: (value) {
                      NewsCubit.get(context).getSearchData(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                        return BuildArticles(search[index],context);
                        },
                      separatorBuilder: (context, index)=>  SizedBox(height: 10.0,),
                      itemCount: search.length
                  ),
                ),
              ],
            ),
          );
        });
  }
}
