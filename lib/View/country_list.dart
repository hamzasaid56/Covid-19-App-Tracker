import 'package:flutter/material.dart';
import 'package:practice_covid_19/Models/Services/stats_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices _statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding:const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "Search country by name",
              ),
            ),
          Expanded(
            child: FutureBuilder(
                future: _statsServices.fetchCountryStatsApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                 if(!snapshot.hasData){
                   return Shimmer.fromColors(
                       baseColor: Colors.grey.shade700,
                       highlightColor: Colors.grey.shade100,
                     child: ListView.builder(
                       itemCount: 5,
                         itemBuilder: (context, index){
                         return Column(
                           children: [
                             ListTile(
                               leading: Container(width : 50,height: 50,color: Colors.white,),
                               title: Container(width : 90,height: 10,color: Colors.white,),
                               subtitle:  Container(width : 90,height: 10,color: Colors.white,),
                             ),
                           ],
                         );
                         }),
                   );
                 }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                      String countryName = snapshot.data![index]['country'];
                      if(_searchController.text.isEmpty){
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                width: 50,
                                height: 50,
                                image: NetworkImage(snapshot.data[index]['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country'].toString()),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          ],
                        );
                      }
                      else if(countryName.toLowerCase().contains(_searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                width: 50,
                                height: 50,
                                image: NetworkImage(snapshot.data[index]['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country'].toString()),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          ],
                        );
                      }
                      else{
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                width: 50,
                                height: 50,
                                image: NetworkImage(snapshot.data[index]['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country'].toString()),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          ],
                        );
                      }

                      });
                }),
          )
          ],
        ),
      ),
    );
  }
}
