// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentUserUseCase)
final currentUserUseCaseProvider = CurrentUserUseCaseProvider._();

final class CurrentUserUseCaseProvider
    extends
        $FunctionalProvider<
          CurrentUserUseCase,
          CurrentUserUseCase,
          CurrentUserUseCase
        >
    with $Provider<CurrentUserUseCase> {
  CurrentUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserUseCaseHash();

  @$internal
  @override
  $ProviderElement<CurrentUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CurrentUserUseCase create(Ref ref) {
    return currentUserUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentUserUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentUserUseCase>(value),
    );
  }
}

String _$currentUserUseCaseHash() =>
    r'829465859a678b700b78ac6846ce1be2f8c4c6e0';
