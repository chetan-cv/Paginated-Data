class DataModel {
  final String count;
  String next;
  final String previous;
  final List<Results> results;

  DataModel({this.count, this.next, this.previous, this.results});

  factory DataModel.fromJson(Map<String, dynamic> parsedJson) {
    return DataModel(
        count: parsedJson['count'].toString(),
        next: parsedJson['next'].toString(),
        previous: parsedJson['previous'].toString(),
        results: parseResults(parsedJson));
  }
  static List<Results> parseResults(parsedJson) {
    var list = parsedJson['results'] as List;
    List<Results> resultsList =
        list.map((data) => Results.fromJson(data)).toList();
    return resultsList;
  }
}

class Results {
  final String id;
  final String title;
  final String subTitle;
  Results({this.id, this.title, this.subTitle});

  factory Results.fromJson(Map<String, dynamic> parsedJson) {
    return Results(
        id: parsedJson['id'].toString(),
        title: parsedJson['title'],
        subTitle: parsedJson['subTitle']);
  }
}
