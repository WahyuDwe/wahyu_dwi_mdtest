// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUsersUseCase)
final getUsersUseCaseProvider = GetUsersUseCaseProvider._();

final class GetUsersUseCaseProvider
    extends
        $FunctionalProvider<GetUsersUseCase, GetUsersUseCase, GetUsersUseCase>
    with $Provider<GetUsersUseCase> {
  GetUsersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUsersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUsersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUsersUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetUsersUseCase create(Ref ref) {
    return getUsersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUsersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUsersUseCase>(value),
    );
  }
}

String _$getUsersUseCaseHash() => r'a8a39b535589ff20b8a9cab1f250be88677ce7db';
