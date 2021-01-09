// GENERATED CODE - DO NOT MODIFY BY HAND

part of additional_listing;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AdditionalListing> _$additionalListingSerializer =
    new _$AdditionalListingSerializer();

class _$AdditionalListingSerializer
    implements StructuredSerializer<AdditionalListing> {
  @override
  final Iterable<Type> types = const [AdditionalListing, _$AdditionalListing];
  @override
  final String wireName = 'AdditionalListing';

  @override
  Iterable<Object> serialize(Serializers serializers, AdditionalListing object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'additionalPrice',
      serializers.serialize(object.additionalPrice,
          specifiedType: const FullType(num)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.isSelected != null) {
      result
        ..add('isSelected')
        ..add(serializers.serialize(object.isSelected,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  AdditionalListing deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdditionalListingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'additionalPrice':
          result.additionalPrice = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isSelected':
          result.isSelected = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$AdditionalListing extends AdditionalListing {
  @override
  final num additionalPrice;
  @override
  final String name;
  @override
  final bool isSelected;

  factory _$AdditionalListing(
          [void Function(AdditionalListingBuilder) updates]) =>
      (new AdditionalListingBuilder()..update(updates)).build();

  _$AdditionalListing._({this.additionalPrice, this.name, this.isSelected})
      : super._() {
    if (additionalPrice == null) {
      throw new BuiltValueNullFieldError(
          'AdditionalListing', 'additionalPrice');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('AdditionalListing', 'name');
    }
  }

  @override
  AdditionalListing rebuild(void Function(AdditionalListingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdditionalListingBuilder toBuilder() =>
      new AdditionalListingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdditionalListing &&
        additionalPrice == other.additionalPrice &&
        name == other.name &&
        isSelected == other.isSelected;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, additionalPrice.hashCode), name.hashCode),
        isSelected.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AdditionalListing')
          ..add('additionalPrice', additionalPrice)
          ..add('name', name)
          ..add('isSelected', isSelected))
        .toString();
  }
}

class AdditionalListingBuilder
    implements Builder<AdditionalListing, AdditionalListingBuilder> {
  _$AdditionalListing _$v;

  num _additionalPrice;
  num get additionalPrice => _$this._additionalPrice;
  set additionalPrice(num additionalPrice) =>
      _$this._additionalPrice = additionalPrice;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _isSelected;
  bool get isSelected => _$this._isSelected;
  set isSelected(bool isSelected) => _$this._isSelected = isSelected;

  AdditionalListingBuilder();

  AdditionalListingBuilder get _$this {
    if (_$v != null) {
      _additionalPrice = _$v.additionalPrice;
      _name = _$v.name;
      _isSelected = _$v.isSelected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdditionalListing other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AdditionalListing;
  }

  @override
  void update(void Function(AdditionalListingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AdditionalListing build() {
    final _$result = _$v ??
        new _$AdditionalListing._(
            additionalPrice: additionalPrice,
            name: name,
            isSelected: isSelected);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
