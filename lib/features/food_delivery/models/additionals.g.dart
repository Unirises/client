// GENERATED CODE - DO NOT MODIFY BY HAND

part of additionals;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Additionals> _$additionalsSerializer = new _$AdditionalsSerializer();

class _$AdditionalsSerializer implements StructuredSerializer<Additionals> {
  @override
  final Iterable<Type> types = const [Additionals, _$Additionals];
  @override
  final String wireName = 'Additionals';

  @override
  Iterable<Object> serialize(Serializers serializers, Additionals object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'minMax',
      serializers.serialize(object.minMax,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
      'additionalListing',
      serializers.serialize(object.additionalListing,
          specifiedType: const FullType(
              BuiltList, const [const FullType(AdditionalListing)])),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'additionalName',
      serializers.serialize(object.additionalName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Additionals deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdditionalsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'minMax':
          result.minMax.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'additionalListing':
          result.additionalListing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(AdditionalListing)]))
              as BuiltList<Object>);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'additionalName':
          result.additionalName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Additionals extends Additionals {
  @override
  final BuiltList<int> minMax;
  @override
  final BuiltList<AdditionalListing> additionalListing;
  @override
  final String type;
  @override
  final String additionalName;

  factory _$Additionals([void Function(AdditionalsBuilder) updates]) =>
      (new AdditionalsBuilder()..update(updates)).build();

  _$Additionals._(
      {this.minMax, this.additionalListing, this.type, this.additionalName})
      : super._() {
    if (minMax == null) {
      throw new BuiltValueNullFieldError('Additionals', 'minMax');
    }
    if (additionalListing == null) {
      throw new BuiltValueNullFieldError('Additionals', 'additionalListing');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Additionals', 'type');
    }
    if (additionalName == null) {
      throw new BuiltValueNullFieldError('Additionals', 'additionalName');
    }
  }

  @override
  Additionals rebuild(void Function(AdditionalsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdditionalsBuilder toBuilder() => new AdditionalsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Additionals &&
        minMax == other.minMax &&
        additionalListing == other.additionalListing &&
        type == other.type &&
        additionalName == other.additionalName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, minMax.hashCode), additionalListing.hashCode),
            type.hashCode),
        additionalName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Additionals')
          ..add('minMax', minMax)
          ..add('additionalListing', additionalListing)
          ..add('type', type)
          ..add('additionalName', additionalName))
        .toString();
  }
}

class AdditionalsBuilder implements Builder<Additionals, AdditionalsBuilder> {
  _$Additionals _$v;

  ListBuilder<int> _minMax;
  ListBuilder<int> get minMax => _$this._minMax ??= new ListBuilder<int>();
  set minMax(ListBuilder<int> minMax) => _$this._minMax = minMax;

  ListBuilder<AdditionalListing> _additionalListing;
  ListBuilder<AdditionalListing> get additionalListing =>
      _$this._additionalListing ??= new ListBuilder<AdditionalListing>();
  set additionalListing(ListBuilder<AdditionalListing> additionalListing) =>
      _$this._additionalListing = additionalListing;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _additionalName;
  String get additionalName => _$this._additionalName;
  set additionalName(String additionalName) =>
      _$this._additionalName = additionalName;

  AdditionalsBuilder();

  AdditionalsBuilder get _$this {
    if (_$v != null) {
      _minMax = _$v.minMax?.toBuilder();
      _additionalListing = _$v.additionalListing?.toBuilder();
      _type = _$v.type;
      _additionalName = _$v.additionalName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Additionals other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Additionals;
  }

  @override
  void update(void Function(AdditionalsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Additionals build() {
    _$Additionals _$result;
    try {
      _$result = _$v ??
          new _$Additionals._(
              minMax: minMax.build(),
              additionalListing: additionalListing.build(),
              type: type,
              additionalName: additionalName);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'minMax';
        minMax.build();
        _$failedField = 'additionalListing';
        additionalListing.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Additionals', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
