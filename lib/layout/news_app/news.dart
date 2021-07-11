import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_udemy/layout/news_app/cubit/cubit.dart';
import 'package:news_app_udemy/layout/news_app/cubit/states.dart';
import 'package:news_app_udemy/modules/news_app/search/search.dart';
import 'package:news_app_udemy/shared/network/local/chash.dart';

class NewsScreen extends StatelessWidget {
   String? country;
   String? countryName;
  String name = CashHelper.getData(key: 'countryName');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            centerTitle: true,
            leadingWidth: 120.0,
            leading:
            FlatButton(
              color: NewsCubit.get(context).isDark ? HexColor('333739'): Colors.white,
              child: Row(
                children: [
                  Text(
                      (name != null )  ? '$name' : 'Egypt',
                    style: TextStyle(color: NewsCubit.get(context).isDark ? Colors.white : HexColor('333739'), fontSize: 14),
                  ),
                  SizedBox(width: 0.2,),
                  Icon(Icons.arrow_drop_down_sharp, size: 14, color: NewsCubit.get(context).isDark ? Colors.white : Colors.black,)
                ],
              ) ,
              onPressed: (){
                print('$name');
                showCountryPicker(
                  context: context,
                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                  exclude: <String>[
                    'KN',
                    'MF',
                    'AF',
                    'AX',
                  ],
                  //Optional. Shows phone code before the country name.
                  showPhoneCode: false,
                  onSelect: (Country countries) {
                    country = countries.countryCode;
                    countryName = countries.name;
                    NewsCubit.get(context).getBusinessData(country: country ,bag: true);
                    CashHelper.setData(key: 'country', value: country).then((value){
                      NewsCubit.get(context).getSportsData(country: country );
                      NewsCubit.get(context).getScienceData(country: country);
                    });
                    CashHelper.setData(key: 'countryName', value: countryName);



                  },
                  // Optional. Sets the theme for the country list picker.
                  countryListTheme: CountryListThemeData(
                    // Optional. Sets the border radius for the bottomsheet.
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    // Optional. Styles the search field.
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                icon: Icon(Icons.brightness_3_sharp),
                onPressed: () {
                   NewsCubit.get(context).changeAppMode();
                },
              )
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business_center_sharp), label: 'Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_bar), label: 'Sport'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science), label: 'Science'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Setting'),
            ],
            onTap: (index) {
              cubit.change(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
