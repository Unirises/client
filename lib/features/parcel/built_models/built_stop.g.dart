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
  Iterable<Object?> serialize(Serializers serializers, BuiltStop object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.houseDetails;
    if (value != null) {
      result
        ..add('houseDetails')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Location)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.weight;
    if (value != null) {
      result
        ..add('weight')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isCashOnDelivery;
    if (value != null) {
      result
        ..add('isCashOnDelivery')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.distance;
    if (value != null) {
      result
        ..add('distance')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.startLocation;
    if (value != null) {
      result
        ..add('startLocation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Location)));
    }
    value = object.endLocation;
    if (value != null) {
      result
        ..add('endLocation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Location)));
    }
    value = object.startAddress;
    if (value != null) {
      result
        ..add('startAddress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.endAddress;
    if (value != null) {
      result
        ..add('endAddress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.duration;
    if (value != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DistanceDuration)));
    }
    value = object.specialNote;
    if (value != null) {
      result
        ..add('specialNote')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.receiverWillShoulder;
    if (value != null) {
      result
        ..add('receiverWillShoulder')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.itemPrice;
    if (value != null) {
      result
        ..add('itemPrice')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    return result;
  }

  @override
  BuiltStop deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltStopBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
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
              specifiedType: const FullType(Location))! as Location);
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
              specifiedType: const FullType(Location))! as Location);
          break;
        case 'endLocation':
          result.endLocation.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location))! as Location);
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
                  specifiedType: const FullType(DistanceDuration))!
              as DistanceDuration);
          break;
        case 'specialNote':
          result.specialNote = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'receiverWillShoulder':
          result.receiverWillShoulder = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'itemPrice':
          result.itemPrice = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltStop extends BuiltStop {
  @override
  final String? houseDetails;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final Location? location;
  @override
  final String? address;
  @override
  final String? id;
  @override
  final num? weight;
  @override
  final String? type;
  @override
  final bool? isCashOnDelivery;
  @override
  final num? distance;
  @override
  final num? price;
  @override
  final Location? startLocation;
  @override
  final Location? endLocation;
  @override
  final String? startAddress;
  @override
  final String? endAddress;
  @override
  final DistanceDuration? duration;
  @override
  final String? specialNote;
  @override
  final bool? receiverWillShoulder;
  @override
  final num? itemPrice;

  factory _$BuiltStop([void Function(BuiltStopBuilder)? updates]) =>
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
      this.duration,
      this.specialNote,
      this.receiverWillShoulder,
      this.itemPrice})
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
        duration == other.duration &&
        specialNote == other.specialNote &&
        receiverWillShoulder == other.receiverWillShoulder &&
        itemPrice == other.itemPrice;
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
                                                                    $jc(
                                                                        $jc(
                                                                            $jc(
                                                                                0,
                                                                                houseDetails
                                                                                    .hashCode),
                                                                            name
                                                                                .hashCode),
                                                                        phone
                                                                            .hashCode),
                                                                    location
                                                                        .hashCode),
                                                                address
                                                                    .hashCode),
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
                    duration.hashCode),
                specialNote.hashCode),
            receiverWillShoulder.hashCode),
        itemPrice.hashCode));
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
          ..add('duration', duration)
          ..add('specialNote', specialNote)
          ..add('receiverWillShoulder', receiverWillShoulder)
          ..add('itemPrice', itemPrice))
        .toString();
  }
}

class BuiltStopBuilder implements Builder<BuiltStop, BuiltStopBuilder> {
  _$BuiltStop? _$v;

  String? _houseDetails;
  String? get houseDetails => _$this._houseDetails;
  set houseDetails(String? houseDetails) => _$this._houseDetails = houseDetails;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  LocationBuilder? _location;
  LocationBuilder get location => _$this._location ??= new LocationBuilder();
  set location(LocationBuilder? location) => _$this._location = location;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  num? _weight;
  num? get weight => _$this._weight;
  set weight(num? weight) => _$this._weight = weight;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  bool? _isCashOnDelivery;
  bool? get isCashOnDelivery => _$this._isCashOnDelivery;
  set isCashOnDelivery(bool? isCashOnDelivery) =>
      _$this._isCashOnDelivery = isCashOnDelivery;

  num? _distance;
  num? get distance => _$this._distance;
  set distance(num? distance) => _$this._distance = distance;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  LocationBuilder? _startLocation;
  LocationBuilder get startLocation =>
      _$this._startLocation ??= new LocationBuilder();
  set startLocation(LocationBuilder? startLocation) =>
      _$this._startLocation = startLocation;

  LocationBuilder? _endLocation;
  LocationBuilder get endLocation =>
      _$this._endLocation ??= new LocationBuilder();
  set endLocation(LocationBuilder? endLocation) =>
      _$this._endLocation = endLocation;

  String? _startAddress;
  String? get startAddress => _$this._startAddress;
  set startAddress(String? startAddress) => _$this._startAddress = startAddress;

  String? _endAddress;
  String? get endAddress => _$this._endAddress;
  set endAddress(String? endAddress) => _$this._endAddress = endAddress;

  DistanceDurationBuilder? _duration;
  DistanceDurationBuilder get duration =>
      _$this._duration ??= new DistanceDurationBuilder();
  set duration(DistanceDurationBuilder? duration) =>
      _$this._duration = duration;

  String? _specialNote;
  String? get specialNote => _$this._specialNote;
  set specialNote(String? specialNote) => _$this._specialNote = specialNote;

  bool? _receiverWillShoulder;
  bool? get receiverWillShoulder => _$this._receiverWillShoulder;
  set receiverWillShoulder(bool? receiverWillShoulder) =>
      _$this._receiverWillShoulder = receiverWillShoulder;

  num? _itemPrice;
  num? get itemPrice => _$this._itemPrice;
  set itemPrice(num? itemPrice) => _$this._itemPrice = itemPrice;

  BuiltStopBuilder();

  BuiltStopBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _houseDetails = $v.houseDetails;
      _name = $v.name;
      _phone = $v.phone;
      _location = $v.location?.toBuilder();
      _address = $v.address;
      _id = $v.id;
      _weight = $v.weight;
      _type = $v.type;
      _isCashOnDelivery = $v.isCashOnDelivery;
      _distance = $v.distance;
      _price = $v.price;
      _startLocation = $v.startLocation?.toBuilder();
      _endLocation = $v.endLocation?.toBuilder();
      _startAddress = $v.startAddress;
      _endAddress = $v.endAddress;
      _duration = $v.duration?.toBuilder();
      _specialNote = $v.specialNote;
      _receiverWillShoulder = $v.receiverWillShoulder;
      _itemPrice = $v.itemPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltStop other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltStop;
  }

  @override
  void update(void Function(BuiltStopBuilder)? updates) {
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
              duration: _duration?.build(),
              specialNote: specialNote,
              receiverWillShoulder: receiverWillShoulder,
              itemPrice: itemPrice);
    } catch (_) {
      late String _$failedField;
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
