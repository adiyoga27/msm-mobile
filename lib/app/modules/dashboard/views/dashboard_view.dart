import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketsosialmedia/app/core/theme/app_theme.dart';

import 'package:intl/intl.dart';
import 'package:marketsosialmedia/app/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: value20),
          child: Column(
            children: [
              RefreshIndicator(
                displacement: 80,
                onRefresh: () => controller.onRefresh(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 200.0,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => controller.isLoading.value
                                        ? SizedBox(
                                            height: 10.0,
                                          )
                                        : Column(
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20.0,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Center(
                                                              child: Text(
                                                            'Y',
                                                            style: GoogleFonts.manrope(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Text(
                                                          "Hi, ${controller.profileModel.username}",
                                                          style: GoogleFonts.manrope(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Total Balance",
                                                      style:
                                                          GoogleFonts.manrope(
                                                              textStyle:
                                                                  TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.grey[200],
                                                      )),
                                                    ),
                                                    Text(
                                                      "Rp ${formatCurrency(double.parse(controller.profileModel.balance))}",
                                                      style: GoogleFonts.manrope(
                                                          textStyle: TextStyle(
                                                              fontSize: 30.0,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  )),
                            ),
                          ),
                          // const ClipPathTopRightForBalanceCard(),
                          // const ClipPathBottomRightForBalanceCard(),
                          Align(
                            alignment: Alignment.topRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                  30.0,
                                ),
                              ),
                              child: CustomPaint(
                                size: Size(
                                  180.0,
                                  (180.0 * 0.5567901611328125).toDouble(),
                                ),
                                painter: CurvedContainerPath(isFirst: true),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                  30.0,
                                ),
                                topLeft: Radius.circular(
                                  50.0,
                                ),
                              ),
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFA9224A),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  30.0,
                                ),
                              ),
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: CustomPaint(
                                  size: Size(
                                    180.0,
                                    (180.0 * 0.5567901611328125).toDouble(),
                                  ),
                                  painter: CurvedContainerPath(isFirst: false),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // const PaymentOptionsColumn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuIcon(),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              // FutureBuilder(
              //   future: _future,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       return transactions.isEmpty
              //           ? Expanded(
              //               child: SingleChildScrollView(
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     SizedBox(
              //                       height: 10.0,
              //                     ),
              //                     Image.asset(
              //                       "assets/images/empty_list.png",
              //                       height: 15.0,
              //                     ),
              //                     Text(
              //                       "You've not made any transactions",
              //                       style: TextStyle(
              //                         fontSize: 18.0,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 10.0,
              //                     ),
              //                     Padding(
              //                       padding: EdgeInsets.symmetric(
              //                           horizontal: value60),
              //                       child: CustomButton(
              //                         buttonText: "Transfer Now",
              //                         buttonColor: defaultAppColor,
              //                         buttonTextColor: Colors.white,
              //                         onTap: () {
              //                           Navigator.pushNamed(
              //                             context,
              //                             SendMoneyScreen.route,
              //                           );
              //                         },
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             )
              //           : Expanded(
              //               child: RefreshIndicator(
              //                 onRefresh: () => getAllTransactions(),
              //                 child: ListView.builder(
              //                   physics: const AlwaysScrollableScrollPhysics(),
              //                   controller: scrollController,
              //                   itemCount: transactions.length,
              //                   itemBuilder: (BuildContext context, int index) {
              //                     final transactionData = transactions[index];
              //                     List<String> getTrnxSummary(transactionData) {
              //                       if (transactionData.trnxType == "Credit") {
              //                         return [
              //                           "From ${transactionData.fullNameTransactionEntity} Reference:${transactionData.reference}",
              //                           "assets/icons/credit_icon.png"
              //                         ];
              //                       } else if (transactionData.trnxType ==
              //                           "Debit") {
              //                         return [
              //                           "To ${transactionData.fullNameTransactionEntity} Reference:${transactionData.reference}",
              //                           "assets/icons/debit_icon.png"
              //                         ];
              //                       } else if (transactionData.trnxType ==
              //                           "Wallet Funding") {
              //                         return [
              //                           "You Funded Your Wallet. Reference:${transactionData.reference}",
              //                           "assets/icons/add_icon.png"
              //                         ];
              //                       } else {
              //                         return ["Hello"];
              //                       }
              //                     }

              //                     return GestureDetector(
              //                       onTap: () => Navigator.pushNamed(
              //                         context,
              //                         TransactionDetailsScreen.route,
              //                         arguments: transactionData,
              //                       ),
              //                       child: TransactionsCard(
              //                         transactionTypeImage:
              //                             getTrnxSummary(transactionData)[1],
              //                         transactionType: transactionData.trnxType,
              //                         trnxSummary:
              //                             getTrnxSummary(transactionData)[0],
              //                         amount: transactionData.amount,
              //                         amountColorBasedOnTransactionType:
              //                             transactionData.trnxType == "Debit"
              //                                 ? Colors.red
              //                                 : Colors.green,
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               ),
              //             );
              //     }
              //     return const Expanded(child: CircularLoader());
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.CHECKOUT),
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.red,
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/add_icon.png',
                  color: Colors.white,
                  height: 33.0,
                ),
              ),
            ),
          ),
          Text(
            "Fund",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

String formatCurrency(double value) {
  var formatter = NumberFormat.currency(
    locale: 'id_ID', // Use 'id_ID' for Indonesian Rupiah
    symbol: '',
  );
  return formatter.format(value);
}
