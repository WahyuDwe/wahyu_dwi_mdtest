// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_remote_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRemoteSource)
final homeRemoteSourceProvider = HomeRemoteSourceProvider._();

final class HomeRemoteSourceProvider
    extends
        $FunctionalProvider<
          HomeRemoteSource,
          HomeRemoteSource,
          HomeRemoteSource
        >
    with $Provider<HomeRemoteSource> {
  HomeRemoteSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRemoteSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRemoteSourceHash();

  @$internal
  @override
  $ProviderElement<HomeRemoteSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRemoteSource create(Ref ref) {
    return homeRemoteSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRemoteSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRemoteSource>(value),
    );
  }
}

String _$homeRemoteSourceHash() => r'55cd6dcca03cdcb3c9508b9c8323ce7858d379e8';
