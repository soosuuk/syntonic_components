import 'dart:async';

import 'package:syntonic_components/services/error_handler_service.dart';

abstract class SyntonicRepository {
  /// Create an all [Models].
  Future<ErrorHandlerService<dynamic>>? createAll(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Create a [Model].
  Future<ErrorHandlerService<dynamic>>? createById(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Delete an all [Models].
  Future<ErrorHandlerService<dynamic>>? deleteAll(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Delete a [Model] by an any [Model.id].
  Future<ErrorHandlerService<dynamic>>? deleteById(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Get an all [Models].
  Future<ErrorHandlerService<dynamic>>? getAll(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Get a [Model] by an any [Model.id].
  Future<ErrorHandlerService<dynamic>>? getById(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Get a URL that download CSV file.
  Future<ErrorHandlerService<dynamic>>? getCsv(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Get a URL that download PDF file.
  Future<ErrorHandlerService<dynamic>>? getPdf(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Update an all [Models].
  Future<ErrorHandlerService<dynamic>>? updateAll(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();

  /// Update a [Model] by an any [Model.id].
  Future<ErrorHandlerService<dynamic>>? updateById(
          {bool isSynchronous = false,
          Function()? onSucceeded,
          Function()? onFailed}) =>
      throw UnimplementedError();
}
