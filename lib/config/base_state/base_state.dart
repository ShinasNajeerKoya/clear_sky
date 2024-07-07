class BaseState {
  DataState dataState;

  BaseState({this.dataState = DataState.init});
}

enum DataState {
  init,
  loading,
  reloading,
  success,
  error,
}
