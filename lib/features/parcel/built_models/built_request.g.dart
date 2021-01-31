// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltRequest> _$builtRequestSerializer =
    new _$BuiltRequestSerializer();

class _$BuiltRequestSerializer implements StructuredSerializer<BuiltRequest> {
  @override
  final Iterable<Type> types = const [BuiltRequest, _$BuiltRequest];
  @override
  final String wireName = 'BuiltRequest';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'position',
      serializers.serialize(object.position,
          specifiedType: const FullType(BuiltPosition)),
      'clientName',
      serializers.serialize(object.clientName,
          specifiedType: const FullType(String)),
      'clientNumber',
      serializers.serialize(object.clientNumber,
          specifiedType: const FullType(String)),
      'rating',
      serializers.serialize(object.rating, specifiedType: const FullType(num)),
      'rideType',
      serializers.serialize(object.rideType,
          specifiedType: const FullType(String)),
      'isParcel',
      serializers.serialize(object.isParcel,
          specifiedType: const FullType(bool)),
      'clientToken',
      serializers.serialize(object.clientToken,
          specifiedType: const FullType(String)),
      'directions',
      serializers.serialize(object.directions,
          specifiedType: const FullType(BuiltDirections)),
      'pickup',
      serializers.serialize(object.pickup,
          specifiedType: const FullType(BuiltStop)),
      'points',
      serializers.serialize(object.points,
          specifiedType:
              const FullType(BuiltList, const [const FullType(BuiltStop)])),
      'fee',
      serializers.serialize(object.fee, specifiedType: const FullType(num)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.driverId != null) {
      result
        ..add('driverId')
        ..add(serializers.serialize(object.driverId,
            specifiedType: const FullType(String)));
    }
    if (object.storeID != null) {
      result
        ..add('storeID')
        ..add(serializers.serialize(object.storeID,
            specifiedType: const FullType(String)));
    }
    if (object.driverName != null) {
      result
        ..add('driverName')
        ..add(serializers.serialize(object.driverName,
            specifiedType: const FullType(String)));
    }
    if (object.driverNumber != null) {
      result
        ..add('driverNumber')
        ..add(serializers.serialize(object.driverNumber,
            specifiedType: const FullType(String)));
    }
    if (object.vehicleData != null) {
      result
        ..add('vehicleData')
        ..add(serializers.serialize(object.vehicleData,
            specifiedType: const FullType(BuiltVehicleData)));
    }
    if (object.driverToken != null) {
      result
        ..add('driverToken')
        ..add(serializers.serialize(object.driverToken,
            specifiedType: const FullType(String)));
    }
    if (object.averageTimePreparation != null) {
      result
        ..add('averageTimePreparation')
        ..add(serializers.serialize(object.averageTimePreparation,
            specifiedType: const FullType(num)));
    }
    if (object.currentIndex != null) {
      result
        ..add('currentIndex')
        ..add(serializers.serialize(object.currentIndex,
            specifiedType: const FullType(int)));
    }
    if (object.destination != null) {
      result
        ..add('destination')
        ..add(serializers.serialize(object.destination,
            specifiedType: const FullType(BuiltStop)));
    }
    if (object.items != null) {
      result
        ..add('items')
        ..add(serializers.serialize(object.items,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ClassificationListing)])));
    }
    if (object.timestamp != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(object.timestamp,
            specifiedType: const FullType(num)));
    }
    if (object.subtotal != null) {
      result
        ..add('subtotal')
        ..add(serializers.serialize(object.subtotal,
            specifiedType: const FullType(num)));
    }
    return result;
  }

  @override
  BuiltRequest deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'driverId':
          result.driverId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'position':
          result.position.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltPosition)) as BuiltPosition);
          break;
        case 'storeID':
          result.storeID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'driverName':
          result.driverName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'driverNumber':
          result.driverNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'clientName':
          result.clientName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'clientNumber':
          result.clientNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'rideType':
          result.rideType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isParcel':
          result.isParcel = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'vehicleData':
          result.vehicleData.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BuiltVehicleData))
              as BuiltVehicleData);
          break;
        case 'driverToken':
          result.driverToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'clientToken':
          result.clientToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'averageTimePreparation':
          result.averageTimePreparation = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'directions':
          result.directions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BuiltDirections))
              as BuiltDirections);
          break;
        case 'currentIndex':
          result.currentIndex = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pickup':
          result.pickup.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltStop)) as BuiltStop);
          break;
        case 'destination':
          result.destination.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltStop)) as BuiltStop);
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ClassificationListing)]))
              as BuiltList<Object>);
          break;
        case 'points':
          result.points.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BuiltStop)]))
              as BuiltList<Object>);
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'subtotal':
          result.subtotal = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'fee':
          result.fee = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltRequest extends BuiltRequest {
  @override
  final String id;
  @override
  final String driverId;
  @override
  final String userId;
  @override
  final String status;
  @override
  final BuiltPosition position;
  @override
  final String storeID;
  @override
  final String driverName;
  @override
  final String driverNumber;
  @override
  final String clientName;
  @override
  final String clientNumber;
  @override
  final num rating;
  @override
  final String rideType;
  @override
  final bool isParcel;
  @override
  final BuiltVehicleData vehicleData;
  @override
  final String driverToken;
  @override
  final String clientToken;
  @override
  final num averageTimePreparation;
  @override
  final BuiltDirections directions;
  @override
  final int currentIndex;
  @override
  final BuiltStop pickup;
  @override
  final BuiltStop destination;
  @override
  final BuiltList<ClassificationListing> items;
  @override
  final BuiltList<BuiltStop> points;
  @override
  final num timestamp;
  @override
  final num subtotal;
  @override
  final num fee;

  factory _$BuiltRequest([void Function(BuiltRequestBuilder) updates]) =>
      (new BuiltRequestBuilder()..update(updates)).build();

  _$BuiltRequest._(
      {this.id,
      this.driverId,
      this.userId,
      this.status,
      this.position,
      this.storeID,
      this.driverName,
      this.driverNumber,
      this.clientName,
      this.clientNumber,
      this.rating,
      this.rideType,
      this.isParcel,
      this.vehicleData,
      this.driverToken,
      this.clientToken,
      this.averageTimePreparation,
      this.directions,
      this.currentIndex,
      this.pickup,
      this.destination,
      this.items,
      this.points,
      this.timestamp,
      this.subtotal,
      this.fee})
      : super._() {
    if (userId == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'userId');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'status');
    }
    if (position == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'position');
    }
    if (clientName == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'clientName');
    }
    if (clientNumber == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'clientNumber');
    }
    if (rating == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'rating');
    }
    if (rideType == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'rideType');
    }
    if (isParcel == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'isParcel');
    }
    if (clientToken == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'clientToken');
    }
    if (directions == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'directions');
    }
    if (pickup == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'pickup');
    }
    if (points == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'points');
    }
    if (fee == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'fee');
    }
  }

  @override
  BuiltRequest rebuild(void Function(BuiltRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltRequestBuilder toBuilder() => new BuiltRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltRequest &&
        id == other.id &&
        driverId == other.driverId &&
        userId == other.userId &&
        status == other.status &&
        position == other.position &&
        storeID == other.storeID &&
        driverName == other.driverName &&
        driverNumber == other.driverNumber &&
        clientName == other.clientName &&
        clientNumber == other.clientNumber &&
        rating == other.rating &&
        rideType == other.rideType &&
        isParcel == other.isParcel &&
        vehicleData == other.vehicleData &&
        driverToken == other.driverToken &&
        clientToken == other.clientToken &&
        averageTimePreparation == other.averageTimePreparation &&
        directions == other.directions &&
        currentIndex == other.currentIndex &&
        pickup == other.pickup &&
        destination == other.destination &&
        items == other.items &&
        points == other.points &&
        timestamp == other.timestamp &&
        subtotal == other.subtotal &&
        fee == other.fee;
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), driverId.hashCode), userId.hashCode), status.hashCode), position.hashCode), storeID.hashCode), driverName.hashCode),
                                                                                driverNumber.hashCode),
                                                                            clientName.hashCode),
                                                                        clientNumber.hashCode),
                                                                    rating.hashCode),
                                                                rideType.hashCode),
                                                            isParcel.hashCode),
                                                        vehicleData.hashCode),
                                                    driverToken.hashCode),
                                                clientToken.hashCode),
                                            averageTimePreparation.hashCode),
                                        directions.hashCode),
                                    currentIndex.hashCode),
                                pickup.hashCode),
                            destination.hashCode),
                        items.hashCode),
                    points.hashCode),
                timestamp.hashCode),
            subtotal.hashCode),
        fee.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltRequest')
          ..add('id', id)
          ..add('driverId', driverId)
          ..add('userId', userId)
          ..add('status', status)
          ..add('position', position)
          ..add('storeID', storeID)
          ..add('driverName', driverName)
          ..add('driverNumber', driverNumber)
          ..add('clientName', clientName)
          ..add('clientNumber', clientNumber)
          ..add('rating', rating)
          ..add('rideType', rideType)
          ..add('isParcel', isParcel)
          ..add('vehicleData', vehicleData)
          ..add('driverToken', driverToken)
          ..add('clientToken', clientToken)
          ..add('averageTimePreparation', averageTimePreparation)
          ..add('directions', directions)
          ..add('currentIndex', currentIndex)
          ..add('pickup', pickup)
          ..add('destination', destination)
          ..add('items', items)
          ..add('points', points)
          ..add('timestamp', timestamp)
          ..add('subtotal', subtotal)
          ..add('fee', fee))
        .toString();
  }
}

class BuiltRequestBuilder
    implements Builder<BuiltRequest, BuiltRequestBuilder> {
  _$BuiltRequest _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _driverId;
  String get driverId => _$this._driverId;
  set driverId(String driverId) => _$this._driverId = driverId;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  BuiltPositionBuilder _position;
  BuiltPositionBuilder get position =>
      _$this._position ??= new BuiltPositionBuilder();
  set position(BuiltPositionBuilder position) => _$this._position = position;

  String _storeID;
  String get storeID => _$this._storeID;
  set storeID(String storeID) => _$this._storeID = storeID;

  String _driverName;
  String get driverName => _$this._driverName;
  set driverName(String driverName) => _$this._driverName = driverName;

  String _driverNumber;
  String get driverNumber => _$this._driverNumber;
  set driverNumber(String driverNumber) => _$this._driverNumber = driverNumber;

  String _clientName;
  String get clientName => _$this._clientName;
  set clientName(String clientName) => _$this._clientName = clientName;

  String _clientNumber;
  String get clientNumber => _$this._clientNumber;
  set clientNumber(String clientNumber) => _$this._clientNumber = clientNumber;

  num _rating;
  num get rating => _$this._rating;
  set rating(num rating) => _$this._rating = rating;

  String _rideType;
  String get rideType => _$this._rideType;
  set rideType(String rideType) => _$this._rideType = rideType;

  bool _isParcel;
  bool get isParcel => _$this._isParcel;
  set isParcel(bool isParcel) => _$this._isParcel = isParcel;

  BuiltVehicleDataBuilder _vehicleData;
  BuiltVehicleDataBuilder get vehicleData =>
      _$this._vehicleData ??= new BuiltVehicleDataBuilder();
  set vehicleData(BuiltVehicleDataBuilder vehicleData) =>
      _$this._vehicleData = vehicleData;

  String _driverToken;
  String get driverToken => _$this._driverToken;
  set driverToken(String driverToken) => _$this._driverToken = driverToken;

  String _clientToken;
  String get clientToken => _$this._clientToken;
  set clientToken(String clientToken) => _$this._clientToken = clientToken;

  num _averageTimePreparation;
  num get averageTimePreparation => _$this._averageTimePreparation;
  set averageTimePreparation(num averageTimePreparation) =>
      _$this._averageTimePreparation = averageTimePreparation;

  BuiltDirectionsBuilder _directions;
  BuiltDirectionsBuilder get directions =>
      _$this._directions ??= new BuiltDirectionsBuilder();
  set directions(BuiltDirectionsBuilder directions) =>
      _$this._directions = directions;

  int _currentIndex;
  int get currentIndex => _$this._currentIndex;
  set currentIndex(int currentIndex) => _$this._currentIndex = currentIndex;

  BuiltStopBuilder _pickup;
  BuiltStopBuilder get pickup => _$this._pickup ??= new BuiltStopBuilder();
  set pickup(BuiltStopBuilder pickup) => _$this._pickup = pickup;

  BuiltStopBuilder _destination;
  BuiltStopBuilder get destination =>
      _$this._destination ??= new BuiltStopBuilder();
  set destination(BuiltStopBuilder destination) =>
      _$this._destination = destination;

  ListBuilder<ClassificationListing> _items;
  ListBuilder<ClassificationListing> get items =>
      _$this._items ??= new ListBuilder<ClassificationListing>();
  set items(ListBuilder<ClassificationListing> items) => _$this._items = items;

  ListBuilder<BuiltStop> _points;
  ListBuilder<BuiltStop> get points =>
      _$this._points ??= new ListBuilder<BuiltStop>();
  set points(ListBuilder<BuiltStop> points) => _$this._points = points;

  num _timestamp;
  num get timestamp => _$this._timestamp;
  set timestamp(num timestamp) => _$this._timestamp = timestamp;

  num _subtotal;
  num get subtotal => _$this._subtotal;
  set subtotal(num subtotal) => _$this._subtotal = subtotal;

  num _fee;
  num get fee => _$this._fee;
  set fee(num fee) => _$this._fee = fee;

  BuiltRequestBuilder();

  BuiltRequestBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _driverId = _$v.driverId;
      _userId = _$v.userId;
      _status = _$v.status;
      _position = _$v.position?.toBuilder();
      _storeID = _$v.storeID;
      _driverName = _$v.driverName;
      _driverNumber = _$v.driverNumber;
      _clientName = _$v.clientName;
      _clientNumber = _$v.clientNumber;
      _rating = _$v.rating;
      _rideType = _$v.rideType;
      _isParcel = _$v.isParcel;
      _vehicleData = _$v.vehicleData?.toBuilder();
      _driverToken = _$v.driverToken;
      _clientToken = _$v.clientToken;
      _averageTimePreparation = _$v.averageTimePreparation;
      _directions = _$v.directions?.toBuilder();
      _currentIndex = _$v.currentIndex;
      _pickup = _$v.pickup?.toBuilder();
      _destination = _$v.destination?.toBuilder();
      _items = _$v.items?.toBuilder();
      _points = _$v.points?.toBuilder();
      _timestamp = _$v.timestamp;
      _subtotal = _$v.subtotal;
      _fee = _$v.fee;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltRequest;
  }

  @override
  void update(void Function(BuiltRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltRequest build() {
    _$BuiltRequest _$result;
    try {
      _$result = _$v ??
          new _$BuiltRequest._(
              id: id,
              driverId: driverId,
              userId: userId,
              status: status,
              position: position.build(),
              storeID: storeID,
              driverName: driverName,
              driverNumber: driverNumber,
              clientName: clientName,
              clientNumber: clientNumber,
              rating: rating,
              rideType: rideType,
              isParcel: isParcel,
              vehicleData: _vehicleData?.build(),
              driverToken: driverToken,
              clientToken: clientToken,
              averageTimePreparation: averageTimePreparation,
              directions: directions.build(),
              currentIndex: currentIndex,
              pickup: pickup.build(),
              destination: _destination?.build(),
              items: _items?.build(),
              points: points.build(),
              timestamp: timestamp,
              subtotal: subtotal,
              fee: fee);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'position';
        position.build();

        _$failedField = 'vehicleData';
        _vehicleData?.build();

        _$failedField = 'directions';
        directions.build();

        _$failedField = 'pickup';
        pickup.build();
        _$failedField = 'destination';
        _destination?.build();
        _$failedField = 'items';
        _items?.build();
        _$failedField = 'points';
        points.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BuiltRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
