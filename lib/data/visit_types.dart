import 'package:vms/models/api_response.dart';
import 'package:vms/models/enumeration.dart';

APIResponse<List<Enumeration>> _enumList =
    new APIResponse<List<Enumeration>>(data: [], error: false);

List<Map<String, dynamic>> visitTypes = [];
