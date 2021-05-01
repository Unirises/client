// GENERATED CODE - DO NOT MODIFY BY HAND

part of listing;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Listing> _$listingSerializer = new _$ListingSerializer();

class _$ListingSerializer implements StructuredSerializer<Listing> {
  @override
  final Iterable<Type> types = const [Listing, _$Listing];
  @override
  final String wireName = 'Listing';

  @override
  Iterable<Object?> serialize(Serializers serializers, Listing object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'classificationName',
      serializers.serialize(object.classificationName,
          specifiedType: const FullType(String)),
      'classificationListing',
      serializers.serialize(object.classificationListing,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ClassificationListing)])),
    ];

    return result;
  }

  @override
  Listing deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'classificationName':
          result.classificationName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'classificationListing':
          result.classificationListing.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(ClassificationListing)
              ]))! as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$Listing extends Listing {
  @override
  final String classificationName;
  @override
  final BuiltList<ClassificationListing> classificationListing;

  factory _$Listing([void Function(ListingBuilder)? updates]) =>
      (new ListingBuilder()..update(updates)).build();

  _$Listing._(
      {required this.classificationName, required this.classificationListing})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        classificationName, 'Listing', 'classificationName');
    BuiltValueNullFieldError.checkNotNull(
        classificationListing, 'Listing', 'classificationListing');
  }

  @override
  Listing rebuild(void Function(ListingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListingBuilder toBuilder() => new ListingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Listing &&
        classificationName == other.classificationName &&
        classificationListing == other.classificationListing;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(0, classificationName.hashCode), classificationListing.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Listing')
          ..add('classificationName', classificationName)
          ..add('classificationListing', classificationListing))
        .toString();
  }
}

class ListingBuilder implements Builder<Listing, ListingBuilder> {
  _$Listing? _$v;

  String? _classificationName;
  String? get classificationName => _$this._classificationName;
  set classificationName(String? classificationName) =>
      _$this._classificationName = classificationName;

  ListBuilder<ClassificationListing>? _classificationListing;
  ListBuilder<ClassificationListing> get classificationListing =>
      _$this._classificationListing ??=
          new ListBuilder<ClassificationListing>();
  set classificationListing(
          ListBuilder<ClassificationListing>? classificationListing) =>
      _$this._classificationListing = classificationListing;

  ListingBuilder();

  ListingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _classificationName = $v.classificationName;
      _classificationListing = $v.classificationListing.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Listing other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Listing;
  }

  @override
  void update(void Function(ListingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Listing build() {
    _$Listing _$result;
    try {
      _$result = _$v ??
          new _$Listing._(
              classificationName: BuiltValueNullFieldError.checkNotNull(
                  classificationName, 'Listing', 'classificationName'),
              classificationListing: classificationListing.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'classificationListing';
        classificationListing.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Listing', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
