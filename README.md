# d_json
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/zenganiu/d_json)
## **Dart JSON处理库**
* 在`dart`语言中json数据序列化后的数据类型是Map或者List的实例，当嵌套比较深时，取用其中数据，需要层层判断key不存在或数组越界，结构趋向复杂。使用`d_json`可简单快速获取任意层次数据。
* 请大佬们多多指教，给个 Star，你的支持就是我不断前进的动力，谢谢。
## 特性
* 支持下标语法多级Map、List混用取值
* 使用简单且安全

## 安装
在 `pubspec.yaml` 中添加
```yaml
dependencies:
  d_json: ^0.0.1
```

## 使用

```dart
// 测试数据
final data = {
  "code": "00000",
  "message": "成功",
  "payload": [
    {
      "goodsId": "10039353087490",
      "goodsName": "全20册儿童奇妙大自然科普百科儿童绘本3-6岁 幼儿园中大班宝宝启蒙认知睡前故事书彩图注音版 儿童情商逆商培养反霸凌启蒙绘本 奇妙大自然科普绘本全套20册",
      "bandName": "荷甄",
      "monthSales": 0,
      "price": 119.8,
      "priceStr": "119.8",
      "isMember": true,
      "lowestCouponPrice": 29.8,
      "szmfPrice": 27.12,
      "commission": 2.68,
      "goodsUrl": "item.jd.com/10039353087490.html",
      "couponList": [
        {
          "quota": 115,
          "link":
              "http://coupon.m.jd.com/coupons/show.action?linkKey=AAROH_xIpeffAs_-naABEFoeUbAT-bFsQXW_QVwYsO047q8BYGC7i_nyOUgXUQ-IMOhWdG8CMP97-OiQ_sOjYkzPMC93qQ&amp;to=www.jd.com",
          "discount": 90,
          "type": 3
        }
      ],
      "shopInfo": {"shopId": 10330852, "shopName": "四维图书专营店"},
      "mainPic": "https://img14.360buyimg.com/pop/jfs/t1/203268/1/21329/420195/62562364E75f53dfb/0a1bd80dd3815873.jpg",
      "jumpLink": null,
      "pid": "1234"
    },
  ],
  "pageIndex": 1,
  "pageSize": 20,
  "total": 192
};
```
要取出第一条数据的shopName数据
* 常规用法，由于List或Map为null时，下标取值会抛异常，为了代码安全需要层层判断
```dart

String shopName = '';
//
if (data['payload'] is List &&
(data['payload'] as List).isNotEmpty &&
(data['payload'] as List)[0] is Map &&
(data['payload'] as List)[0]['shopInfo'] is Map &&
(data['payload'] as List)[0]['shopInfo']['shopName'] is String) {
  shopName = (data['payload'] as List)[0]['shopInfo']['shopName'] as String;
}

```
* 使用`d_json`
```dart
final shopName = DJson(data)['payload'][0]['shopInfo']['shopName'].StringValue;
```


##### **初始化**
```dart
import 'package:d_json/d_json.dart';

// 数据为Map或List数据时
final json = DJson(data);

// 数据为JsonString数据时
final json = DJson.fromJsonStr(data);

```
##### 下标语法
支持List中下标、Map中key值多层级混用
```dart
 // data数据中取出第一条数据的shopName数据
final shopName = DJson(data)['payload'][0]['shopInfo']['shopName'].StringValue;

// 获取data中message数据，不存在时返回默认值
final message = DJson(data)['message'].stringOrDefValue('未知错误');

// 获取data中第一条数据中的价格
final price = DJson(data)['payload'][0]['price'].doubleValue;
```

##### **常用类型**
```dart
// 初始化
final json = DJson(data);

// 返回可选类型，类型匹配且存在才有值，否则返回null
final _ = json["xxx"].stringValue; // 获取可选String
final _ = json["xxx"].numValue; // 获取可选num
final _ = json["xxx"].intValue; // 获取可选int
final _ = json["xxx"].doubleValue; // 获取可选double
final _ = json["xxx"].boolValue; // 获取可选bool
final _ = json["xxx"].mapValue; // 获取可选Map
final _ = json["xxx"].listValue; // 获取可选List

// 返回不为空的类型，类型匹配且存在才有值，否则返回默认值
final _ = json["xxx"].stringOrDefValue(''); // 获取String
final _ = json["xxx"].numOrDefValue(0); // 获取num
final _ = json["xxx"].intOrDefValue(0); // 获取int
final _ = json["xxx"].doubleOrDefValue(0); // 获取double
final _ = json["xxx"].boolOrDefValue(true); // 获取bool
final _ = json["xxx"].mapOrDefValue({}); // 获取Map
final _ = json["xxx"].listOrDefValue([1,2]); // 获取List

// 类型不匹配，强制转换
final _ = json["xxx"].forceToString; // 获取String
final _ = json["xxx"].forceToNum; // 获取num
final _ = json["xxx"].forceToInt; // 获取int
final _ = json["xxx"].forceToDouble; // 获取double
final _ = json["xxx"].forceToBool; // 获取bool

// 常用默认值
final _ = json["xxx"].stringOrEmpty; // 获取String,不存在返回默认值""
final _ = json["xxx"].numOrZero; // 获取num,不存在返回默认值0
final _ = json["xxx"].intOrZero; // 获取int,不存在返回默认值0
final _ = json["xxx"].doubleOrZero; // 获取double,不存在返回默认值0
final _ = json["xxx"].boolOrFalse; // 获取bool,不存在返回默认值false
final _ = json["xxx"].mapOrEmpty; // 获取Map,不存在返回默认值{}
final _ = json["xxx"].listOrEmpty; // 获取List,不存在返回默认值[]


```




