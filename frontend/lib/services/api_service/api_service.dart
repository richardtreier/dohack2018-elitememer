import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

ApiService service = ApiService();

class ApiService {
  final apiEndpoint = "https://elitememers.cfapps.io/graphql";

  Future<List<User>> fetchUserList() async {
    return _fetchGraphQL(
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

  Future<List<Meme>> fetchUserNextMemes(User user, int numMemes) async {
    return _fetchGraphQL(
        """
        query user(\$userUuid: ID!, \$numMemes: Int!) {
          user(uuid: \$userUuid) {
            nextMemes(num: \$numMemes) {
              uuid
              image {
                imgurURL
              }
            }
          }
        }
      """,
        false,
        <String, dynamic>{"userUuid": user.uuid, "numMemes": numMemes},
        (Map<String, dynamic> json) => User.fromJson(json["user"]).nextMemes);
  }

  Future<List<User>> fetchUserMatches(User user, int numMemes) async {
    return _fetchGraphQL(
        """
        query user(\$userUuid: ID!) {
          user(uuid: \$userUuid) {
            matches {
              uuid
              name
              avatar {
                imgurURL
              }
              snobOrBobPercentage(viewerUserUuid: \$userUuid)
              matchPercentage(viewerUserUuid: \$userUuid)
              enemyPercentage(viewerUserUuid: \$userUuid)
            }
          }
        }
      """,
        false,
        <String, dynamic>{"userUuid": user.uuid},
        (Map<String, dynamic> json) => User.fromJson(json["user"]).matches);
  }

  Future<User> fetchUserDetailWithTopMemes(
      User user, User viewingUser, int numMemes) async {
    return _fetchGraphQL(
        """
        query user(\$userUuid: ID!, \$viewingUserUuid: ID!) {
          user(uuid: \$userUuid) {
            uuid
            name
            avatar {
              imgurURL
            }
            snobOrBobPercentage(viewerUserUuid: \$viewingUserUuid)
            matchPercentage(viewerUserUuid: \$viewingUserUuid)
            enemyPercentage(viewerUserUuid: \$viewingUserUuid)
            
            topMemes(viewerUserUuid: \$viewerUserUuid) {
              uuid
              image {
                imgurURL
              }
            }
          }
        }
      """,
        false,
        <String, dynamic>{
          "userUuid": user.uuid,
          "viewingUserUuid": viewingUser.uuid
        },
        (Map<String, dynamic> json) => User.fromJson(json["user"]));
  }

  Future<bool> likeOrDislikeMeme(bool like, User user, Meme meme) async {
    return _fetchGraphQL(
        """
        mutation likeOrDislikeMeme(\$like: Boolean!, \$userUuid: ID!, \$memeUuid: ID!) {
          likeOrDislikeMeme(like: \$like, userUuid: \$userUuid, memeUuid: \$memeUuid)
        }
      """,
        true,
        <String, dynamic>{
          "like": like,
          "userUuid": user.uuid,
          "memeUuid": meme.uuid
        },
        (Map<String, dynamic> json) => json["likeOrDislikeMeme"] as bool);
  }

  Future<T> _fetchGraphQL<T>(
      String query,
      bool isMutation,
      Map<String, dynamic> variables,
      T fromJson(Map<String, dynamic> json)) async {
    Map payload;
    if (isMutation) {
      print("Sending Query" + query);
      payload = <String, dynamic>{"mutation": query, "variables": variables};
    } else {
      print("Sending Mutation" + query);
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
    final dynamic responseErrors = responseJson["errors"];
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
}
