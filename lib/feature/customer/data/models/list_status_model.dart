import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dut_packing_utility/feature/customer/data/models/status_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ListStatusModel {
  List<dynamic>? list;

  ListStatusModel({this.list});

  factory ListStatusModel.fromJson(Map<String, dynamic> json) {
    return ListStatusModel(
      list: List<StatusModel>.from(json["list"].map((x) => StatusModel.fromJson(x))),
    );
  }

  List<StatusModel> getListHistory() {
    if (list == null) {
      return <StatusModel>[];
    }
    List<StatusModel> result = <StatusModel>[];
    for (var element in list!.reversed) {
      result.add(StatusModel.fromJson(element));
    }
    return result;
  }
}
