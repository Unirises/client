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
  Iterable<Object> serialize(Serializers serializers, Listing object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'classificationName',
      serializers.serialize(object.classificationName,
          specifiedType: const FullType(String)),
      'classificationListing',
      serializers.serialize(object.classificationListing,
          specifiedType: const FullType(
              BuiltList, const [const FullType(ClassificationListing)])),
      'editName',
      serializers.serialize(object.editName,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Listing deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'classificationName':
          result.classificationName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'classificationListing':
          result.classificationListing.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ClassificationListing)]))
              as BuiltList<Object>);
          break;
        case 'editName':
          result.editName = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
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
  @override
  final bool editName;

  factory _$Listing([void Function(ListingBuilder) updates]) =>
      (new ListingBuilder()..update(updates)).build();

  _$Listing._(
      {this.classificationName, this.classificationListing, this.editName})
      : super._() {
    if (classificationName == null) {
      throw new BuiltValueNullFieldError('Listing', 'classificationName');
    }
    if (classificationListing == null) {
      throw new BuiltValueNullFieldError('Listing', 'classificationListing');
    }
    if (editName == null) {
      throw new BuiltValueNullFieldError('Listing', 'editName');
    }
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
        classificationListing == other.classificationListing &&
        editName == other.editName;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, classificationName.hashCode),
            classificationListing.hashCode),
        editName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Listing')
          ..add('classificationName', classificationName)
          ..add('classificationListing', classificationListing)
          ..add('editName', editName))
        .toString();
  }
}

class ListingBuilder implements Builder<Listing, ListingBuilder> {
  _$Listing _$v;

  String _classificationName;
  String get classificationName => _$this._classificationName;
  set classificationName(String classificationName) =>
      _$this._classificationName = classificationName;

  ListBuilder<ClassificationListing> _classificationListing;
  ListBuilder<ClassificationListing> get classificationListing =>
      _$this._classificationListing ??=
          new ListBuilder<ClassificationListing>();
  set classificationListing(
          ListBuilder<ClassificationListing> classificationListing) =>
      _$this._classificationListing = classificationListing;

  bool _editName;
  bool get editName => _$this._editName;
  set editName(bool editName) => _$this._editName = editName;

  ListingBuilder();

  ListingBuilder get _$this {
    if (_$v != null) {
      _classificationName = _$v.classificationName;
      _classificationListing = _$v.classificationListing?.toBuilder();
      _editName = _$v.editName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Listing other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Listing;
  }

  @override
  void update(void Function(ListingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Listing build() {
    _$Listing _$result;
    try {
      _$result = _$v ??
          new _$Listing._(
              classificationName: classificationName,
              classificationListing: classificationListing.build(),
              editName: editName);
    } catch (_) {
      String _$failedField;
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
