import '../result/result.dart';

class Command<T, P> {
  final Future<Result<T>> Function(P params) _action;

  Command(this._action);

  Future<Result<T>> execute(P params) async {
    return await _action(params);
  }
}

class CommandNoParams<T> {
  final Future<Result<T>> Function() _action;

  CommandNoParams(this._action);

  Future<Result<T>> execute() async {
    return await _action();
  }
}
