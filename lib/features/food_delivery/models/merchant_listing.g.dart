// GENERATED CODE - DO NOT MODIFY BY HAND

part of listing;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MerchantListing> _$merchantListingSerializer =
    new _$MerchantListingSerializer();

class _$MerchantListingSerializer
    implements StructuredSerializer<MerchantListing> {
  @override
  final Iterable<Type> types = const [MerchantListing, _$MerchantListing];
  @override
  final String wireName = 'MerchantListing';

  @override
  Iterable<Object> serialize(Serializers serializers, MerchantListing object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listing',
      serializers.serialize(object.listing,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Listing)])),
    ];

    return result;
  }

  @override
  MerchantListing deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MerchantListingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'listing':
          result.listing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Listing)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$MerchantListing extends MerchantListing {
  @override
  final BuiltList<Listing> listing;

  factory _$MerchantListing([void Function(MerchantListingBuilder) updates]) =>
      (new MerchantListingBuilder()..update(updates)).build();

  _$MerchantListing._({this.listing}) : super._() {
    if (listing == null) {
      throw new BuiltValueNullFieldError('MerchantListing', 'listing');
    }
  }

  @override
  MerchantListing rebuild(void Function(MerchantListingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MerchantListingBuilder toBuilder() =>
      new MerchantListingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MerchantListing && listing == other.listing;
  }

  @override
  int get hashCode {
    return $jf($jc(0, listing.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MerchantListing')
          ..add('listing', listing))
        .toString();
  }
}

class MerchantListingBuilder
    implements Builder<MerchantListing, MerchantListingBuilder> {
  _$MerchantListing _$v;

  ListBuilder<Listing> _listing;
  ListBuilder<Listing> get listing =>
      _$this._listing ??= new ListBuilder<Listing>();
  set listing(ListBuilder<Listing> listing) => _$this._listing = listing;

  MerchantListingBuilder();

  MerchantListingBuilder get _$this {
    if (_$v != null) {
      _listing = _$v.listing?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MerchantListing other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MerchantListing;
  }

  @override
  void update(void Function(MerchantListingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MerchantListing build() {
    _$MerchantListing _$result;
    try {
      _$result = _$v ?? new _$MerchantListing._(listing: listing.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'listing';
        listing.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MerchantListing', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
