// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltStop> _$builtStopSerializer = new _$BuiltStopSerializer();

class _$BuiltStopSerializer implements StructuredSerializer<BuiltStop> {
  @override
  final Iterable<Type> types = const [BuiltStop, _$BuiltStop];
  @override
  final String wireName = 'BuiltStop';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltStop object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.houseDetails != null) {
      result
        ..add('houseDetails')
        ..add(serializers.serialize(object.houseDetails,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.phone != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.location != null) {
      result
        ..add('location')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(Location)));
    }
    if (object.address != null) {
      result
        ..add('address')
        ..add(serializers.serialize(object.address,
            specifiedType: const FullType(String)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.weight != null) {
      result
        ..add('weight')
        ..add(serializers.serialize(object.weight,
            specifiedType: const FullType(num)));
    }
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(String)));
    }
    if (object.isCashOnDelivery != null) {
      result
        ..add('isCashOnDelivery')
        ..add(serializers.serialize(object.isCashOnDelivery,
            specifiedType: const FullType(bool)));
    }
    if (object.distance != null) {
      result
        ..add('distance')
        ..add(serializers.serialize(object.distance,
            specifiedType: const FullType(num)));
    }
    if (object.price != null) {
      result
        ..add('price')
        ..add(serializers.serialize(object.price,
            specifiedType: const FullType(num)));
    }
    if (object.startLocation != null) {
      result
        ..add('startLocation')
        ..add(serializers.serialize(object.startLocation,
            specifiedType: const FullType(Location)));
    }
    if (object.endLocation != null) {
      result
        ..add('endLocation')
        ..add(serializers.serialize(object.endLocation,
            specifiedType: const FullType(Location)));
    }
    if (object.startAddress != null) {
      result
        ..add('startAddress')
        ..add(serializers.serialize(object.startAddress,
            specifiedType: const FullType(String)));
    }
    if (object.endAddress != null) {
      result
        ..add('endAddress')
        ..add(serializers.serialize(object.endAddress,
            specifiedType: const FullType(String)));
    }
    if (object.duration != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(object.duration,
            specifiedType: const FullType(DistanceDuration)));
    }
    return result;
  }

  @override
  BuiltStop deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltStopBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'houseDetails':
          result.houseDetails = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location)) as Location);
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'weight':
          result.weight = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isCashOnDelivery':
          result.isCashOnDelivery = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'distance':
          result.distance = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'startLocation':
          result.startLocation.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location)) as Location);
          break;
        case 'endLocation':
          result.endLocation.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location)) as Location);
          break;
        case 'startAddress':
          result.startAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'endAddress':
          result.endAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'duration':
          result.duration.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DistanceDuration))
              as DistanceDuration);
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltStop extends BuiltStop {
  @override
  final String houseDetails;
  @override
  final String name;
  @override
  final String phone;
  @override
  final Location location;
  @override
  final String address;
  @override
  final String id;
  @override
  final num weight;
  @override
  final String type;
  @override
  final bool isCashOnDelivery;
  @override
  final num distance;
  @override
  final num price;
  @override
  final Location startLocation;
  @override
  final Location endLocation;
  @override
  final String startAddress;
  @override
  final String endAddress;
  @override
  final DistanceDuration duration;

  factory _$BuiltStop([void Function(BuiltStopBuilder) updates]) =>
      (new BuiltStopBuilder()..update(updates)).build();

  _$BuiltStop._(
      {this.houseDetails,
      this.name,
      this.phone,
      this.location,
      this.address,
      this.id,
      this.weight,
      this.type,
      this.isCashOnDelivery,
      this.distance,
      this.price,
      this.startLocation,
      this.endLocation,
      this.startAddress,
      this.endAddress,
      this.duration})
      : super._();

  @override
  BuiltStop rebuild(void Function(BuiltStopBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltStopBuilder toBuilder() => new BuiltStopBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltStop &&
        houseDetails == other.houseDetails &&
        name == other.name &&
        phone == other.phone &&
        location == other.location &&
        address == other.address &&
        id == other.id &&
        weight == other.weight &&
        type == other.type &&
        isCashOnDelivery == other.isCashOnDelivery &&
        distance == other.distance &&
        price == other.price &&
        startLocation == other.startLocation &&
        endLocation == other.endLocation &&
        startAddress == other.startAddress &&
        endAddress == other.endAddress &&
        duration == other.duration;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    houseDetails
                                                                        .hashCode),
                                                                name.hashCode),
                                                            phone.hashCode),
                                                        location.hashCode),
                                                    address.hashCode),
                                                id.hashCode),
                                            weight.hashCode),
                                        type.hashCode),
                                    isCashOnDelivery.hashCode),
                                distance.hashCode),
                            price.hashCode),
                        startLocation.hashCode),
                    endLocation.hashCode),
                startAddress.hashCode),
            endAddress.hashCode),
        duration.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltStop')
          ..add('houseDetails', houseDetails)
          ..add('name', name)
          ..add('phone', phone)
          ..add('location', location)
          ..add('address', address)
          ..add('id', id)
          ..add('weight', weight)
          ..add('type', type)
          ..add('isCashOnDelivery', isCashOnDelivery)
          ..add('distance', distance)
          ..add('price', price)
          ..add('startLocation', startLocation)
          ..add('endLocation', endLocation)
          ..add('startAddress', startAddress)
          ..add('endAddress', endAddress)
          ..add('duration', duration))
        .toString();
  }
}

class BuiltStopBuilder implements Builder<BuiltStop, BuiltStopBuilder> {
  _$BuiltStop _$v;

  String _houseDetails;
  String get houseDetails => _$this._houseDetails;
  set houseDetails(String houseDetails) => _$this._houseDetails = houseDetails;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  LocationBuilder _location;
  LocationBuilder get location => _$this._location ??= new LocationBuilder();
  set location(LocationBuilder location) => _$this._location = location;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  num _weight;
  num get weight => _$this._weight;
  set weight(num weight) => _$this._weight = weight;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  bool _isCashOnDelivery;
  bool get isCashOnDelivery => _$this._isCashOnDelivery;
  set isCashOnDelivery(bool isCashOnDelivery) =>
      _$this._isCashOnDelivery = isCashOnDelivery;

  num _distance;
  num get distance => _$this._distance;
  set distance(num distance) => _$this._distance = distance;

  num _price;
  num get price => _$this._price;
  set price(num price) => _$this._price = price;

  LocationBuilder _startLocation;
  LocationBuilder get startLocation =>
      _$this._startLocation ??= new LocationBuilder();
  set startLocation(LocationBuilder startLocation) =>
      _$this._startLocation = startLocation;

  LocationBuilder _endLocation;
  LocationBuilder get endLocation =>
      _$this._endLocation ??= new LocationBuilder();
  set endLocation(LocationBuilder endLocation) =>
      _$this._endLocation = endLocation;

  String _startAddress;
  String get startAddress => _$this._startAddress;
  set startAddress(String startAddress) => _$this._startAddress = startAddress;

  String _endAddress;
  String get endAddress => _$this._endAddress;
  set endAddress(String endAddress) => _$this._endAddress = endAddress;

  DistanceDurationBuilder _duration;
  DistanceDurationBuilder get duration =>
      _$this._duration ??= new DistanceDurationBuilder();
  set duration(DistanceDurationBuilder duration) => _$this._duration = duration;

  BuiltStopBuilder();

  BuiltStopBuilder get _$this {
    if (_$v != null) {
      _houseDetails = _$v.houseDetails;
      _name = _$v.name;
      _phone = _$v.phone;
      _location = _$v.location?.toBuilder();
      _address = _$v.address;
      _id = _$v.id;
      _weight = _$v.weight;
      _type = _$v.type;
      _isCashOnDelivery = _$v.isCashOnDelivery;
      _distance = _$v.distance;
      _price = _$v.price;
      _startLocation = _$v.startLocation?.toBuilder();
      _endLocation = _$v.endLocation?.toBuilder();
      _startAddress = _$v.startAddress;
      _endAddress = _$v.endAddress;
      _duration = _$v.duration?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltStop other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltStop;
  }

  @override
  void update(void Function(BuiltStopBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltStop build() {
    _$BuiltStop _$result;
    try {
      _$result = _$v ??
          new _$BuiltStop._(
              houseDetails: houseDetails,
              name: name,
              phone: phone,
              location: _location?.build(),
              address: address,
              id: id,
              weight: weight,
              type: type,
              isCashOnDelivery: isCashOnDelivery,
              distance: distance,
              price: price,
              startLocation: _startLocation?.build(),
              endLocation: _endLocation?.build(),
              startAddress: startAddress,
              endAddress: endAddress,
              duration: _duration?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();

        _$failedField = 'startLocation';
        _startLocation?.build();
        _$failedField = 'endLocation';
        _endLocation?.build();

        _$failedField = 'duration';
        _duration?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BuiltStop', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
