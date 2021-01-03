// GENERATED CODE - DO NOT MODIFY BY HAND

part of bounds;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Bounds> _$boundsSerializer = new _$BoundsSerializer();

class _$BoundsSerializer implements StructuredSerializer<Bounds> {
  @override
  final Iterable<Type> types = const [Bounds, _$Bounds];
  @override
  final String wireName = 'Bounds';

  @override
  Iterable<Object> serialize(Serializers serializers, Bounds object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'northeast',
      serializers.serialize(object.northeast,
          specifiedType: const FullType(Location)),
      'southwest',
      serializers.serialize(object.southwest,
          specifiedType: const FullType(Location)),
    ];

    return result;
  }

  @override
  Bounds deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BoundsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'northeast':
          result.northeast.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location)) as Location);
          break;
        case 'southwest':
          result.southwest.replace(serializers.deserialize(value,
              specifiedType: const FullType(Location)) as Location);
          break;
      }
    }

    return result.build();
  }
}

class _$Bounds extends Bounds {
  @override
  final Location northeast;
  @override
  final Location southwest;

  factory _$Bounds([void Function(BoundsBuilder) updates]) =>
      (new BoundsBuilder()..update(updates)).build();

  _$Bounds._({this.northeast, this.southwest}) : super._() {
    if (northeast == null) {
      throw new BuiltValueNullFieldError('Bounds', 'northeast');
    }
    if (southwest == null) {
      throw new BuiltValueNullFieldError('Bounds', 'southwest');
    }
  }

  @override
  Bounds rebuild(void Function(BoundsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BoundsBuilder toBuilder() => new BoundsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bounds &&
        northeast == other.northeast &&
        southwest == other.southwest;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, northeast.hashCode), southwest.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Bounds')
          ..add('northeast', northeast)
          ..add('southwest', southwest))
        .toString();
  }
}

class BoundsBuilder implements Builder<Bounds, BoundsBuilder> {
  _$Bounds _$v;

  LocationBuilder _northeast;
  LocationBuilder get northeast => _$this._northeast ??= new LocationBuilder();
  set northeast(LocationBuilder northeast) => _$this._northeast = northeast;

  LocationBuilder _southwest;
  LocationBuilder get southwest => _$this._southwest ??= new LocationBuilder();
  set southwest(LocationBuilder southwest) => _$this._southwest = southwest;

  BoundsBuilder();

  BoundsBuilder get _$this {
    if (_$v != null) {
      _northeast = _$v.northeast?.toBuilder();
      _southwest = _$v.southwest?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Bounds other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Bounds;
  }

  @override
  void update(void Function(BoundsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Bounds build() {
    _$Bounds _$result;
    try {
      _$result = _$v ??
          new _$Bounds._(
              northeast: northeast.build(), southwest: southwest.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'northeast';
        northeast.build();
        _$failedField = 'southwest';
        southwest.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Bounds', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
