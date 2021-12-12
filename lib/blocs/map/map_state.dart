part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  // Polylines
  final Map<String, Polyline> polylines;
  /*
    'mi_ruta: {
      id: polylineID Google,
      points: [ [lat,lng], [123123,123123], [123123,123123] ]
      width: 3
      color: black87
    },
  */


  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = true,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines
  }): polylines = polylines ?? const {};


  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines
  }) 
  => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
  );

  @override
  List<Object> get props => [ isMapInitialized, isFollowingUser, showMyRoute, polylines ];
  
}


