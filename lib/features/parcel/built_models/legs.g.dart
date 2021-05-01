// GENERATED CODE - DO NOT MODIFY BY HAND

part of legs;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Legs> _$legsSerializer = new _$LegsSerializer();

class _$LegsSerializer implements StructuredSerializer<Legs> {
  @override
  final Iterable<Type> types = const [Legs, _$Legs];
  @override
  final String wireName = 'Legs';

  @override
  Iterable<Object?> serialize(Serializers serializers, Legs object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'distance',
      serializers.serialize(object.distance,
          specifiedType: const FullType(Distance)),
      'duration',
      serializers.serialize(object.duration,
          specifiedType: const FullType(DistanceDuration)),
      'end_address',
      serializers.serialize(object.endAddress,
          specifiedType: const FullType(String)),
      'end_location',
      serializers.serialize(object.endLocation,
          specifiedType: const FullType(Location)),
      'start_address',
      serializers.serialize(object.startAddress,
          specifiedType: const FullType(String)),
      'start_location',
      serializers.serialize(object.startLocation,
          specifiedType: const FullType(Location)),
    ];

    return result;
  }

  @override
  Legs deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LegsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'distance':
          result.distance.replace(serializers.deserialize(value,
              specifiedType: const FullType(Distance))! as Distance);
          break;
        case 'duration':
          result.duration.replace(serializers.deserialize(value,
                  specifiedType: const FullType(DistanceDuration))!
              as DistanceDuration);
          break;
        case 'end_address':
          result.endAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'end_location':
          result.endLocation.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location))! as Location);
          break;
        case 'start_address':
          result.startAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'start_location':
          result.startLocation.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location))! as Location);
          break;
      }
    }

    return result.build();
  }
}

class _$Legs extends Legs {
  @override
  final Distance distance;
  @override
  final DistanceDuration duration;
  @override
  final String endAddress;
  @override
  final Location endLocation;
  @override
  final String startAddress;
  @override
  final Location startLocation;

  factory _$Legs([void Function(LegsBuilder)? updates]) =>
      (new LegsBuilder()..update(updates)).build();

  _$Legs._(
      {required this.distance,
      required this.duration,
      required this.endAddress,
      required this.endLocation,
      required this.startAddress,
      required this.startLocation})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(distance, 'Legs', 'distance');
    BuiltValueNullFieldError.checkNotNull(duration, 'Legs', 'duration');
    BuiltValueNullFieldError.checkNotNull(endAddress, 'Legs', 'endAddress');
    BuiltValueNullFieldError.checkNotNull(endLocation, 'Legs', 'endLocation');
    BuiltValueNullFieldError.checkNotNull(startAddress, 'Legs', 'startAddress');
    BuiltValueNullFieldError.checkNotNull(
        startLocation, 'Legs', 'startLocation');
  }

  @override
  Legs rebuild(void Function(LegsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegsBuilder toBuilder() => new LegsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Legs &&
        distance == other.distance &&
        duration == other.duration &&
        endAddress == other.endAddress &&
        endLocation == other.endLocation &&
        startAddress == other.startAddress &&
        startLocation == other.startLocation;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, distance.hashCode), duration.hashCode),
                    endAddress.hashCode),
                endLocation.hashCode),
            startAddress.hashCode),
        startLocation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Legs')
          ..add('distance', distance)
          ..add('duration', duration)
          ..add('endAddress', endAddress)
          ..add('endLocation', endLocation)
          ..add('startAddress', startAddress)
          ..add('startLocation', startLocation))
        .toString();
  }
}

class LegsBuilder implements Builder<Legs, LegsBuilder> {
  _$Legs? _$v;

  DistanceBuilder? _distance;
  DistanceBuilder get distance => _$this._distance ??= new DistanceBuilder();
  set distance(DistanceBuilder? distance) => _$this._distance = distance;

  DistanceDurationBuilder? _duration;
  DistanceDurationBuilder get duration =>
      _$this._duration ??= new DistanceDurationBuilder();
  set duration(DistanceDurationBuilder? duration) =>
      _$this._duration = duration;

  String? _endAddress;
  String? get endAddress => _$this._endAddress;
  set endAddress(String? endAddress) => _$this._endAddress = endAddress;

  LocationBuilder? _endLocation;
  LocationBuilder get endLocation =>
      _$this._endLocation ??= new LocationBuilder();
  set endLocation(LocationBuilder? endLocation) =>
      _$this._endLocation = endLocation;

  String? _startAddress;
  String? get startAddress => _$this._startAddress;
  set startAddress(String? startAddress) => _$this._startAddress = startAddress;

  LocationBuilder? _startLocation;
  LocationBuilder get startLocation =>
      _$this._startLocation ??= new LocationBuilder();
  set startLocation(LocationBuilder? startLocation) =>
      _$this._startLocation = startLocation;

  LegsBuilder();

  LegsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _distance = $v.distance.toBuilder();
      _duration = $v.duration.toBuilder();
      _endAddress = $v.endAddress;
      _endLocation = $v.endLocation.toBuilder();
      _startAddress = $v.startAddress;
      _startLocation = $v.startLocation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Legs other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Legs;
  }

  @override
  void update(void Function(LegsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Legs build() {
    _$Legs _$result;
    try {
      _$result = _$v ??
          new _$Legs._(
              distance: distance.build(),
              duration: duration.build(),
              endAddress: BuiltValueNullFieldError.checkNotNull(
                  endAddress, 'Legs', 'endAddress'),
              endLocation: endLocation.build(),
              startAddress: BuiltValueNullFieldError.checkNotNull(
                  startAddress, 'Legs', 'startAddress'),
              startLocation: startLocation.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'distance';
        distance.build();
        _$failedField = 'duration';
        duration.build();

        _$failedField = 'endLocation';
        endLocation.build();

        _$failedField = 'startLocation';
        startLocation.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Legs', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
