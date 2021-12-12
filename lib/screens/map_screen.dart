import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
   
   const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();

  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }


   @override
   Widget build(BuildContext context) {
   return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          
          if ( state.lastKnownLocation == null ) return const Center( child: Text('Espere por favor...'));


          return SingleChildScrollView(
            child: Stack(
              children: [
                MapView( initialLocation: state.lastKnownLocation! ),
          
                // TODO: botones...
                
              ],
            ),
          );

        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const[
          BtnCurrentLocation()
        ],
      ),

   );
   }
}