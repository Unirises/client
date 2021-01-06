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
      'currentIndex',
      serializers.serialize(object.currentIndex,
          specifiedType: const FullType(int)),
      'pickup',
      serializers.serialize(object.pickup,
          specifiedType: const FullType(BuiltStop)),
      'points',
      serializers.serialize(object.points,
          specifiedType:
              const FullType(BuiltList, const [const FullType(BuiltStop)])),
    ];
    if (object.driverId != null) {
      result
        ..add('driverId')
        ..add(serializers.serialize(object.driverId,
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
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    if (object.driverToken != null) {
      result
        ..add('driverToken')
        ..add(serializers.serialize(object.driverToken,
            specifiedType: const FullType(String)));
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
        case 'rideType':
          result.rideType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isParcel':
          result.isParcel = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'vehicleData':
          result.vehicleData = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>;
          break;
        case 'driverToken':
          result.driverToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'clientToken':
          result.clientToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
        case 'points':
          result.points.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BuiltStop)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltRequest extends BuiltRequest {
  @override
  final String driverId;
  @override
  final String userId;
  @override
  final String status;
  @override
  final BuiltPosition position;
  @override
  final String driverName;
  @override
  final String driverNumber;
  @override
  final String clientName;
  @override
  final String clientNumber;
  @override
  final String rideType;
  @override
  final bool isParcel;
  @override
  final Map<String, dynamic> vehicleData;
  @override
  final String driverToken;
  @override
  final String clientToken;
  @override
  final BuiltDirections directions;
  @override
  final int currentIndex;
  @override
  final BuiltStop pickup;
  @override
  final BuiltList<BuiltStop> points;

  factory _$BuiltRequest([void Function(BuiltRequestBuilder) updates]) =>
      (new BuiltRequestBuilder()..update(updates)).build();

  _$BuiltRequest._(
      {this.driverId,
      this.userId,
      this.status,
      this.position,
      this.driverName,
      this.driverNumber,
      this.clientName,
      this.clientNumber,
      this.rideType,
      this.isParcel,
      this.vehicleData,
      this.driverToken,
      this.clientToken,
      this.directions,
      this.currentIndex,
      this.pickup,
      this.points})
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
    if (currentIndex == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'currentIndex');
    }
    if (pickup == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'pickup');
    }
    if (points == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'points');
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
        driverId == other.driverId &&
        userId == other.userId &&
        status == other.status &&
        position == other.position &&
        driverName == other.driverName &&
        driverNumber == other.driverNumber &&
        clientName == other.clientName &&
        clientNumber == other.clientNumber &&
        rideType == other.rideType &&
        isParcel == other.isParcel &&
        vehicleData == other.vehicleData &&
        driverToken == other.driverToken &&
        clientToken == other.clientToken &&
        directions == other.directions &&
        currentIndex == other.currentIndex &&
        pickup == other.pickup &&
        points == other.points;
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
                                                                        0,
                                                                        driverId
                                                                            .hashCode),
                                                                    userId
                                                                        .hashCode),
                                                                status
                                                                    .hashCode),
                                                            position.hashCode),
                                                        driverName.hashCode),
                                                    driverNumber.hashCode),
                                                clientName.hashCode),
                                            clientNumber.hashCode),
                                        rideType.hashCode),
                                    isParcel.hashCode),
                                vehicleData.hashCode),
                            driverToken.hashCode),
                        clientToken.hashCode),
                    directions.hashCode),
                currentIndex.hashCode),
            pickup.hashCode),
        points.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltRequest')
          ..add('driverId', driverId)
          ..add('userId', userId)
          ..add('status', status)
          ..add('position', position)
          ..add('driverName', driverName)
          ..add('driverNumber', driverNumber)
          ..add('clientName', clientName)
          ..add('clientNumber', clientNumber)
          ..add('rideType', rideType)
          ..add('isParcel', isParcel)
          ..add('vehicleData', vehicleData)
          ..add('driverToken', driverToken)
          ..add('clientToken', clientToken)
          ..add('directions', directions)
          ..add('currentIndex', currentIndex)
          ..add('pickup', pickup)
          ..add('points', points))
        .toString();
  }
}

class BuiltRequestBuilder
    implements Builder<BuiltRequest, BuiltRequestBuilder> {
  _$BuiltRequest _$v;

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

  String _rideType;
  String get rideType => _$this._rideType;
  set rideType(String rideType) => _$this._rideType = rideType;

  bool _isParcel;
  bool get isParcel => _$this._isParcel;
  set isParcel(bool isParcel) => _$this._isParcel = isParcel;

  Map<String, dynamic> _vehicleData;
  Map<String, dynamic> get vehicleData => _$this._vehicleData;
  set vehicleData(Map<String, dynamic> vehicleData) =>
      _$this._vehicleData = vehicleData;

  String _driverToken;
  String get driverToken => _$this._driverToken;
  set driverToken(String driverToken) => _$this._driverToken = driverToken;

  String _clientToken;
  String get clientToken => _$this._clientToken;
  set clientToken(String clientToken) => _$this._clientToken = clientToken;

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

  ListBuilder<BuiltStop> _points;
  ListBuilder<BuiltStop> get points =>
      _$this._points ??= new ListBuilder<BuiltStop>();
  set points(ListBuilder<BuiltStop> points) => _$this._points = points;

  BuiltRequestBuilder();

  BuiltRequestBuilder get _$this {
    if (_$v != null) {
      _driverId = _$v.driverId;
      _userId = _$v.userId;
      _status = _$v.status;
      _position = _$v.position?.toBuilder();
      _driverName = _$v.driverName;
      _driverNumber = _$v.driverNumber;
      _clientName = _$v.clientName;
      _clientNumber = _$v.clientNumber;
      _rideType = _$v.rideType;
      _isParcel = _$v.isParcel;
      _vehicleData = _$v.vehicleData;
      _driverToken = _$v.driverToken;
      _clientToken = _$v.clientToken;
      _directions = _$v.directions?.toBuilder();
      _currentIndex = _$v.currentIndex;
      _pickup = _$v.pickup?.toBuilder();
      _points = _$v.points?.toBuilder();
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
              driverId: driverId,
              userId: userId,
              status: status,
              position: position.build(),
              driverName: driverName,
              driverNumber: driverNumber,
              clientName: clientName,
              clientNumber: clientNumber,
              rideType: rideType,
              isParcel: isParcel,
              vehicleData: vehicleData,
              driverToken: driverToken,
              clientToken: clientToken,
              directions: directions.build(),
              currentIndex: currentIndex,
              pickup: pickup.build(),
              points: points.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'position';
        position.build();

        _$failedField = 'directions';
        directions.build();

        _$failedField = 'pickup';
        pickup.build();
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
