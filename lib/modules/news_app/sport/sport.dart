import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_udemy/layout/cubit/cubit.dart';
import 'package:news_app_udemy/layout/cubit/states.dart';
import 'package:news_app_udemy/shared/components/components.dart';
import 'package:news_app_udemy/shared/network/local/chash.dart';

class SportScreen extends StatelessWidget {
  String con = CashHelper.getData(key: 'country');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsState>(
      listener: (context, state){},
      builder: (context, state){
        // NewsCubit.get(context).getSportsData(country: con, bag: true);
        var sport = NewsCubit.get(context).sports;
        return Center(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: ConditionalBuilder(
                condition: state is! getSportsApiDataError,
                builder: (context)=> ConditionalBuilder(
                  condition: state is! getSportsApiDataLoading,
                  builder: (context)=> ConditionalBuilder(
                    condition: sport.length > 0,
                    builder: (context)=> SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index){
                                return BuildArticles(sport[index],context);
                              },
                              separatorBuilder: (context, index)=>  SizedBox(height: 10.0,),
                              itemCount: sport.length
                          ),

                          SizedBox(height: 20.0,),
                          if(state is! getSportsApiDataMoreLoading &&NewsCubit.get(context).currentPageSport <= NewsCubit.get(context).totalCurrentPageSport)
                            Container(
                              width: 120.0,
                              height: 40.0,
                              color: Colors.blueAccent,
                              child: FlatButton(
                                onPressed: (){
                                  if(NewsCubit.get(context).currentPageSport <= NewsCubit.get(context).totalCurrentPageSport)
                                    NewsCubit.get(context).getSportsDataMore(country: con);
                                },
                                child: Row(
                                  children: [
                                    Text('Load More'  ),
                                    SizedBox(width: 5.0,),
                                    Icon(Icons.arrow_downward_sharp, size: 16.0)
                                  ],
                                ),
                              ),
                            ),
                          if(state is getSportsApiDataMoreLoading)
                            CircularProgressIndicator(color: Colors.blueAccent,),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    ),
                    fallback: (context)=> Center(child: Text('No News Founded For This Country'),),
                  ),
                  fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.blue,),) ,
                ) ,
                fallback: (context)=> Center(child: Row(children: [Text('No Internet'), SizedBox(width: 15.0,) , Icon(Icons.wifi_off_sharp)],)) ,
              ),
            ),
          ),
        );
      },
    );
  }
}
