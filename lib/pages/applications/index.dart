import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kyogojo_pay/pages/applications/form.dart';
import 'package:kyogojo_pay/providers/request_provider.dart';
import 'package:kyogojo_pay/providers/signup_provider.dart';
import 'package:paged_datatable/paged_datatable.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends HookWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final requestProvider = Provider.of<RequestProvider>(context);
    final signupProvider = Provider.of<SignupDataProvider>(context);

    useEffect(() {
      Future.microtask(() async {
        await requestProvider.getRequests({"status": "Approved"});
      });
    }, []);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 200,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "images/Vectorkyogo.svg",
                fit: BoxFit.fill,
                width: 100,
                color: Colors.white,
                key: const Key("Logo"),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  signupProvider.logout();
                  context.push('/');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              )
            ],
            backgroundColor: Color(0xFFB82832),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: null,
              ),
              SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    child: DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        columns: const [
                          DataColumn2(
                            label: Text(
                              'Applicant',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text(
                              'Request Status',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Form Type',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            numeric: true,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            requestProvider.requests.docs.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text(
                                      "${requestProvider.requests.docs[index].form.firstName} ${requestProvider.requests.docs[index].form.lastName}")),
                                  DataCell(Text(
                                      "${requestProvider.requests.docs[index].status}")),
                                  DataCell(Text(
                                      "${requestProvider.requests.docs[index].formType}")),
                                  DataCell(ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialog(
                                            data: requestProvider
                                                .requests.docs[index],
                                          ); // Show your custom dialog
                                        },
                                      );
                                      // requestProvider.paymentRequest(
                                      //     {
                                      //       "method": "string",
                                      //       "amount": 0,
                                      //       "orNumber": "string",
                                      //       "remarks": "string",
                                      //       "userId": "string",
                                      //       "date": "2023-08-27T01:30:24.092Z"
                                      //     },
                                      //     requestProvider
                                      //             .requests.docs[index].id ??
                                      //         '');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Adjust the value as needed
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      primary: Color(0xFFB82832),
                                    ),
                                    child: const Text(
                                      'Mark as Paid',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    ),
                                  )),
                                ]))),
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
