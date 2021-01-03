// GENERATED CODE - DO NOT MODIFY BY HAND

part of overview_polyline;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OverviewPolyline> _$overviewPolylineSerializer =
    new _$OverviewPolylineSerializer();

class _$OverviewPolylineSerializer
    implements StructuredSerializer<OverviewPolyline> {
  @override
  final Iterable<Type> types = const [OverviewPolyline, _$OverviewPolyline];
  @override
  final String wireName = 'OverviewPolyline';

  @override
  Iterable<Object> serialize(Serializers serializers, OverviewPolyline object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'points',
      serializers.serialize(object.points,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  OverviewPolyline deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OverviewPolylineBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'points':
          result.points = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OverviewPolyline extends OverviewPolyline {
  @override
  final String points;

  factory _$OverviewPolyline(
          [void Function(OverviewPolylineBuilder) updates]) =>
      (new OverviewPolylineBuilder()..update(updates)).build();

  _$OverviewPolyline._({this.points}) : super._() {
    if (points == null) {
      throw new BuiltValueNullFieldError('OverviewPolyline', 'points');
    }
  }

  @override
  OverviewPolyline rebuild(void Function(OverviewPolylineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OverviewPolylineBuilder toBuilder() =>
      new OverviewPolylineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OverviewPolyline && points == other.points;
  }

  @override
  int get hashCode {
    return $jf($jc(0, points.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OverviewPolyline')
          ..add('points', points))
        .toString();
  }
}

class OverviewPolylineBuilder
    implements Builder<OverviewPolyline, OverviewPolylineBuilder> {
  _$OverviewPolyline _$v;

  String _points;
  String get points => _$this._points;
  set points(String points) => _$this._points = points;

  OverviewPolylineBuilder();

  OverviewPolylineBuilder get _$this {
    if (_$v != null) {
      _points = _$v.points;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OverviewPolyline other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OverviewPolyline;
  }

  @override
  void update(void Function(OverviewPolylineBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OverviewPolyline build() {
    final _$result = _$v ?? new _$OverviewPolyline._(points: points);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
