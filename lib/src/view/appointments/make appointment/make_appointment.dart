import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mabook/src/controller/appointmentcon.dart';
import 'package:mabook/src/view/appointments/make%20appointment/w_make_appointment.dart';
import 'package:mabook/src/view/const/colors.dart';
import 'package:razorpay_web/razorpay_web.dart';

class AppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> doctorData;
  final String selectedDate;
  final String doctorid;

  final int selectedTokens;
  const AppointmentScreen(
      {super.key,
      required this.doctorData,
      required this.selectedDate,
      required this.selectedTokens, required this.doctorid});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final Razorpay _razorpay = Razorpay();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppoinmentController ctrl = Get.put(AppoinmentController());
  
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      _handlePaymentErrorResponse(response, _scaffoldKey.currentContext!);
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      _handlePaymentSuccessResponse(response, context, widget.doctorData,
          widget.selectedDate, widget.selectedTokens,widget.doctorid);
    });
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
    //   _handleExternalWalletSelected(response, _scaffoldKey.currentContext!);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final profilePath = widget.doctorData.containsKey('profile') &&
            widget.doctorData['profile'] != null
        ? widget.doctorData['profile']
        : '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: black,
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //             doctorController.deleteDoctor(docId);
        //       },
        //       icon: Icon(Icons.delete))
        // ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              profileSection(profilePath, widget.doctorData),
              const SizedBox(height: 46),
              detailsDisplay(widget.doctorData, widget.selectedTokens,
                  widget.selectedDate),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: black,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee,
                              size: 15,
                              color: black,
                            ),
                            Text(
                              '${widget.doctorData.containsKey("consultancyfees") ? widget.doctorData["consultancyfees"] : "N/A"}.00',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 175,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (ctrl.appointmentFormKey.currentState!
                              .validate()) {
                            int fees = widget.doctorData["consultancyfees"];

                            var amount =
                                (double.parse(fees.toString()) * 100).toInt();

                            var options = {
                              'key': 'rzp_test_5CvknA4rDqeKqA',
                              'amount': amount,
                              'name': 'Mabook',
                              'description': 'consulting Payment',
                              "timeout": "180",
                              "currency": "INR",
                              'retry': {'enabled': true, 'max_count': 1},
                            };
                            _razorpay.open(options);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19)),
                          backgroundColor: green,
                        ),
                        child: const Text(
                          "Book ",
                          style: TextStyle(color: white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}",
    );
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response,
      BuildContext context, doctorData, selectedDate, selectedTokens,doctorid,) async {
    final AppoinmentController ctrl = Get.put(AppoinmentController());

    showAlertDialog(
      context,
      "Payment Successful",
      "Payment ID: ${response.paymentId}",
    ).then((_) {

      ctrl.addappoinmentToFirebase(doctorData['name'],
          doctorData['consultancyfees'], selectedDate, selectedTokens,doctorid,doctorData,context);
    });
  }

  // void _handleExternalWalletSelected(
  //     ExternalWalletResponse response, BuildContext context) {
  //   showAlertDialog(
  //     context,
  //     "External Wallet Selected",
  //     "${response.walletName}",
  //   );
  // }

  Future<void> showAlertDialog(
      BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [continueButton],
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
