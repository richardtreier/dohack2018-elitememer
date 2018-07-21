import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

class ApiService {
  final apiEndpoint = "https://elitememers.cfapps.io/graphql";

  Future<T> fetchGraphQL<T>(
      String query,
      bool isMutation,
      Map<String, dynamic> variables,
      T fromJson(Map<String, dynamic> json)) async {
    Map payload;
    if (isMutation) {
      payload = <String, dynamic>{"mutation": query, "variables": variables};
    } else {
      payload = <String, dynamic>{"query": query, "variables": variables};
    }

    final httpResponse =
        await http.post(apiEndpoint, body: json.encode(payload));

    print(httpResponse);
    if (httpResponse.statusCode != 200) {
      throw Exception("Bad Status Code!" + httpResponse.statusCode.toString());
    }
    print(httpResponse.body);
    print(json.decode(httpResponse.body));

    final Map<String, dynamic> responseJson = json.decode(httpResponse.body);
    final Map<String, dynamic> responseErrors = responseJson["errors"];
    final Map<String, dynamic> responseData = responseJson["data"];

    if (responseErrors != null) {
      print("GraphQL Response: Errors: ");
      responseErrors;
    }

    if (responseData != null) {
      return fromJson(responseData);
    }
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }

  Future<List<User>> fetchUserList() async {
    return fetchGraphQL<List<User>>(
        """
        query userList {
          userList {
            uuid
            name
            avatar {
              imgurURL
            }
          }
        }
      """,
        false,
        null,
        (Map<String, dynamic> json) => listFromJson(json["userList"],
            (dynamic json) => User.fromJson(json as Map<String, dynamic>)));
  }

  List<T> listFromJson<T>(dynamic list, T fromJson(dynamic json)) {
    if (list == null) {
      return list;
    }

    return (list as List<dynamic>)
        .map((dynamic listElement) => fromJson(listElement))
        .toList();
  }
}
