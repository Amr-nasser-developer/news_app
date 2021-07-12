import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_udemy/layout/cubit/states.dart';
import 'package:news_app_udemy/modules/news_app/business/business.dart';
import 'package:news_app_udemy/modules/news_app/science/science.dart';
import 'package:news_app_udemy/modules/news_app/sittings/sitting.dart';
import 'package:news_app_udemy/modules/news_app/sport/sport.dart';
import 'package:news_app_udemy/shared/network/local/chash.dart';
import 'package:news_app_udemy/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit() : super(NewsIntial());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen= [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SittingScreen(),
  ];

  List<String> title= [
    'Business',
    'Sport',
    'Science',
    'Sitting'
  ];
  //

  void change(index, con){
    currentIndex = index;
    emit(NewsChangeBottomNav());
    if(index == 1) getSportsData(country: con ,bag: true );
    if(index == 2) getScienceData(country: con , bag: true);
  }


  List<dynamic> business = [];
  int currentPageBusiness = 1;
  var totalCurrentPageBusiness = 4;
  void getBusinessData({country , bool bag = false}){
    if(bag == true){
      currentPageBusiness = 1;
    }
    emit(getBusinessApiDataLoading());
    DioHelper.getData(
      url:'v2/top-headlines',
      query: {
        'page' : currentPageBusiness,
        'country': country,
        'category':'business',
        'apiKey':'b6e0b66d503c4ea8937592261a05f6f9',
      },).then((value){
      emit(getBusinessApiDataSuccess());
      business = value.data['articles'];
      currentPageBusiness++;
    }).catchError((e){
      print(e.toString());
      emit(getBusinessApiDataError('e'));
    });
  }
  void getBusinessDataMore({country}){
    emit(getBusinessApiDataMoreLoading());
    DioHelper.getData(
      url:'v2/top-headlines',
      query: {
        'page' : currentPageBusiness,
        'country': country,
        'category':'business',
        'apiKey':'b6e0b66d503c4ea8937592261a05f6f9',
      },).then((value){
      emit(getBusinessApiDataMoreSuccess());
      business.addAll(value.data['articles']);
      currentPageBusiness++;
    }).catchError((e){
      print(e.toString());
      emit(getBusinessApiDataMoreError('e'));
    });
  }

  List<dynamic> sports = [];
  int currentPageSport = 1;
  var totalCurrentPageSport = 4;
  void getSportsData({country , bool bag = false}){
    if(bag == true){
      currentPageSport = 1;
    }
    emit(getSportsApiDataLoading());
    DioHelper.getData(url:'v2/top-headlines',
      query: {
        'page' : currentPageSport,
        'country':country,
        'category':'sports',
        'apiKey':'b6e0b66d503c4ea8937592261a05f6f9',
      },).then((value){
      sports = value.data['articles'];
      emit(getSportsApiDataSuccess());
      currentPageSport++;
    }).catchError((e){
      print(e.toString());
      emit(getSportsApiDataError('e'));
    });
  }

  void getSportsDataMore({country}){
    emit(getSportsApiDataMoreLoading());
    DioHelper.getData(url:'v2/top-headlines',
      query: {
      'page' : currentPageSport,
        'country':country,
        'category':'sports',
        'apiKey':'b6e0b66d503c4ea8937592261a05f6f9',
      },).then((value){
      sports.addAll(value.data['articles']);
      emit(getSportsApiDataMoreSuccess());
      currentPageSport++;
    }).catchError((e){
      print(e.toString());
      emit(getSportsApiDataMoreError('e'));
    });
  }

  List<dynamic> science = [];
  int currentPageScience = 1;
  var totalCurrentPageScience = 4;
  void getScienceData({country , bool bag = false}){
    if(bag == true){
      currentPageScience = 1;
    }
    emit(getScienceApiDataLoading());
    DioHelper.getData(url:'v2/top-headlines',
      query: {
      'limit' : 120,
        'page' : currentPageScience,
        'country': country,
        'category':'science',
        'apiKey':'b6e0b66d503c4ea8937592261a05f6f9',
      },).then((value){
      science = value.data['articles'];
      emit(getScienceApiDataSuccess());
      currentPageScience++;
    }).catchError((e){
      print(e.toString());
      emit(getScienceApiDataError('e'));
    });
  }
  void getScienceDataMore({country}){
    emit(getScienceApiDataMoreLoading());
    DioHelper.getData(url:'v2/top-headlines',
      query: {
        'page' : currentPageScience,
        'country': country,
        'category':'science',
        'apiKey':'b6e0b66d503c4ea8937592261a05f6f9',
      },).then((value){
      science.addAll( value.data['articles']);
      emit(getScienceApiDataMoreSuccess());
      currentPageScience++;
    }).catchError((e){
      print(e.toString());
      emit(getScienceApiDataMoreError('e'));
    });
  }

  List<dynamic> search = [];
  var searchController = TextEditingController();
  void getSearchData(String value){
    emit(getSearchApiDataLoading());
    DioHelper.getData(
      url:'v2/everything',
      query: {
        'q': '$value',
        'apiKey':'7d6a33a2ef314659866694a645f0513a',
      },).then((value){
      search = value.data['articles'];
      emit(getSearchApiDataSuccess());
    }).catchError((e){
      print(e.toString());
      emit(getSearchApiDataError('e'));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(ChangeMode());
    } else
    {
      isDark = !isDark;
      CashHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeMode());
      });
    }
  }
}