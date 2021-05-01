part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoadingInProgress extends ItemState {}

class ItemLoaded extends ItemState {
  final ClassificationListing? item;
  final num? additionalPrice;

  ItemLoaded([this.item, this.additionalPrice]);

  @override
  List<Object?> get props => [item, additionalPrice];

  @override
  String toString() => 'ItemLoaded { item: $item, additionalPrice: $additionalPrice }';

  ItemLoaded copyWith({ClassificationListing? item, num? additionalPrice}) => ItemLoaded(
        item ?? this.item,
        additionalPrice ?? this.additionalPrice,
      );
}

class ItemLoadFailed extends ItemState {}
