import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:simple_rc4/simple_rc4.dart';

class ApiUtil {
  static String token(String paramString1, String paramString2, String paramString3, int paramLong, String paramString4) {
    String localString = paramString1 + paramString2 + paramString3 + paramLong.toString() + paramString4;
    print('token生成前:\t' + localString);
    localString = _initMd5(_initSha1(localString));
    print('token生成后:\t' + localString);
    return localString;
  }

  // md5 加密
  static String _initMd5(String data) {
    var digest = md5.convert(utf8.encode(data));
    return hex.encode(digest.bytes);
  }

  static String _initSha1(String data) {
    var digest = sha1.convert(utf8.encode(data));
    return hex.encode(digest.bytes);
  }

  static String rc4Decode(String value,{String id = '',bool base64 = true}){
    RC4 rc4 =RC4(_initMd5('aibang'+id));
    return rc4.decodeString(value,base64);
  }

  static String rc4Encode(String value,{String id = '',bool base64 = true}){
    RC4 rc4 = RC4(_initMd5('aibang'+id));
    return rc4.encodeString(value,base64);
  }

  static String utf8Encode(String value){
    value = rc4Encode(value);
    return value.replaceAll('/', "*").replaceAll('+', '~');
  }

  static String utf8Decode(String value){
    value = value.replaceAll('*', "/").replaceAll('~', "+");
    return rc4Decode(value);
  }
}
