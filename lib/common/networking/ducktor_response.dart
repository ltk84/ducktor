import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ducktor_response.freezed.dart';

@freezed
class DucktorResponse with _$DucktorResponse {
  const factory DucktorResponse.success(Map<String, dynamic> data) = OK;
  const factory DucktorResponse.error(String message) = ERROR;
  const factory DucktorResponse.loading(String message) = LOADING;
}
