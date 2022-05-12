abstract class IFirebaseRemoteConfig {
  Future<void> initialize();
  Future<void> forceFetch();

  T getValueOrDefault<T>({required String key, required T defaultValue});
}
