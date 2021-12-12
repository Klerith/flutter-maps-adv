part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool followUser;

  const MapState({
    this.isMapInitialized = false, 
    this.followUser = false
  });


  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
  }) 
  => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    followUser: followUser ?? this.followUser,
  );

  @override
  List<Object> get props => [ isMapInitialized, followUser];
  
}


