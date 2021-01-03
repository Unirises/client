part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoresLoaded extends StoreState {
  final List<Store> stores;
  const StoresLoaded(this.stores);

  @override
  List<Object> get props => [stores];
}
