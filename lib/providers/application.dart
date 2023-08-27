import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kyogojo_pay/services/api_status.dart';

class ApplicationProvider extends ChangeNotifier {
  List<Map> _address = [];
  var requirement1Status = {'file 1': false, 'file 2': false};

  bool _orientationFinished = false;
  bool _agreedToTerms = false;
  bool showRemarksDoneButton = false;

  bool isNotifShowing = false;
  int currentFilePreviewIndex = 0;
  List<Map> get address => _address;
  bool get orientationFinished => _orientationFinished;
  bool get agreedToTerms => _agreedToTerms;
  int bottomTabIndex = 0;
  bool isQueryResultEmpty = false;
  bool fromQuery = false;
  bool ciAssigned = false;
  bool showDialogFlag = false;
  int page = 1;
  bool showSOABottomBar = false;
  bool isEditingSOA = false;
  bool prevBioStat = false;
  int newMeterCount = 0;
  int forCICount = 0;
  int jobOrderCount = 0;
  int deniedCOunt = 0;
  bool loadingDash = true;

  setQueryResultIsEmpty(bool isEmpty) {
    isQueryResultEmpty = isEmpty;
    notifyListeners();
  }

  setPage(int data) {
    page = data;
    notifyListeners();
  }

  setPrevBioStat(bool data) {
    prevBioStat = data;
    notifyListeners();
  }

  setLoadDash(bool data) {
    loadingDash = data;
    notifyListeners();
  }

  setIsEditingSOA(bool data) {
    isEditingSOA = data;
    notifyListeners();
  }

  setShowSOABottomBar(bool data) {
    showSOABottomBar = data;
    notifyListeners();
  }

  setShowDialogFlag(bool data) {
    showDialogFlag = data;
    notifyListeners();
  }

  setCIAssigned(bool value) {
    ciAssigned = value;
    notifyListeners();
  }

  setFromQuery(bool value) {
    fromQuery = value;
    notifyListeners();
  }

  setRemarkDoneButton(bool remarks) {
    showRemarksDoneButton = remarks;
    notifyListeners();
  }

  setCurrentTabIndex(int index) {
    bottomTabIndex = index;
    notifyListeners();
  }

  setPosition(List<Map> address) {
    _address = address;
    notifyListeners();
  }

  toggleNotif(bool toggleValue) {
    isNotifShowing = toggleValue;
    notifyListeners();
  }

  setOrientation(bool orientationFinished) {
    _orientationFinished = orientationFinished;
    notifyListeners();
  }

  setTermsStatus(bool agreedToTerms) {
    _agreedToTerms = agreedToTerms;
    notifyListeners();
  }

  addPosition(
      {required Map<dynamic, dynamic> query,
      required Function callback}) async {
    setPosition([...address, query]);
  }

  setOrientationStatus({required bool status}) async {
    setOrientation(status);
  }

  setTermStatus({required bool status}) async {
    setTermsStatus(status);
  }

  setRequirementIndex(int index) {
    currentFilePreviewIndex = index;
    notifyListeners();
  }

  // Future<APIResponse> initializeDashboard() async {
  //   loadingDash = true;
  //   try {
  //     loadingDash = true;
  //     var jobOrders = await JobOrderService.getJobOrders({});
  //     jobOrderCount = jobOrders.data?.totalRows ?? 0;
  //     await Future.delayed(const Duration(seconds: 4));

  //     var ciJobOrders = await JobOrderService.getJobOrders(
  //         {'jobOrderType': 'Customer Investigation'});
  //     forCICount = ciJobOrders.data?.totalRows ?? 0;
  //     await Future.delayed(const Duration(seconds: 4));

  //     var requests = await RequestsService.getRequest({});
  //     newMeterCount = requests.totalRows;
  //     await Future.delayed(const Duration(seconds: 4));

  //     var deniedReq =
  //         await RequestsService.getRequest({'status': 'Disapproved'});
  //     deniedCOunt = deniedReq.totalRows;
  //     Loader.hide();
  //     loadingDash = false;
  //     return APIResponse(success: true);
  //   } catch (e) {
  //     loadingDash = false;
  //     Loader.hide();
  //     notifyListeners();
  //     return APIResponse(success: false, error: e.toString());
  //   }
  // }
}
