library d_json;

import 'dart:convert';

/// JSON对象
class DJson {
  /// value
  final dynamic _value;

  /// 构造函数
  DJson(this._value);

  /// 从json格式字符串初始化
  factory DJson.fromJsonStr(String jsonStr) {
    try {
      final v = jsonDecode(jsonStr);
      return DJson(v);
    } catch (e) {
      return DJson(null);
    }
  }

  /// 下标操作符
  DJson operator [](dynamic key) {
    if (_value is Map) return DJson((_value as Map)[key]);
    if (_value is List) return DJson((_value as List).asMap()[key]);
    return DJson(null);
  }
}

/// 扩展
extension ExDJson on DJson {
  /// 原始数据
  dynamic get rawValue => _value;
  /**************************************************************************/
  /// 获取可选String,类型匹配才有值
  String? get stringValue => _value is String ? _value as String : null;

  /// 获取可选num,类型匹配才有值
  num? get numValue => _value is num ? _value as num : null;

  /// 获取可选int，类型匹配才有值
  int? get intValue => numValue?.toInt();

  /// 获取可选double，类型匹配才有值
  double? get doubleValue => numValue?.toDouble();

  /// 获取可选bool,类型匹配才有值
  bool? get boolValue => _value is bool ? _value as bool : null;

  /// 获取可选Map, 类型匹配才有值
  Map<dynamic, dynamic>? get mapValue => _value is Map ? _value as Map : null;

  /// 获取可选List, 类型匹配才有值
  List<dynamic>? get listValue => _value is List ? _value as List : null;

  /**************************************************************************/

  /// 获取String值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  String stringOrDefValue(String defValue) {
    return stringValue ?? defValue;
  }

  /// 获取num值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  num numOrDefValue(num defValue) {
    return numValue ?? defValue;
  }

  /// 获取int值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  int intOrDefValue(int defValue) {
    return intValue ?? defValue;
  }

  /// 获取double值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  double doubleOrDefValue(double defValue) {
    return doubleValue ?? defValue;
  }

  /// 获取bool值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  bool boolOrDefValue(bool defValue) {
    return boolValue ?? defValue;
  }

  /// 获取Map值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  Map<dynamic, dynamic> mapOrDefValue(Map<dynamic, dynamic> defValue) {
    return mapValue ?? defValue;
  }

  /// 获取Map值，不存在时返回默认值
  ///
  /// [defValue] 默认值
  List<dynamic> listOrDefValue(List<dynamic> defValue) {
    return listValue ?? defValue;
  }

  /// 获取String值，类型匹配才有值，默认''
  String get stringOrEmpty => stringOrDefValue('');

  /// 获取num值，类型匹配才有值，默认0
  num get numOrZero => numOrDefValue(0);

  /// 获取int值，类型匹配才有值，默认0
  int get intOrZero => intOrDefValue(0);

  /// 获取double值，类型匹配才有值，默认0
  double get doubleOrZero => doubleOrDefValue(0);

  /// 获取bool值,类型匹配才有值，默认false
  bool get boolOrFalse => boolOrDefValue(false);

  /// 获取Map, 类型匹配才有值
  Map<dynamic, dynamic> get mapOrEmpty => mapOrDefValue({});

  /// 获取List, 类型匹配才有值
  List<dynamic> get listOrEmpty => listOrDefValue([]);

  /**************************************************************************/
  /// 将值强制转为String, 包括(int,double,bool,List,Map)
  String get forceToString => rawValue.toString();

  /// 将值强制转为String,包括(int,double,bool,string)
  ///
  /// String类型将使用num.tryParse(rawValue)尝试转换
  /// bool类型返回 1(true)或0(false)
  num? get forceToNum {
    if (rawValue is num) {
      return rawValue as num;
    } else if (rawValue is String) {
      return num.tryParse(rawValue);
    } else if (rawValue is bool) {
      return (rawValue as bool) == true ? 1 : 0;
    }
    return null;
  }

  /// 将值强制转为int,包括(int,double,bool,string)
  ///
  /// String类型将使用num.tryParse(rawValue)尝试转换
  /// bool类型返回 1(true)或0(false)
  int? get forceToInt => forceToNum?.toInt();

  /// 将值强制转为double,包括(int,double,bool,string)
  ///
  /// String类型将使用num.tryParse(rawValue)尝试转换
  /// bool类型返回 1(true)或0(false)
  double? get forceToDouble => forceToNum?.toDouble();

  /// 将值强制转为bool,包括(int,double,bool,string)
  ///
  /// String类型只有true/false转换
  /// num类型只有0(false)和1(true)转换
  bool? get forceToBool {
    if (rawValue is bool) {
      return rawValue as bool;
    } else if (rawValue is String) {
      if ((rawValue as String).toLowerCase() == 'true') {
        return true;
      }
      if ((rawValue as String).toLowerCase() == 'false') {
        return false;
      }
    } else if (rawValue is num) {
      if ((rawValue as num) == 1) {
        return true;
      }
      if ((rawValue as num) == 0) {
        return false;
      }
    }
    return null;
  }
}
