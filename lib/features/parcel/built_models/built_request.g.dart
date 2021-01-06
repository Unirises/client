// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BuiltRequest extends BuiltRequest {
  @override
  final String driverId;
  @override
  final String userId;
  @override
  final String status;
  @override
  final FixedPos position;
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
  final int currentIndex;
  @override
  final Stop pickup;
  @override
  final List<Stop> points;

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
      this.currentIndex,
      this.pickup,
      this.points})
      : super._() {
    if (driverId == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'driverId');
    }
    if (userId == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'userId');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'status');
    }
    if (position == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'position');
    }
    if (driverName == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'driverName');
    }
    if (driverNumber == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'driverNumber');
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
    if (vehicleData == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'vehicleData');
    }
    if (driverToken == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'driverToken');
    }
    if (clientToken == null) {
      throw new BuiltValueNullFieldError('BuiltRequest', 'clientToken');
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
                                                                    0,
                                                                    driverId
                                                                        .hashCode),
                                                                userId
                                                                    .hashCode),
                                                            status.hashCode),
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

  FixedPos _position;
  FixedPos get position => _$this._position;
  set position(FixedPos position) => _$this._position = position;

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

  int _currentIndex;
  int get currentIndex => _$this._currentIndex;
  set currentIndex(int currentIndex) => _$this._currentIndex = currentIndex;

  Stop _pickup;
  Stop get pickup => _$this._pickup;
  set pickup(Stop pickup) => _$this._pickup = pickup;

  List<Stop> _points;
  List<Stop> get points => _$this._points;
  set points(List<Stop> points) => _$this._points = points;

  BuiltRequestBuilder();

  BuiltRequestBuilder get _$this {
    if (_$v != null) {
      _driverId = _$v.driverId;
      _userId = _$v.userId;
      _status = _$v.status;
      _position = _$v.position;
      _driverName = _$v.driverName;
      _driverNumber = _$v.driverNumber;
      _clientName = _$v.clientName;
      _clientNumber = _$v.clientNumber;
      _rideType = _$v.rideType;
      _isParcel = _$v.isParcel;
      _vehicleData = _$v.vehicleData;
      _driverToken = _$v.driverToken;
      _clientToken = _$v.clientToken;
      _currentIndex = _$v.currentIndex;
      _pickup = _$v.pickup;
      _points = _$v.points;
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
    final _$result = _$v ??
        new _$BuiltRequest._(
            driverId: driverId,
            userId: userId,
            status: status,
            position: position,
            driverName: driverName,
            driverNumber: driverNumber,
            clientName: clientName,
            clientNumber: clientNumber,
            rideType: rideType,
            isParcel: isParcel,
            vehicleData: vehicleData,
            driverToken: driverToken,
            clientToken: clientToken,
            currentIndex: currentIndex,
            pickup: pickup,
            points: points);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
