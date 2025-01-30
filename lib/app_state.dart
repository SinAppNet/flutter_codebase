import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/schema/structs/index.dart';
import 'backend/supabase/supabase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_currentUser') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_currentUser') ?? '{}';
          _currentUser =
              CurrentUserStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _filtroOn = await secureStorage.getBool('ff_filtroOn') ?? _filtroOn;
    });
    await _safeInitAsync(() async {
      _initAvance = await secureStorage.getBool('ff_initAvance') ?? _initAvance;
    });
    await _safeInitAsync(() async {
      _invited = await secureStorage.getBool('ff_invited') ?? _invited;
    });
    await _safeInitAsync(() async {
      _referCodeOnSignin =
          await secureStorage.getString('ff_referCodeOnSignin') ??
              _referCodeOnSignin;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  CurrentUserStruct _currentUser = CurrentUserStruct();
  CurrentUserStruct get currentUser => _currentUser;
  set currentUser(CurrentUserStruct value) {
    _currentUser = value;
    secureStorage.setString('ff_currentUser', value.serialize());
  }

  void deleteCurrentUser() {
    secureStorage.delete(key: 'ff_currentUser');
  }

  void updateCurrentUserStruct(Function(CurrentUserStruct) updateFn) {
    updateFn(_currentUser);
    secureStorage.setString('ff_currentUser', _currentUser.serialize());
  }

  bool _filtroOn = false;
  bool get filtroOn => _filtroOn;
  set filtroOn(bool value) {
    _filtroOn = value;
    secureStorage.setBool('ff_filtroOn', value);
  }

  void deleteFiltroOn() {
    secureStorage.delete(key: 'ff_filtroOn');
  }

  FiltroAplicadoStruct _filtroAplied = FiltroAplicadoStruct();
  FiltroAplicadoStruct get filtroAplied => _filtroAplied;
  set filtroAplied(FiltroAplicadoStruct value) {
    _filtroAplied = value;
  }

  void updateFiltroApliedStruct(Function(FiltroAplicadoStruct) updateFn) {
    updateFn(_filtroAplied);
  }

  bool _initAvance = false;
  bool get initAvance => _initAvance;
  set initAvance(bool value) {
    _initAvance = value;
    secureStorage.setBool('ff_initAvance', value);
  }

  void deleteInitAvance() {
    secureStorage.delete(key: 'ff_initAvance');
  }

  bool _invited = false;
  bool get invited => _invited;
  set invited(bool value) {
    _invited = value;
    secureStorage.setBool('ff_invited', value);
  }

  void deleteInvited() {
    secureStorage.delete(key: 'ff_invited');
  }

  String _referCodeOnSignin = '';
  String get referCodeOnSignin => _referCodeOnSignin;
  set referCodeOnSignin(String value) {
    _referCodeOnSignin = value;
    secureStorage.setString('ff_referCodeOnSignin', value);
  }

  void deleteReferCodeOnSignin() {
    secureStorage.delete(key: 'ff_referCodeOnSignin');
  }

  final _cardManager = FutureRequestManager<List<ConexaoRow>>();
  Future<List<ConexaoRow>> card({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ConexaoRow>> Function() requestFn,
  }) =>
      _cardManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCardCache() => _cardManager.clear();
  void clearCardCacheKey(String? uniqueKey) =>
      _cardManager.clearRequest(uniqueKey);

  final _notifiesManager = FutureRequestManager<List<NotificationsRow>>();
  Future<List<NotificationsRow>> notifies({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<NotificationsRow>> Function() requestFn,
  }) =>
      _notifiesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearNotifiesCache() => _notifiesManager.clear();
  void clearNotifiesCacheKey(String? uniqueKey) =>
      _notifiesManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
