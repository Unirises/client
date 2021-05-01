// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_directions;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltDirections> _$builtDirectionsSerializer =
    new _$BuiltDirectionsSerializer();

class _$BuiltDirectionsSerializer
    implements StructuredSerializer<BuiltDirections> {
  @override
  final Iterable<Type> types = const [BuiltDirections, _$BuiltDirections];
  @override
  final String wireName = 'BuiltDirections';

  @override
  Iterable<Object?> serialize(Serializers serializers, BuiltDirections object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'routes',
      serializers.serialize(object.routes,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Routes)])),
    ];

    return result;
  }

  @override
  BuiltDirections deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltDirectionsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'routes':
          result.routes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Routes)]))!
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltDirections extends BuiltDirections {
  @override
  final BuiltList<Routes> routes;

  factory _$BuiltDirections([void Function(BuiltDirectionsBuilder)? updates]) =>
      (new BuiltDirectionsBuilder()..update(updates)).build();

  _$BuiltDirections._({required this.routes}) : super._() {
    BuiltValueNullFieldError.checkNotNull(routes, 'BuiltDirections', 'routes');
  }

  @override
  BuiltDirections rebuild(void Function(BuiltDirectionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltDirectionsBuilder toBuilder() =>
      new BuiltDirectionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltDirections && routes == other.routes;
  }

  @override
  int get hashCode {
    return $jf($jc(0, routes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltDirections')
          ..add('routes', routes))
        .toString();
  }
}

class BuiltDirectionsBuilder
    implements Builder<BuiltDirections, BuiltDirectionsBuilder> {
  _$BuiltDirections? _$v;

  ListBuilder<Routes>? _routes;
  ListBuilder<Routes> get routes =>
      _$this._routes ??= new ListBuilder<Routes>();
  set routes(ListBuilder<Routes>? routes) => _$this._routes = routes;

  BuiltDirectionsBuilder();

  BuiltDirectionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _routes = $v.routes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltDirections other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltDirections;
  }

  @override
  void update(void Function(BuiltDirectionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltDirections build() {
    _$BuiltDirections _$result;
    try {
      _$result = _$v ?? new _$BuiltDirections._(routes: routes.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'routes';
        routes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BuiltDirections', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
