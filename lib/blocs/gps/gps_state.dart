part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;
  
  const GpsState({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted
  });

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted
  );
  
  @override
  List<Object> get props => [ isGpsEnabled, isGpsPermissionGranted ];

  @override
  String toString() => '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';

}

