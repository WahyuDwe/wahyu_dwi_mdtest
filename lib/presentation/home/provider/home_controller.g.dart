// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages search query state for filtering users

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

/// Manages search query state for filtering users
final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  /// Manages search query state for filtering users
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'3c36752ee11b18a9f1e545eb1a7209a7222d91c9';

/// Manages search query state for filtering users

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Manages active filter status

@ProviderFor(FilterStatus)
final filterStatusProvider = FilterStatusProvider._();

/// Manages active filter status
final class FilterStatusProvider
    extends $NotifierProvider<FilterStatus, UserFilter> {
  /// Manages active filter status
  FilterStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterStatusHash();

  @$internal
  @override
  FilterStatus create() => FilterStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserFilter>(value),
    );
  }
}

String _$filterStatusHash() => r'48062e0a785b18cbaf5ce00e68ab9d29ca5ea867';

/// Manages active filter status

abstract class _$FilterStatus extends $Notifier<UserFilter> {
  UserFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserFilter, UserFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserFilter, UserFilter>,
              UserFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Controller for home screen actions

@ProviderFor(HomeController)
final homeControllerProvider = HomeControllerProvider._();

/// Controller for home screen actions
final class HomeControllerProvider
    extends $NotifierProvider<HomeController, void> {
  /// Controller for home screen actions
  HomeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeControllerHash();

  @$internal
  @override
  HomeController create() => HomeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$homeControllerHash() => r'452d0e933bf6e694469fa29ac966850c84c3decf';

/// Controller for home screen actions

abstract class _$HomeController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provides filtered and searched list of users as a stream
/// Applies client-side filtering based on search query and filter status

@ProviderFor(userList)
final userListProvider = UserListProvider._();

/// Provides filtered and searched list of users as a stream
/// Applies client-side filtering based on search query and filter status

final class UserListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserEntity>>,
          List<UserEntity>,
          Stream<List<UserEntity>>
        >
    with $FutureModifier<List<UserEntity>>, $StreamProvider<List<UserEntity>> {
  /// Provides filtered and searched list of users as a stream
  /// Applies client-side filtering based on search query and filter status
  UserListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userListHash();

  @$internal
  @override
  $StreamProviderElement<List<UserEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<UserEntity>> create(Ref ref) {
    return userList(ref);
  }
}

String _$userListHash() => r'de159309700619b9535103b974adf5849f51d537';
