// GENERATED CODE - DO NOT MODIFY BY HAND

part of routes;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Routes> _$routesSerializer = new _$RoutesSerializer();

class _$RoutesSerializer implements StructuredSerializer<Routes> {
  @override
  final Iterable<Type> types = const [Routes, _$Routes];
  @override
  final String wireName = 'Routes';

  @override
  Iterable<Object> serialize(Serializers serializers, Routes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'bounds',
      serializers.serialize(object.bounds,
          specifiedType: const FullType(Bounds)),
      'legs',
      serializers.serialize(object.legs,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Legs)])),
      'overview_polyline',
      serializers.serialize(object.overviewPolyline,
          specifiedType: const FullType(OverviewPolyline)),
    ];

    return result;
  }

  @override
  Routes deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RoutesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'bounds':
          result.bounds.replace(serializers.deserialize(value,
              specifiedType: const FullType(Bounds)) as Bounds);
          break;
        case 'legs':
          result.legs.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Legs)]))
              as BuiltList<Object>);
          break;
        case 'overview_polyline':
          result.overviewPolyline.replace(serializers.deserialize(value,
                  specifiedType: const FullType(OverviewPolyline))
              as OverviewPolyline);
          break;
      }
    }

    return result.build();
  }
}

class _$Routes extends Routes {
  @override
  final Bounds bounds;
  @override
  final BuiltList<Legs> legs;
  @override
  final OverviewPolyline overviewPolyline;

  factory _$Routes([void Function(RoutesBuilder) updates]) =>
      (new RoutesBuilder()..update(updates)).build();

  _$Routes._({this.bounds, this.legs, this.overviewPolyline}) : super._() {
    if (bounds == null) {
      throw new BuiltValueNullFieldError('Routes', 'bounds');
    }
    if (legs == null) {
      throw new BuiltValueNullFieldError('Routes', 'legs');
    }
    if (overviewPolyline == null) {
      throw new BuiltValueNullFieldError('Routes', 'overviewPolyline');
    }
  }

  @override
  Routes rebuild(void Function(RoutesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoutesBuilder toBuilder() => new RoutesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Routes &&
        bounds == other.bounds &&
        legs == other.legs &&
        overviewPolyline == other.overviewPolyline;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, bounds.hashCode), legs.hashCode),
        overviewPolyline.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Routes')
          ..add('bounds', bounds)
          ..add('legs', legs)
          ..add('overviewPolyline', overviewPolyline))
        .toString();
  }
}

class RoutesBuilder implements Builder<Routes, RoutesBuilder> {
  _$Routes _$v;

  BoundsBuilder _bounds;
  BoundsBuilder get bounds => _$this._bounds ??= new BoundsBuilder();
  set bounds(BoundsBuilder bounds) => _$this._bounds = bounds;

  ListBuilder<Legs> _legs;
  ListBuilder<Legs> get legs => _$this._legs ??= new ListBuilder<Legs>();
  set legs(ListBuilder<Legs> legs) => _$this._legs = legs;

  OverviewPolylineBuilder _overviewPolyline;
  OverviewPolylineBuilder get overviewPolyline =>
      _$this._overviewPolyline ??= new OverviewPolylineBuilder();
  set overviewPolyline(OverviewPolylineBuilder overviewPolyline) =>
      _$this._overviewPolyline = overviewPolyline;

  RoutesBuilder();

  RoutesBuilder get _$this {
    if (_$v != null) {
      _bounds = _$v.bounds?.toBuilder();
      _legs = _$v.legs?.toBuilder();
      _overviewPolyline = _$v.overviewPolyline?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Routes other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Routes;
  }

  @override
  void update(void Function(RoutesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Routes build() {
    _$Routes _$result;
    try {
      _$result = _$v ??
          new _$Routes._(
              bounds: bounds.build(),
              legs: legs.build(),
              overviewPolyline: overviewPolyline.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bounds';
        bounds.build();
        _$failedField = 'legs';
        legs.build();
        _$failedField = 'overviewPolyline';
        overviewPolyline.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Routes', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
