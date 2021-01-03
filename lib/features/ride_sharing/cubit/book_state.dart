part of 'book_cubit.dart';

class BookState extends Equatable {
  const BookState({
    this.pickupPoint = const Pickup.pure(),
    this.dropoffPoint = const Dropoff.pure(),
    this.transportation = const Transportation.pure(),
    this.payment = const Payment.pure(),
    this.status = FormzStatus.pure,
    this.total = 0,
    this.nonDiscountedTotal = 0,
    this.distance = 0,
    this.duration = 0,
    this.encodedPolyline = '',
    this.bounds = const {},
    this.isParcel = false,
    this.data,
  });

  final Pickup pickupPoint;
  final Dropoff dropoffPoint;
  final Transportation transportation;
  final Payment payment;
  final FormzStatus status;
  final num total;
  final num nonDiscountedTotal;
  final num distance;
  final num duration;
  final String encodedPolyline;
  final Map<String, dynamic> bounds;
  final bool isParcel;
  final dynamic data;

  @override
  List<Object> get props => [
        pickupPoint,
        dropoffPoint,
        transportation,
        payment,
        status,
        total,
        nonDiscountedTotal,
        distance,
        duration,
        encodedPolyline,
        bounds,
        isParcel,
        data,
      ];

  BookState copyWith({
    Pickup pickupPoint,
    Dropoff dropoffPoint,
    Transportation transportation,
    Payment payment,
    FormzStatus status,
    num total,
    num nonDiscountedTotal,
    num distance,
    num duration,
    String encodedPolyline,
    Map<String, dynamic> bounds,
    bool isParcel,
    dynamic data,
  }) {
    return BookState(
      pickupPoint: pickupPoint ?? this.pickupPoint,
      dropoffPoint: dropoffPoint ?? this.dropoffPoint,
      transportation: transportation ?? this.transportation,
      payment: payment ?? this.payment,
      status: status ?? this.status,
      total: total ?? this.total,
      nonDiscountedTotal: nonDiscountedTotal ?? this.nonDiscountedTotal,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      encodedPolyline: encodedPolyline ?? this.encodedPolyline,
      bounds: bounds ?? this.bounds,
      isParcel: isParcel ?? this.isParcel,
      data: data ?? this.data,
    );
  }
}
