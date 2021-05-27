import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';


/// Encrypt Util.
class EncryptUtil {

  static String urlEncode(dynamic data){
    return Uri.encodeQueryComponent(data.toString());
  }

  static String urlDecode(dynamic data){
    return Uri.decodeQueryComponent(data.toString());
  }

  /// md5 加密
  static String encodeMd5(String data) {
    var content = Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// 异或对称加密
  static String xorCode(String res, String key) {
    List<String> keyList = key.split(',');
    List<int> codeUnits = res.codeUnits;
    List<int> codes = [];
    for (int i = 0, length = codeUnits.length; i < length; i++) {
      int code = codeUnits[i] ^ int.parse(keyList[i % keyList.length]);
      codes.add(code);
    }
    return String.fromCharCodes(codes);
  }

  /// 异或对称 Base64 加密
  static String xorBase64Encode(String res, String key) {
    String encode = xorCode(res, key);
    encode = encodeBase64(encode);
    return encode;
  }

  /// 异或对称 Base64 解密
  static String xorBase64Decode(String res, String key) {
    String encode = decodeBase64(res);
    encode = xorCode(encode, key);
    return encode;
  }

  /// Base64加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解密
  static String decodeBase64(String data) {
    List<int> bytes = base64Decode(data);
    String result = utf8.decode(bytes);
    return result;
  }

  static Uint8List getByte(String str){
    return Uint8List.fromList(utf8.encode(str));
  }


  /// 听说是NonoLive延伟哥独创的加密算法
  static Uint8List n8Encode(List<int> key, Uint8List data){

    Uint8List dstBuf = Uint8List(data.length + 2);
    int mask = 0;

    for (int i = 0; i < data.length; i++) {
      dstBuf[i] = data[i] ^ key[i%key.length];
      mask ^= data[i];
    }

    dstBuf[data.length] = mask ^ key[0];
    dstBuf[data.length + 1] = mask ^ key[1];

    return dstBuf;
  }

  static Uint8List n8Decode(List<int> key, Uint8List data){
    Uint8List dstBuf = Uint8List(data.length - 2);
    int mask = 0;

    for( int i = 0; i < data.length - 2; i++ ){
      dstBuf[i] = data[i] ^ key[i % key.length];
      mask ^= dstBuf[i];
    }

    if( data[data.length - 2] == mask ^ key[0]
         && data[data.length - 1] == mask ^ key[1]){
      return dstBuf;
    }

    return null;
  }
}
