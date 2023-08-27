import 'package:flutter/foundation.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kyogojo_pay/models/request_model.dart';
import 'dart:developer' as dev;

import 'package:kyogojo_pay/models/request_response_model.dart';
import 'package:kyogojo_pay/models/response_models/api_response_model.dart';
import 'package:kyogojo_pay/services/api_status.dart';
import 'package:kyogojo_pay/services/requests_service.dart';

class RequestProvider with ChangeNotifier {
  List<RequestModel>? logs;
  RequestResModel requests =
      RequestResModel(docs: [], pageNumber: 0, pageSize: 0, totalRows: 0);

  RequestResModel searchSuggestions =
      RequestResModel(docs: [], pageNumber: 0, pageSize: 0, totalRows: 0);
  List<Map> addresses = [];
  bool? loading = true;
  Map? filters = {"requestType": "Application"};
  Map? filtersTemp = {};
  Address? temp = Address();
  List<Map> remarks = [];
  List<Map> sampleSoa = [
    {
      "particular": "Installation Fee",
      "amount": 1500,
    },
    {
      "particular": "Fittings",
      "amount": 1200,
    }
  ];
  RequestModel request = RequestModel(
      form: Forms(
          firstName: "",
          lastName: "",
          suffix: "",
          middleName: "",
          addressList: []),
      requestBy: RequestBy(
        id: "",
        email: "",
        firstName: "",
        mobileNumber: "",
        lastName: "",
        middleName: "",
        type: "",
      ),
      formType: "application",
      schedule: "2023-02-17T12:44:51.287Z",
      requestType: "application");
  RequestModel payload = RequestModel(
      form: Forms(
          firstName: "",
          lastName: "",
          suffix: "",
          middleName: "",
          addressList: []),
      requestBy: RequestBy(
        id: "",
        email: "",
        firstName: "",
        mobileNumber: "",
        lastName: "",
        middleName: "",
        type: "",
      ),
      formType: "Application",
      requestType: "Application");

  notify() async {
    notifyListeners();
  }

  setAddresses(List<Map> address) {
    addresses = address;
    notifyListeners();
  }

  setRemarks(List<Map> data) {
    remarks = data;
    notifyListeners();
  }

  setFilters(Map filter) {
    filters = filter;
    notifyListeners();
  }

  setTempFilters(Map tempfilter) {
    filtersTemp = tempfilter;
    notifyListeners();
  }

  setPayload(RequestModel data) {
    payload = data;
    notifyListeners();
  }

  setTemp(Address data) {
    temp = data;
    notifyListeners();
  }

  setLog(List<RequestModel> log) {
    logs = log;
    notifyListeners();
  }

  setRequests(RequestResModel data) {
    requests = data;
    notifyListeners();
  }

  setSearchSuggestions(RequestResModel data) {
    searchSuggestions = data;
    notifyListeners();
  }

  setRequest(RequestModel data) {
    request = data;
    notifyListeners();
  }

  setLoading(bool? data) {
    loading = data;
    notifyListeners();
  }

  addAddress({required Map<dynamic, dynamic> query}) async {
    setAddresses([...addresses, query]);
  }

  createRequest(RequestModel data) async {
    try {
      var res = await RequestsService.createRequest(data);
      notifyListeners();
      return res;
    } catch (e) {
      notifyListeners();
      return e;
    }
  }

  editRequest(RequestModel data, String id) async {
    try {
      var res = await RequestsService.editRequest(data, id);
      notifyListeners();
      dev.inspect(res);
      return res;
    } catch (e) {
      notifyListeners();
      return e;
    }
  }

  editSOA(List<Soa> data, String id) async {
    try {
      var res = await RequestsService.editSOA(data, id);
      notifyListeners();
      dev.inspect(res);
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  getRequest(Map<String, dynamic>? query) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequest(query);
      setLoading(false);
      return res;
    } catch (e) {
      setLoading(false);
      Loader.hide();
      //catch error
    }
    notifyListeners();
    setLoading(false);
  }

  getRequestById(id) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequestByID(id);
      await setRequest(res);
      setLoading(false);
      Loader.hide();
      return res;
    } catch (e) {
      Loader.hide();
      setLoading(false);
    }
    setLoading(false);
    notifyListeners();
  }

  getInitialPayload(id) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequestByID(id);
      await setPayload(res);
      setLoading(false);
      Loader.hide();
      return res;
    } catch (e) {
      setLoading(false);
      Loader.hide();
      //catch error
    }
    setLoading(false);
    notifyListeners();
  }

  getRequestByUser(id) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequestByUser(id);
      // await setRequests(res);
      await setLoading(false);
      Loader.hide();
      return res;
    } catch (e) {
      setLoading(false);
      Loader.hide();
      notifyListeners();
    }
    notifyListeners();
    setLoading(false);
  }

  // approveRequest(Map payload, String id) async {
  //   setLoading(true);
  //   try {
  //     var res = await RequestsService.approveRequest(payload, id);
  //     await setLoading(false);
  //     Loader.hide();

  //     return res;
  //   } catch (e) {
  //     dev.inspect(e);
  //     Loader.hide();
  //     notifyListeners();
  //     setLoading(false);
  //     return e;
  //   }
  // }

  // Future<APIResponse> approveSOA(String id) async {
  //   setLoading(true);
  //   try {
  //     var res = await RequestsService.approveSOA(id);
  //     await setLoading(false);
  //     Loader.hide();

  //     return res;
  //   } catch (e) {
  //     dev.inspect(e);
  //     Loader.hide();
  //     notifyListeners();
  //     setLoading(false);
  //     return APIResponse(success: false, error: e.toString());
  //   }
  // }

  Future<ApiResponse> paymentRequest(
      Map<String, dynamic> payload, String id) async {
    setLoading(true);
    try {
      var res = await RequestsService.paymentRequest(payload, id);
      await setLoading(false);
      Loader.hide();

      return res;
    } catch (e) {
      dev.inspect(e);
      Loader.hide();
      notifyListeners();
      setLoading(false);
      return ApiResponse(success: false, statusCode: 500);
    }
  }

  disapproveRequest(Map payload, String id) async {
    setLoading(true);
    try {
      var res = await RequestsService.disapproveRequest(payload, id);
      await setLoading(false);

      Loader.hide();
      return res;
    } catch (e) {
      dev.inspect(e);
      Loader.hide();
      notifyListeners();
    }
    notifyListeners();
    setLoading(false);
  }

  getRequests(Map<String, dynamic>? query) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequest(query);
      if ([200, 201, 204].contains(res.statusCode)) {
        await setRequests(res);
      }
      await setLoading(false);
      dev.inspect(res);
      Loader.hide();
      return res;
    } catch (e) {
      setLoading(false);
      Loader.hide();
      notifyListeners();
    }

    notifyListeners();
    setLoading(false);
  }

  Future getRequestsWithoutLoading(Map<String, dynamic>? query) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequest(query);
      if ([200, 201, 204].contains(res.statusCode)) {
        await setRequests(res);
        setLoading(false);
      }
      notifyListeners();
      return;
    } catch (e) {
      setLoading(false);
      notifyListeners();
      return [];
    }
  }

  loadMoreRequests(Map<String, dynamic>? query) async {
    setLoading(true);
    try {
      var res = await RequestsService.getRequest(query);
      await setRequests(RequestResModel(
          pageNumber: res.pageNumber,
          pageSize: res.pageSize,
          totalRows: res.totalRows,
          docs: [...requests.docs, ...res.docs]));

      setLoading(false);
      Loader.hide();
      return res;
    } catch (e) {
      setLoading(false);
      Loader.hide();
      notifyListeners();
    }
    notifyListeners();
  }

  resetPayload() async {
    await setPayload(RequestModel(
        form: Forms(
            firstName: "",
            lastName: "",
            suffix: "",
            middleName: "",
            addressList: []),
        requestBy: RequestBy(
          id: "",
          email: "",
          firstName: "",
          mobileNumber: "",
          lastName: "",
          middleName: "",
          type: "",
        ),
        formType: "application",
        schedule: "2023-02-17T12:44:51.287Z",
        requestType: "application"));
  }
}
