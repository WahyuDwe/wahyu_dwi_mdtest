// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_email_verification_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncEmailVerificationUseCase)
final syncEmailVerificationUseCaseProvider =
    SyncEmailVerificationUseCaseProvider._();

final class SyncEmailVerificationUseCaseProvider
    extends
        $FunctionalProvider<
          SyncEmailVerificationUseCase,
          SyncEmailVerificationUseCase,
          SyncEmailVerificationUseCase
        >
    with $Provider<SyncEmailVerificationUseCase> {
  SyncEmailVerificationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncEmailVerificationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncEmailVerificationUseCaseHash();

  @$internal
  @override
  $ProviderElement<SyncEmailVerificationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SyncEmailVerificationUseCase create(Ref ref) {
    return syncEmailVerificationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncEmailVerificationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncEmailVerificationUseCase>(value),
    );
  }
}

String _$syncEmailVerificationUseCaseHash() =>
    r'8c092388647510a257db0078b44b73be5318c76a';
