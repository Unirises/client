// GENERATED CODE - DO NOT MODIFY BY HAND

part of classification_listing;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ClassificationListing> _$classificationListingSerializer =
    new _$ClassificationListingSerializer();

class _$ClassificationListingSerializer
    implements StructuredSerializer<ClassificationListing> {
  @override
  final Iterable<Type> types = const [
    ClassificationListing,
    _$ClassificationListing
  ];
  @override
  final String wireName = 'ClassificationListing';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, ClassificationListing object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'itemName',
      serializers.serialize(object.itemName,
          specifiedType: const FullType(String)),
      'additionals',
      serializers.serialize(object.additionals,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Additionals)])),
      'itemPrice',
      serializers.serialize(object.itemPrice,
          specifiedType: const FullType(num)),
      'sku',
      serializers.serialize(object.sku, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.itemPhoto;
    if (value != null) {
      result
        ..add('itemPhoto')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.itemSize;
    if (value != null) {
      result
        ..add('itemSize')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.quantity;
    if (value != null) {
      result
        ..add('quantity')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isValid;
    if (value != null) {
      result
        ..add('isValid')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.additionalPrice;
    if (value != null) {
      result
        ..add('additionalPrice')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.isAvailable;
    if (value != null) {
      result
        ..add('isAvailable')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ClassificationListing deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClassificationListingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'itemName':
          result.itemName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'additionals':
          result.additionals.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Additionals)]))!
              as BuiltList<Object>);
          break;
        case 'itemPhoto':
          result.itemPhoto = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'itemPrice':
          result.itemPrice = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'itemSize':
          result.itemSize = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isValid':
          result.isValid = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'additionalPrice':
          result.additionalPrice = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'sku':
          result.sku = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isAvailable':
          result.isAvailable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ClassificationListing extends ClassificationListing {
  @override
  final String itemName;
  @override
  final BuiltList<Additionals> additionals;
  @override
  final String? itemPhoto;
  @override
  final num itemPrice;
  @override
  final String? itemSize;
  @override
  final int? quantity;
  @override
  final bool? isValid;
  @override
  final num? additionalPrice;
  @override
  final String sku;
  @override
  final bool? isAvailable;

  factory _$ClassificationListing(
          [void Function(ClassificationListingBuilder)? updates]) =>
      (new ClassificationListingBuilder()..update(updates)).build();

  _$ClassificationListing._(
      {required this.itemName,
      required this.additionals,
      this.itemPhoto,
      required this.itemPrice,
      this.itemSize,
      this.quantity,
      this.isValid,
      this.additionalPrice,
      required this.sku,
      this.isAvailable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        itemName, 'ClassificationListing', 'itemName');
    BuiltValueNullFieldError.checkNotNull(
        additionals, 'ClassificationListing', 'additionals');
    BuiltValueNullFieldError.checkNotNull(
        itemPrice, 'ClassificationListing', 'itemPrice');
    BuiltValueNullFieldError.checkNotNull(sku, 'ClassificationListing', 'sku');
  }

  @override
  ClassificationListing rebuild(
          void Function(ClassificationListingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClassificationListingBuilder toBuilder() =>
      new ClassificationListingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassificationListing &&
        itemName == other.itemName &&
        additionals == other.additionals &&
        itemPhoto == other.itemPhoto &&
        itemPrice == other.itemPrice &&
        itemSize == other.itemSize &&
        quantity == other.quantity &&
        isValid == other.isValid &&
        additionalPrice == other.additionalPrice &&
        sku == other.sku &&
        isAvailable == other.isAvailable;
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
                                    $jc($jc(0, itemName.hashCode),
                                        additionals.hashCode),
                                    itemPhoto.hashCode),
                                itemPrice.hashCode),
                            itemSize.hashCode),
                        quantity.hashCode),
                    isValid.hashCode),
                additionalPrice.hashCode),
            sku.hashCode),
        isAvailable.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ClassificationListing')
          ..add('itemName', itemName)
          ..add('additionals', additionals)
          ..add('itemPhoto', itemPhoto)
          ..add('itemPrice', itemPrice)
          ..add('itemSize', itemSize)
          ..add('quantity', quantity)
          ..add('isValid', isValid)
          ..add('additionalPrice', additionalPrice)
          ..add('sku', sku)
          ..add('isAvailable', isAvailable))
        .toString();
  }
}

class ClassificationListingBuilder
    implements Builder<ClassificationListing, ClassificationListingBuilder> {
  _$ClassificationListing? _$v;

  String? _itemName;
  String? get itemName => _$this._itemName;
  set itemName(String? itemName) => _$this._itemName = itemName;

  ListBuilder<Additionals>? _additionals;
  ListBuilder<Additionals> get additionals =>
      _$this._additionals ??= new ListBuilder<Additionals>();
  set additionals(ListBuilder<Additionals>? additionals) =>
      _$this._additionals = additionals;

  String? _itemPhoto;
  String? get itemPhoto => _$this._itemPhoto;
  set itemPhoto(String? itemPhoto) => _$this._itemPhoto = itemPhoto;

  num? _itemPrice;
  num? get itemPrice => _$this._itemPrice;
  set itemPrice(num? itemPrice) => _$this._itemPrice = itemPrice;

  String? _itemSize;
  String? get itemSize => _$this._itemSize;
  set itemSize(String? itemSize) => _$this._itemSize = itemSize;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  bool? _isValid;
  bool? get isValid => _$this._isValid;
  set isValid(bool? isValid) => _$this._isValid = isValid;

  num? _additionalPrice;
  num? get additionalPrice => _$this._additionalPrice;
  set additionalPrice(num? additionalPrice) =>
      _$this._additionalPrice = additionalPrice;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  bool? _isAvailable;
  bool? get isAvailable => _$this._isAvailable;
  set isAvailable(bool? isAvailable) => _$this._isAvailable = isAvailable;

  ClassificationListingBuilder();

  ClassificationListingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemName = $v.itemName;
      _additionals = $v.additionals.toBuilder();
      _itemPhoto = $v.itemPhoto;
      _itemPrice = $v.itemPrice;
      _itemSize = $v.itemSize;
      _quantity = $v.quantity;
      _isValid = $v.isValid;
      _additionalPrice = $v.additionalPrice;
      _sku = $v.sku;
      _isAvailable = $v.isAvailable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassificationListing other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClassificationListing;
  }

  @override
  void update(void Function(ClassificationListingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ClassificationListing build() {
    _$ClassificationListing _$result;
    try {
      _$result = _$v ??
          new _$ClassificationListing._(
              itemName: BuiltValueNullFieldError.checkNotNull(
                  itemName, 'ClassificationListing', 'itemName'),
              additionals: additionals.build(),
              itemPhoto: itemPhoto,
              itemPrice: BuiltValueNullFieldError.checkNotNull(
                  itemPrice, 'ClassificationListing', 'itemPrice'),
              itemSize: itemSize,
              quantity: quantity,
              isValid: isValid,
              additionalPrice: additionalPrice,
              sku: BuiltValueNullFieldError.checkNotNull(
                  sku, 'ClassificationListing', 'sku'),
              isAvailable: isAvailable);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'additionals';
        additionals.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ClassificationListing', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
