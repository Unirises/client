part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  final Pickup pickupPoint;
  final Store store;
  final Transportation transportation;
  final Payment payment;
  final FormzStatus status;
  final num distance;
  final num duration;
  final String encodedPolyline;
  final Map<String, dynamic> bounds;
  final dynamic data;
  final List<Item> items;
  final num subtotal;
  final num fee;
  final num nonDiscountedFee;
  final bool isInitial;

  const CheckoutState({
    this.pickupPoint = const Pickup.pure(),
    this.store = null,
    this.transportation = const Transportation.pure(),
    this.payment = const Payment.pure(),
    this.status = FormzStatus.pure,
    this.distance = 0,
    this.duration = 0,
    this.encodedPolyline = '',
    this.bounds = const {},
    this.data,
    this.items = const [],
    this.subtotal = 0,
    this.fee = 0,
    this.nonDiscountedFee = 0,
    this.isInitial = true,
  });

  @override
  List<Object> get props => [
        pickupPoint,
        store,
        transportation,
        payment,
        status,
        distance,
        duration,
        encodedPolyline,
        bounds,
        data,
        items,
        subtotal,
        fee,
        isInitial,
        nonDiscountedFee,
      ];

  CheckoutState copyWith({
    Pickup pickupPoint,
    Store store,
    Transportation transportation,
    Payment payment,
    FormzStatus status,
    num distance,
    num duration,
    String encodedPolyline,
    Map<String, dynamic> bounds,
    dynamic data,
    List<Item> items,
    num subtotal,
    num fee,
    num nonDiscountedFee,
    bool isInitial,
  }) {
    return CheckoutState(
      pickupPoint: pickupPoint ?? this.pickupPoint,
      store: store ?? this.store,
      transportation: transportation ?? this.transportation,
      payment: payment ?? this.payment,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      encodedPolyline: encodedPolyline ?? this.encodedPolyline,
      bounds: bounds ?? this.bounds,
      data: data ?? this.data,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      fee: fee ?? this.fee,
      nonDiscountedFee: nonDiscountedFee ?? this.nonDiscountedFee,
      isInitial: isInitial ?? this.isInitial,
    );
  }
}
