import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? locationStateSubscription;
  
  MapBloc({
    required this.locationBloc
  }) : super( const MapState() ) {
    
    on<OnMapInitialzedEvent>( _onInitMap );
    on<OnStartFollowingUserEvent>( _onStartFollowingUser );
    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith( isFollowingUser: false) ));
    on<UpdateUserPolylineEvent>( _onPolylineNewPoint );
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute )) );

    locationStateSubscription = locationBloc.stream.listen(( locationState ) {

      if(  locationState.lastKnownLocation != null ) {
        add( UpdateUserPolylineEvent( locationState.myLocationHistory ) );
      }

      if ( !state.isFollowingUser ) return;
      if( locationState.lastKnownLocation == null ) return;

      moveCamera( locationState.lastKnownLocation! );

    });

  }


  void _onInitMap( OnMapInitialzedEvent event, Emitter<MapState> emit ) {

    _mapController = event.controller;
    _mapController!.setMapStyle( jsonEncode( uberMapTheme ));

    emit( state.copyWith( isMapInitialized: true ) );

  }

  void _onStartFollowingUser(OnStartFollowingUserEvent event, Emitter<MapState> emit) {

    emit( state.copyWith( isFollowingUser: true ) );

    if( locationBloc.state.lastKnownLocation == null ) return;
    moveCamera(locationBloc.state.lastKnownLocation!);

  }

  void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit) {

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;

    emit( state.copyWith( polylines: currentPolylines ) );

  }


  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera(cameraUpdate);
  }

    
  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
