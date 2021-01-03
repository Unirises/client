// GENERATED CODE - DO NOT MODIFY BY HAND

part of distance;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Distance> _$distanceSerializer = new _$DistanceSerializer();

class _$DistanceSerializer implements StructuredSerializer<Distance> {
  @override
  final Iterable<Type> types = const [Distance, _$Distance];
  @override
  final String wireName = 'Distance';

  @override
  Iterable<Object> serialize(Serializers serializers, Distance object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
      'value',
      serializers.serialize(object.value, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Distance deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DistanceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Distance extends Distance {
  @override
  final String text;
  @override
  final int value;

  factory _$Distance([void Function(DistanceBuilder) updates]) =>
      (new DistanceBuilder()..update(updates)).build();

  _$Distance._({this.text, this.value}) : super._() {
    if (text == null) {
      throw new BuiltValueNullFieldError('Distance', 'text');
    }
    if (value == null) {
      throw new BuiltValueNullFieldError('Distance', 'value');
    }
  }

  @override
  Distance rebuild(void Function(DistanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DistanceBuilder toBuilder() => new DistanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Distance && text == other.text && value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, text.hashCode), value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Distance')
          ..add('text', text)
          ..add('value', value))
        .toString();
  }
}

class DistanceBuilder implements Builder<Distance, DistanceBuilder> {
  _$Distance _$v;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  int _value;
  int get value => _$this._value;
  set value(int value) => _$this._value = value;

  DistanceBuilder();

  DistanceBuilder get _$this {
    if (_$v != null) {
      _text = _$v.text;
      _value = _$v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Distance other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Distance;
  }

  @override
  void update(void Function(DistanceBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Distance build() {
    final _$result = _$v ?? new _$Distance._(text: text, value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
