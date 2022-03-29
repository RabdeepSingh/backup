import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  dynamic auth0AccessToken;
  dynamic idToken;
  dynamic id;
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;
  AuthService._internal();

  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Map<String, dynamic> parseIdToken(String idToken) {
    final List<String> parts = idToken.split('.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<bool> init() async {
    final storedRefreshToken =
        await secureStorage.read(key: 'REFRESH_TOKEN_KEY');

    if (storedRefreshToken == null) {
      return false;
    }

    try {
      final TokenResponse? result = await appAuth.token(
        TokenRequest(
          dotenv.env['AUTH0_CLIENT_ID'] as String,
          dotenv.env['AUTH0_REDIRECT_URI'] as String,
          issuer: dotenv.env['AUTH0_ISSUER'] as String,
          refreshToken: storedRefreshToken,
        ),
      );
      final String setResult = await _setLocalVariables(result);
      return setResult == 'Success';
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      // logOut() possibly
      return false;
    }
  }

  Future<String> login() async {
    try {
      final authorizationTokenRequest = AuthorizationTokenRequest(
        dotenv.env['AUTH0_CLIENT_ID'] as String,
        dotenv.env['AUTH0_REDIRECT_URI'] as String,
        issuer: dotenv.env['AUTH0_ISSUER'] as String,
        scopes: ['openid', 'profile', 'offline_access', 'email'],
        promptValues: ['login'],
      );

      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );

      return await _setLocalVariables(result);
    } on PlatformException {
      return 'User has cancelled or no internet!';
    } catch (e, s) {
      print('Login Uknown erorr $e, $s');
      return 'Unkown Error!';
    }
  }

  Future<String> _setLocalVariables(result) async {
    final bool isValidResult =
        result != null && result.accessToken != null && result.idToken != null;

    if (isValidResult) {
      id = result.idToken;
      auth0AccessToken = result.accessToken;
      idToken = parseIdToken(result.idToken!);

      if (result.refreshToken != null) {
        await secureStorage.write(
          key: 'REFRESH_TOKEN_KEY',
          value: result.refreshToken,
        );
      }

      return 'Success';
    } else {
      return 'Something is Wrong!';
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'REFRESH_TOKEN_KEY');
  }
}
