part of 'merchant_bloc.dart';

abstract class MerchantState extends Equatable {
  const MerchantState();

  @override
  List<Object> get props => [];
}

class MerchantInitial extends MerchantState {}

class MerchantLoading extends MerchantState {}

class MerchantLoadSuccess extends MerchantState {
  final List<Merchant> merchants;

  MerchantLoadSuccess(this.merchants);

  @override
  List<Object> get props => [merchants];
}

class MerchantLoadFailure extends MerchantState {}
