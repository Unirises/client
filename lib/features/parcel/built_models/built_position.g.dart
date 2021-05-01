// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltPosition> _$builtPositionSerializer =
    new _$BuiltPositionSerializer();

class _$BuiltPositionSerializer implements StructuredSerializer<BuiltPosition> {
  @override
  final Iterable<Type> types = const [BuiltPosition, _$BuiltPosition];
  @override
  final String wireName = 'BuiltPosition';

  @override
  Iterable<Object?> serialize(Serializers serializers, BuiltPosition object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'heading',
      serializers.serialize(object.heading, specifiedType: const FullType(num)),
      'latitude',
      serializers.serialize(object.latitude,
          specifiedType: const FullType(num)),
      'longitude',
      serializers.serialize(object.longitude,
          specifiedType: const FullType(num)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(num)),
    ];

    return result;
  }

  @override
  BuiltPosition deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltPositionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'heading':
          result.heading = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltPosition extends BuiltPosition {
  @override
  final num heading;
  @override
  final num latitude;
  @override
  final num longitude;
  @override
  final num timestamp;

  factory _$BuiltPosition([void Function(BuiltPositionBuilder)? updates]) =>
      (new BuiltPositionBuilder()..update(updates)).build();

  _$BuiltPosition._(
      {required this.heading,
      required this.latitude,
      required this.longitude,
      required this.timestamp})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(heading, 'BuiltPosition', 'heading');
    BuiltValueNullFieldError.checkNotNull(
        latitude, 'BuiltPosition', 'latitude');
    BuiltValueNullFieldError.checkNotNull(
        longitude, 'BuiltPosition', 'longitude');
    BuiltValueNullFieldError.checkNotNull(
        timestamp, 'BuiltPosition', 'timestamp');
  }

  @override
  BuiltPosition rebuild(void Function(BuiltPositionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltPositionBuilder toBuilder() => new BuiltPositionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltPosition &&
        heading == other.heading &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, heading.hashCode), latitude.hashCode),
            longitude.hashCode),
        timestamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltPosition')
          ..add('heading', heading)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class BuiltPositionBuilder
    implements Builder<BuiltPosition, BuiltPositionBuilder> {
  _$BuiltPosition? _$v;

  num? _heading;
  num? get heading => _$this._heading;
  set heading(num? heading) => _$this._heading = heading;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  num? _timestamp;
  num? get timestamp => _$this._timestamp;
  set timestamp(num? timestamp) => _$this._timestamp = timestamp;

  BuiltPositionBuilder();

  BuiltPositionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _heading = $v.heading;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltPosition other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltPosition;
  }

  @override
  void update(void Function(BuiltPositionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltPosition build() {
    final _$result = _$v ??
        new _$BuiltPosition._(
            heading: BuiltValueNullFieldError.checkNotNull(
                heading, 'BuiltPosition', 'heading'),
            latitude: BuiltValueNullFieldError.checkNotNull(
                latitude, 'BuiltPosition', 'latitude'),
            longitude: BuiltValueNullFieldError.checkNotNull(
                longitude, 'BuiltPosition', 'longitude'),
            timestamp: BuiltValueNullFieldError.checkNotNull(
                timestamp, 'BuiltPosition', 'timestamp'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
