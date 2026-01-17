import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_provider.g.dart';

@riverpod
class Query extends _$Query {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}
