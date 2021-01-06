// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Bounds.serializer)
      ..add(BuiltDirections.serializer)
      ..add(BuiltPosition.serializer)
      ..add(BuiltRequest.serializer)
      ..add(BuiltStop.serializer)
      ..add(Distance.serializer)
      ..add(DistanceDuration.serializer)
      ..add(Legs.serializer)
      ..add(Location.serializer)
      ..add(OverviewPolyline.serializer)
      ..add(Routes.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(BuiltStop)]),
          () => new ListBuilder<BuiltStop>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Legs)]),
          () => new ListBuilder<Legs>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Routes)]),
          () => new ListBuilder<Routes>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
