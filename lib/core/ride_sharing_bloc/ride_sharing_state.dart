part of 'ride_sharing_bloc.dart';

abstract class RideSharingState extends Equatable {
  const RideSharingState();
}

class RideSharingInitial extends RideSharingState {
  @override
  List<Object> get props => [];
}

class RideSharingLoaded extends RideSharingState {
  final Request request;
  const RideSharingLoaded(this.request);

  @override
  List<Object> get props => [request];
}
