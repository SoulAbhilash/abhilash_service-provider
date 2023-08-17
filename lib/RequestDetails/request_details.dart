
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'mapbox_searchmodel.dart';
import 'model.dart';
import 'provider.dart';



class RequestDetails extends ConsumerStatefulWidget {
  String ticketID;
   RequestDetails({super.key,required this.ticketID});

  @override
  ConsumerState<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends ConsumerState<RequestDetails> {

  double parseDouble(dynamic value) {
    try {
      if (value is String) {
        return double.parse(value);
      } else if (value is double) {
        return value;
      } else {
        return 0.0;
      }
    } catch (e) {
      // return null if double.parse fails
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {

    final Requesteduserdetails = ref.watch(getUserDetails(widget.ticketID));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Request Details',style: GoogleFonts.vesperLibre(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Requesteduserdetails.when(
            error: (err,s)=> Center(
              child: Text("the error is ${err.toString()}"),
            ),
            loading: ()=>const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            ),
            data: (getUserDetails){

              /*if(getUserDetails.success==true) {
                final placename = getPlaceName(getUserDetails.ticket.customerId.currentLocation.latitude,
                    getUserDetails.ticket.customerId.currentLocation.longitude);

                print('------------>$placename<--------------');
              }*/

              if(getUserDetails.success==true){


                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage('${getUserDetails.ticket.customerId.photo}'
                            )
                        )
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(16),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${getUserDetails.ticket.customerId.firstName} ${getUserDetails.ticket.customerId.lastName}',style: GoogleFonts.vesperLibre(fontSize: 18,fontWeight: FontWeight.w700),
                        ),
                        /*Text(
                          'Location: ${getUserDetails.ticket.customerId.currentLocation.longitude}, '
                              '${getUserDetails.ticket.customerId.currentLocation.latitude}',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),*/
                        // to get the location  in text form
                        FutureBuilder(
                          future: convertLL(LatLng(parseDouble(getUserDetails.ticket.customerId.currentLocation.latitude),
                              parseDouble(getUserDetails.ticket.customerId.currentLocation.longitude))),
                          
                          //future: convertLL(LatLng(18.65176920825535, 73.77090265327057)),
                            builder:(context, snapshot) {
                            print('---8-->${snapshot.data}-8---');
                             var data =snapshot.data;
                             if (data == null) {
                               print('null');
                               return Align(
                                   alignment: Alignment.centerLeft,
                                   child: Text(
                                     'Not Mentioned',
                                     style: GoogleFonts.vesperLibre(fontSize: 16,),
                                     overflow: TextOverflow.visible,
                                   ));
                             }
                             else{
                               print('null');
                               var dataLength = data.length;
                               if (dataLength == 0) {
                                 print('-----${data.length}---');
                                 return Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       'Location: Not Mentioned',
                                       style: GoogleFonts.vesperLibre(fontSize: 16,),
                                       overflow: TextOverflow.visible,
                                     ));
                               } else {
                                 print('${data[0].placeName}');
                                 return Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text('Location: ${data[0].placeName}',
                                         textScaleFactor: 1, maxLines: 4, overflow: TextOverflow.ellipsis,
                                         style:GoogleFonts.vesperLibre(fontSize: 16,)));
                               }
                             }
                            },
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Vehicle Model: ${getUserDetails.ticket.vehicleData.vehicleModel}',style: GoogleFonts.vesperLibre(fontSize: 16,),
                        ),
                        Text(
                          'Vehicle Number: ${getUserDetails.ticket.vehicleData.vehicleNo}',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),
                        Text(
                          'Issue:',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Other Details: VehicleBrand ${getUserDetails.ticket.vehicleData.vehicleBrand} & Fuel ${getUserDetails.ticket.vehicleData.vehicleFuel}',style: GoogleFonts.vesperLibre(fontSize: 18,fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Help Center Number: 9098630635',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),
                        Text(
                          'Ticket ID: ${getUserDetails.ticket.id}',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),
                        Text(
                          'Ticket Created Time: ${getUserDetails.ticket.createdAt}',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),
                        Text(
                          'Ticket Updated Time: ${getUserDetails.ticket.updatedAt}',style: GoogleFonts.vesperLibre(fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: (){

                                },
                                child: Text('Accept'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    )
                                )
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Center(
                                            child: Text('Reject',style: GoogleFonts.vesperLibre())),
                                        content: Container(
                                            height: 20,
                                            //width: 250,
                                            child: Center(
                                                child: Text('Are You Sure',style: GoogleFonts.vesperLibre()))),
                                        actions: [
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(onPressed: (){

                                                //TODO navigate to respective page

                                              }, child: Text('YES',style: GoogleFonts.vesperLibre(fontSize: 16),)),
                                              TextButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: Text('NO',style: GoogleFonts.vesperLibre(fontSize: 16),)),
                                            ],
                                          )
                                        ],
                                      )
                                  );
                                },
                                child: Text('Reject'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    )
                                )
                            )
                          ],
                        )
                      ],
                    ),)
                ],
              );
              }

      }
        ),
      ),
    );
  }

   /*getPlaceName(latitude,longitude) async {
    *//*var myPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);*//*
     print('$latitude ----- $longitude');

    List<SearchPlaces?> result = await convertLL(LatLng(
        latitude,longitude));

    print('-----|-------->result<------------|-------');
    return result;
  }*/
}
