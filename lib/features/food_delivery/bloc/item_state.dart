part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoadingInProgress extends ItemState {}

class ItemLoaded extends ItemState {
  final ClassificationListing item;

  ItemLoaded([this.item]);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'ItemLoaded { item: $item }';

  ItemLoaded copyWith({
    ClassificationListing item,
  }) =>
      ItemLoaded(
        item ?? this.item,
      );
}

class ItemLoadFailed extends ItemState {}
