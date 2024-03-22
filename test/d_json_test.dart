import 'package:flutter_test/flutter_test.dart';

import 'package:d_json/d_json.dart';

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

void main() {
  group('json', () {
    test('string type', () {
      final json = DJson(data);
      expect(json['message'].stringValue, '成功');
      expect(json['message'].stringValue is String, true);
      expect(json['message'].stringOrEmpty, '成功');
      expect(json['message'].stringOrDefValue(''), '成功');
      expect(json['message1'].stringValue, null);
      expect(json['message1'].stringOrEmpty, '');
      expect(json['message1'].stringOrDefValue('123'), '123');
      expect(json['pageSize'].forceToString, '20');
      expect(json['pageSize1'].forceToString, 'null');
    });
    test('num type', () {
      final json = DJson(data);
      expect(json['total'].numValue, 192);
      expect(json['total'].numOrZero, 192);
      expect(json['total'].numOrDefValue(123), 192);
      expect(json['total1'].numValue, null);
      expect(json['total1'].numOrZero, 0);
      expect(json['total1'].numOrDefValue(123), 123);
      expect(json['code'].forceToNum, 0);
      expect(json['payload'][0]['priceStr'].forceToNum, 119.8);
    });

    test('test option value', () {
      final json = DJson(data);

      expect(json['payload'][0]["shopInfo"]["shopName"].stringValue, '四维图书专营店');
      expect(json['message1'].stringValue, null);
      expect(json['pageSize'].intValue, 20);
      expect(json['total1'].intValue, null);
      expect(json['payload'][0]["price"].doubleValue, 119.8);
      expect(json['pageIndex1'].doubleValue, null);
      expect(json['payload'][0]["isMember"].boolValue, true);
      expect(json['bool1'].boolValue, null);
      expect(json['payload'][0]["couponList"].listValue, [
        {
          "quota": 115,
          "link":
              "http://coupon.m.jd.com/coupons/show.action?linkKey=AAROH_xIpeffAs_-naABEFoeUbAT-bFsQXW_QVwYsO047q8BYGC7i_nyOUgXUQ-IMOhWdG8CMP97-OiQ_sOjYkzPMC93qQ&amp;to=www.jd.com",
          "discount": 90,
          "type": 3
        }
      ]);
    });

    test('test value', () {
      final json = DJson(data);
      expect(json['payload'][0]["shopInfo"]["shopName"].stringOrEmpty, '四维图书专营店');
      expect(json['payload'][1]["shopInfo"]["shopName"].stringOrEmpty, '');
      expect(json['total'].intOrZero, 192);
      expect(json['total1'].intOrZero, 0);
      expect(json['payload'][0]["price"].doubleOrZero, 119.8);
      expect(json['payload'][1]["price"].doubleOrZero, 0);
      expect(json['payload'][0]["isMember"].boolOrFalse, true);
      expect(json['payload'][1]["isMember"].boolOrFalse, false);
      expect(json['payload'][0]["shopInfo"].mapOrEmpty, {"shopId": 10330852, "shopName": "四维图书专营店"});
      expect(json['payload'][1]["shopInfo"].mapOrEmpty, {});
      expect(json['payload'][0]["couponList"].listOrEmpty, [
        {
          "quota": 115,
          "link":
              "http://coupon.m.jd.com/coupons/show.action?linkKey=AAROH_xIpeffAs_-naABEFoeUbAT-bFsQXW_QVwYsO047q8BYGC7i_nyOUgXUQ-IMOhWdG8CMP97-OiQ_sOjYkzPMC93qQ&amp;to=www.jd.com",
          "discount": 90,
          "type": 3
        }
      ]);
    });

    test('force value', () {
      final json = DJson(data);
      // String
      expect(json['pageSize'].forceToString, '20');
      expect(json['payload'][0]["isMember"].forceToString, 'true');
      expect(json['payload'][0]["price"].forceToString, '119.8');
      // int
      expect(json['payload'][0]["pid"].forceToInt, 1234);
      expect(json['payload'][0]["price"].forceToInt, 119);
      expect(json['payload'][0]["isMember"].forceToInt, 1);
      // double
      expect(json['pageSize'].forceToDouble, 20);
      expect(json['payload'][0]["priceStr"].forceToDouble, 119.8);
      expect(json['payload'][0]["isMember"].forceToDouble, 1);
    });

    test('test force1', () {
      final map = {
        "a": '123',
        'b': '123a',
        'c': '0xff',
        'd': 'a123',
        'e': ' 123 ',
        'f': '0.7',
        'g': '123.7',
      };
      final json = DJson(map);
      expect(json['a'].forceToInt, 123);
      expect(json['b'].forceToInt, null);
      expect(json['c'].forceToInt, 255);
      expect(json['d'].forceToInt, null);
      expect(json['e'].forceToInt, 123);
      expect(json['f'].forceToInt, 0);
      expect(json['g'].forceToInt, 123);
    });
  });
}
