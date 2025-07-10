import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/payment_tab_widgets/presentation/widgets/all/all_transactions_list.dart';
import '../widgets/comleted/comleted_transaction_card.dart';
import '../../data/model.dart';
import '../widgets/pending/pending.dart';

class PaymentTab extends StatefulWidget {
  const PaymentTab({Key? key}) : super(key: key);

  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 64, right: 64 ,bottom: 32),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
               // SizedBox(height: 44),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorApp.secondaryColor,
                    //  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          isScrollable: false,
                          labelPadding: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          unselectedLabelColor: Color(0xFFB43E26),
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontFamily: "vol",
                              fontWeight: FontWeight.w700),
                          indicatorColor: ColorApp.secondaryColor,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                ColorApp.secondaryColor,
                                Colors.white,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(
                              text: '           All    \n Transactions',
                            ),
                            Tab(
                              text: '  Completed \n Transactions',
                            ),
                            Tab(
                              text: '    Pending \n Transactions',

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children:  [
                      TransactionListScreen(),
                      CompletedTransactionsScreen(
                        transactions: [
                          Transaction(
                        id: '123',
                        amount: 150,
                        recipient: 'owner1',
                        date: DateTime.now().subtract(const Duration(days: 1)),
                        status: 'Success',
                      ),
                        Transaction(
                          id: '124',
                          amount: 200,
                          recipient: 'owner2',
                          date: DateTime.now().subtract(const Duration(days: 2)),
                          status: 'Success',
                        ),
                          Transaction(
                            id: '125',
                            amount: 300,
                            recipient: 'owner3',
                            date: DateTime.now().subtract(const Duration(days: 3)),
                            status: 'Success',
                          ),
                        ],),
                      PendingTransactionsScreen(
                        transactions: [
                          Transaction(
                            id: '126',
                            amount: 400,
                            recipient: 'owner4',
                            date: DateTime.now().subtract(const Duration(days: 4)),
                            status: 'Pending',
                          ),
                          Transaction(
                            id: '127',
                            amount: 500,
                            recipient: 'owner5',
                            date: DateTime.now().subtract(const Duration(days: 5)),
                            status: 'Pending',
                          ),
                        ],),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
