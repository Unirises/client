// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_request;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltVehicleData> _$builtVehicleDataSerializer =
    new _$BuiltVehicleDataSerializer();

class _$BuiltVehicleDataSerializer
    implements StructuredSerializer<BuiltVehicleData> {
  @override
  final Iterable<Type> types = const [BuiltVehicleData, _$BuiltVehicleData];
  @override
  final String wireName = 'BuiltVehicleData';

  @override
  Iterable<Object?> serialize(Serializers serializers, BuiltVehicleData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'brand',
      serializers.serialize(object.brand,
          specifiedType: const FullType(String)),
      'color',
      serializers.serialize(object.color,
          specifiedType: const FullType(String)),
      'model',
      serializers.serialize(object.model,
          specifiedType: const FullType(String)),
      'plate',
      serializers.serialize(object.plate,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BuiltVehicleData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltVehicleDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'model':
          result.model = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'plate':
          result.plate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltVehicleData extends BuiltVehicleData {
  @override
  final String brand;
  @override
  final String color;
  @override
  final String model;
  @override
  final String plate;

  factory _$BuiltVehicleData(
          [void Function(BuiltVehicleDataBuilder)? updates]) =>
      (new BuiltVehicleDataBuilder()..update(updates)).build();

  _$BuiltVehicleData._(
      {required this.brand,
      required this.color,
      required this.model,
      required this.plate})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(brand, 'BuiltVehicleData', 'brand');
    BuiltValueNullFieldError.checkNotNull(color, 'BuiltVehicleData', 'color');
    BuiltValueNullFieldError.checkNotNull(model, 'BuiltVehicleData', 'model');
    BuiltValueNullFieldError.checkNotNull(plate, 'BuiltVehicleData', 'plate');
  }

  @override
  BuiltVehicleData rebuild(void Function(BuiltVehicleDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltVehicleDataBuilder toBuilder() =>
      new BuiltVehicleDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltVehicleData &&
        brand == other.brand &&
        color == other.color &&
        model == other.model &&
        plate == other.plate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, brand.hashCode), color.hashCode), model.hashCode),
        plate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltVehicleData')
          ..add('brand', brand)
          ..add('color', color)
          ..add('model', model)
          ..add('plate', plate))
        .toString();
  }
}

class BuiltVehicleDataBuilder
    implements Builder<BuiltVehicleData, BuiltVehicleDataBuilder> {
  _$BuiltVehicleData? _$v;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _plate;
  String? get plate => _$this._plate;
  set plate(String? plate) => _$this._plate = plate;

  BuiltVehicleDataBuilder();

  BuiltVehicleDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _brand = $v.brand;
      _color = $v.color;
      _model = $v.model;
      _plate = $v.plate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltVehicleData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltVehicleData;
  }

  @override
  void update(void Function(BuiltVehicleDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltVehicleData build() {
    final _$result = _$v ??
        new _$BuiltVehicleData._(
            brand: BuiltValueNullFieldError.checkNotNull(
                brand, 'BuiltVehicleData', 'brand'),
            color: BuiltValueNullFieldError.checkNotNull(
                color, 'BuiltVehicleData', 'color'),
            model: BuiltValueNullFieldError.checkNotNull(
                model, 'BuiltVehicleData', 'model'),
            plate: BuiltValueNullFieldError.checkNotNull(
                plate, 'BuiltVehicleData', 'plate'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
