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
  Iterable<Object?> serialize(Serializers serializers, AdditionalListing object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'additionalPrice',
      serializers.serialize(object.additionalPrice,
          specifiedType: const FullType(num)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'additionalSKU',
      serializers.serialize(object.additionalSKU,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.isSelected;
    if (value != null) {
      result
        ..add('isSelected')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  AdditionalListing deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdditionalListingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
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
        case 'additionalSKU':
          result.additionalSKU = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
  final bool? isSelected;
  @override
  final String additionalSKU;

  factory _$AdditionalListing(
          [void Function(AdditionalListingBuilder)? updates]) =>
      (new AdditionalListingBuilder()..update(updates)).build();

  _$AdditionalListing._(
      {required this.additionalPrice,
      required this.name,
      this.isSelected,
      required this.additionalSKU})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        additionalPrice, 'AdditionalListing', 'additionalPrice');
    BuiltValueNullFieldError.checkNotNull(name, 'AdditionalListing', 'name');
    BuiltValueNullFieldError.checkNotNull(
        additionalSKU, 'AdditionalListing', 'additionalSKU');
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
        isSelected == other.isSelected &&
        additionalSKU == other.additionalSKU;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, additionalPrice.hashCode), name.hashCode),
            isSelected.hashCode),
        additionalSKU.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AdditionalListing')
          ..add('additionalPrice', additionalPrice)
          ..add('name', name)
          ..add('isSelected', isSelected)
          ..add('additionalSKU', additionalSKU))
        .toString();
  }
}

class AdditionalListingBuilder
    implements Builder<AdditionalListing, AdditionalListingBuilder> {
  _$AdditionalListing? _$v;

  num? _additionalPrice;
  num? get additionalPrice => _$this._additionalPrice;
  set additionalPrice(num? additionalPrice) =>
      _$this._additionalPrice = additionalPrice;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _isSelected;
  bool? get isSelected => _$this._isSelected;
  set isSelected(bool? isSelected) => _$this._isSelected = isSelected;

  String? _additionalSKU;
  String? get additionalSKU => _$this._additionalSKU;
  set additionalSKU(String? additionalSKU) =>
      _$this._additionalSKU = additionalSKU;

  AdditionalListingBuilder();

  AdditionalListingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _additionalPrice = $v.additionalPrice;
      _name = $v.name;
      _isSelected = $v.isSelected;
      _additionalSKU = $v.additionalSKU;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdditionalListing other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdditionalListing;
  }

  @override
  void update(void Function(AdditionalListingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AdditionalListing build() {
    final _$result = _$v ??
        new _$AdditionalListing._(
            additionalPrice: BuiltValueNullFieldError.checkNotNull(
                additionalPrice, 'AdditionalListing', 'additionalPrice'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'AdditionalListing', 'name'),
            isSelected: isSelected,
            additionalSKU: BuiltValueNullFieldError.checkNotNull(
                additionalSKU, 'AdditionalListing', 'additionalSKU'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
