import 'package:dio/dio.dart';
import 'package:ducktor/common/networking/ducktor_header.dart';
import 'package:ducktor/common/networking/ducktor_request_parameter.dart';
import 'package:ducktor/common/networking/ducktor_response.dart';
import 'package:ducktor/common/networking/network_client/network_logging.dart';
import 'package:ducktor/common/networking/networking_constant.dart';
import 'package:flutter/cupertino.dart';

class NetworkClient {
  static final _instance = NetworkClient._internalConstructor();

  NetworkClient._internalConstructor();

  factory NetworkClient(String endPoint) {
    final parseURI = Uri.tryParse(endPoint);
    if (parseURI != null) {
      _instance.baseUrl = Uri.http(endPoint);
      _instance.dioClient = Dio(BaseOptions(
        baseUrl: _instance.baseUrl.toString(),
        connectTimeout: NetworkingConstant.apiConnectTimeout,
        sendTimeout: NetworkingConstant.apiSendTimeout,
        receiveTimeout: NetworkingConstant.apiReceiveTimeout,
      ));

      _instance.dioClient.interceptors.add(Logging(_instance.dioClient));
    } else {
      debugPrint('endPoint $endPoint is not an valid URL');
      throw 'endPoint $endPoint is not an valid URL';
    }

    return _instance;
  }

  late final Uri baseUrl;
  late final Dio dioClient;

  Future<DucktorResponse?> request<T>(
    RequestMethod method,
    String path,
    DucktorRequestParameter? requestParameters,
    DucktorHeader header,
  ) async {
    late Response result;
    try {
      final options = Options(headers: header.requestHeader);
      switch (method) {
        case RequestMethod.get:
          result = await dioClient.get(path,
              queryParameters: requestParameters?.requestParameter,
              options: options);
          break;
        case RequestMethod.post:
          result = await dioClient.post(path,
              data: requestParameters?.requestParameter, options: options);
          break;
        case RequestMethod.put:
          result = await dioClient.put(path,
              data: requestParameters?.requestParameter, options: options);
          break;
        case RequestMethod.patch:
          result = await dioClient.patch(path,
              data: requestParameters?.requestParameter);
          break;
        case RequestMethod.delete:
          result = await dioClient.delete(path,
              data: requestParameters?.requestParameter);
          break;
      }

      final statusCode = result.statusCode;
      if (statusCode != null && statusCode >= 200 && statusCode <= 299) {
        return DucktorResponse.success(result.data);
      }

      return const DucktorResponse.error('Data is null');
    } on DioError catch (error) {
      return DucktorResponse.error(error.message);
    } catch (error) {
      return DucktorResponse.error(error.toString());
    }
  }
}
