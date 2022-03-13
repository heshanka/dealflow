import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

///
/// Defines what methods the app can use to call an API
///
enum HttpMethod { GET, HEAD, POST, PUT, PATCH, DELETE }

const String  serviceDateFormat = "yyyy-MM-dd";
const String  serviceTimeFormat = "HH:mm:ss";
const String  serviceDateTimeFormat = "${serviceDateFormat}T$serviceTimeFormat";

abstract class Conveyor<T> {
  static const String  serverUrl = 'https://6228f84dbe12fc45389314be.mockapi.io/api/';

  String? getBlueprintName();

  T  createObject(Map<String , dynamic>? input);

  List<T >  createObjectList(List<dynamic>  input) {
    List<T >  returnList = [];
    for (var item in input) {
      returnList.add(createObject(item as Map<String , dynamic> ));
    }
    return returnList;
  }

  ///
  ///These are the methods used to send the requests
  ///
  static Map<HttpMethod , dynamic>  clientFunctions = {
    HttpMethod.GET: (url, headers, requestBody) => httpClient!.get(url, headers: headers),
    HttpMethod.HEAD: (url, headers, requestBody) => httpClient!.head(url, headers: headers),
    HttpMethod.POST: (url, headers, requestBody) => httpClient!.post(url, body: requestBody, headers: headers),
    HttpMethod.PUT: (url, headers, requestBody) => httpClient!.put(url, body: requestBody, headers: headers),
    HttpMethod.PATCH: (url, headers, requestBody) => httpClient!.patch(url, body: requestBody, headers: headers),
    HttpMethod.DELETE: (url, headers, requestBody) => httpClient!.delete(url, headers: headers),
  };

  static IOClient? httpClient;

  Future<Response?>  sendRequest(
      HttpMethod? method,
      String  endpointPath,
      Map<String , String >? headers, Map<String, String> map, {
        requestBody,
        Map<String , dynamic>? params,
        Map<String , dynamic>? queries,
        Duration? timeout,
      }) async {
    httpClient = httpClient ?? IOClient();

    Uri  url = Uri.parse(serverUrl + (getBlueprintName() ?? "") + endpointPath + fullArgsToString(params, queries));

    try {
      Future<Response >? future;
      Response  response;
      printRequest(url.toString(), method, headers, requestBody);

      future = clientFunctions[method!](url, headers, requestBody);

      if (future != null) {
        response = await future.timeout(timeout ?? Duration(seconds: 8));

        if (response != null /* == true */) {
          printResponseLog(method, response, url.toString());
          return response;
        }
      }
    } catch (exception) {
      print(exception);
    }
    return null;
  }

  Future<dynamic/*List<T >?*/>  sendGet({
    String  endpointPath = "",
    Map<String , String >? headers,
    Map<String , dynamic>? params,
    Map<String , dynamic>? queries,
    Duration? timeout,
  }) async {
    Response jsonMap = await sendRequest(
      HttpMethod.GET,
      endpointPath,
      headers, //?? await RequestHelper.getAuthHeader(),
        Map(),
      params: params,
      queries: queries,
      timeout: timeout
    ) as Response;
    //if (jsonMap != null && jsonMap['statuscode'] == 200)
      return jsonMap;//createObjectList(jsonMap);
    //else
      //return null;
  }

  Future<dynamic>  sendPost({
    String  endpointPath = "",
    dynamic requestBody,
    Map<String , String >? headers,
    Map<String , dynamic>? params,
    Map<String , dynamic>? queries,
    Duration? timeout,
  }) async {
    Future<Response?> jsonMap = sendRequest(
      HttpMethod.POST,
      endpointPath,
      headers, //?? await RequestHelper.getPostHeaders(),
        Map(),
      requestBody: requestBody,
      params: params,
      queries: queries,
      timeout: timeout
    );
    /*if (jsonMap != null && jsonMap['statuscode'] == 201)
      return createObject(jsonMap['data']);
    else
      return null;*/
    return jsonMap;
  }

  static FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static Future<Map<String, String>> getAuthHeader() async {
    String? accessToken = await secureStorage.read(key: "accessToken");
    if (accessToken != null && accessToken != "") {
      return {
        "Authorization": "bearer $accessToken",
      };
    } else {
      return {};
    }
  }

  static void printRequest(
      String  url,
      HttpMethod? method,
      headers,
      requestBody,
      ) {
    String  httpMethod = method != null ? method.toString().substring(11) : "";
    String  header = headers != null ? headers.toString() + "\n" : "";
    String  returnString = "▲▲▲ $httpMethod $url\n$header\n";

    if (method == HttpMethod.POST && requestBody != null) {
      returnString += "Request Body: $requestBody\n";
    }

    print(returnString);
  }

  void printResponse(HttpMethod? method, String  response, int  statusCode, String  url) {
    String  returnString = "▼▼▼ $statusCode $url\nResponse Body: $response";

    print(returnString);
  }

  void printResponseLog(HttpMethod? method, Response  response, String  url) {
    printResponse(method, response.body, response.statusCode, url);
  }

  static String  fullArgsToString(Map<String , dynamic>? params, Map<String , dynamic>? queries) {
    String  returnString = "";
    String  paramsStr = argsToString(params);
    String  queriesStr = queryArgToString(queries);
    if (paramsStr != "") {
      paramsStr = "?$paramsStr";
      returnString = paramsStr;
      if (queriesStr != "") {
        returnString = "$returnString&" + queriesStr;
      }
    } else if (queriesStr != "") {
      queriesStr = "?$queriesStr";
      returnString = queriesStr;
    }
    return returnString;
  }

  static String  argsToString(Map<String , dynamic>? params) {
    String  ret = "";
    if (params == null) {
      return ret;
    }
    params.forEach((key, value) {
      ret = "${ret != "" ? ret + "&" : ret}$key=$value";
    });
    return ret != "" ? "$ret" : ret;
  }

  static String  queryArgToString(Map<String , dynamic>? params) {
    String  returnString = "";
    if (params == null) {
      return returnString;
    }
    params.forEach((key, value) {
      returnString = "${returnString != "" ? returnString + "," : returnString}$key:$value";
    });
    return returnString != "" ? "query=$returnString" : returnString;
  }
}