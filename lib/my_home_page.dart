import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/component/colors.dart';
import 'package:payment_app/controller/controller.dart';
import 'package:payment_app/widgets/buttons.dart';
import 'package:payment_app/widgets/large_button.dart';
import 'package:payment_app/widgets/payment_page.dart';
import 'package:payment_app/widgets/text_size.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataController _controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    print(_controller.list);
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        height: h,
        child: Stack(
          children: [
            _headSection(),
            Obx(() => !_controller.loading
                ? Center(
                    child: Container(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator()),
                  )
                : _listBills()),
            _payButton(),
          ],
        ),
      ),
    );
  }

  Widget _payButton() {
    return Positioned(
        bottom: 0,
        child: AppLargeButton(
          text: "Pay all bills",
          textColor: Colors.white,
          onTap: () {
            Get.to(() => const PaymentPage());
          },
        ));
  }

  Widget _listBills() {
    return Positioned(
        top: 250,
        left: 0,
        right: 0,
        bottom: 60,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemCount: _controller.list.length,
              itemBuilder: (_, index) {
                return listItem(index);
              }),
        ));
  }

  Widget listItem(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width - 20,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFd8dbe0),
                offset: Offset(1, 1),
                blurRadius: 20.0,
                spreadRadius: 10),
          ]),
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
          left: 18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage(_controller.list[index]["img"]),
                              fit: BoxFit.cover),
                          border: Border.all(width: 3, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.list[index]["brand"],
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "ID:846594",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.idColor,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ],
                ),
                SizedText(
                    text: _controller.list[index]["more"],
                    color: AppColor.green),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.list[index]["status"] =
                            !_controller.list[index]["status"];
                        _controller.list.refresh();
                      },
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _controller.list[index]["status"]
                                ? Colors.green
                                : AppColor.selectBackground),
                        child: Center(
                          child: Text(
                            "Select",
                            style: TextStyle(
                                fontSize: 16,
                                color: _controller.list[index]["status"]
                                    ? Colors.white
                                    : AppColor.selectColor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      "\$${_controller.list[index]["due"]}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w900),
                    ),
                    const Text(
                      "Due in 3 days",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColor.idColor,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 35,
                  width: 5,
                  decoration: const BoxDecoration(
                      color: AppColor.halfOval,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _headSection() {
    return Container(
      height: 250,
      child: Stack(
        children: [
          _mainBackground(),
          _curveImageContainer(),
          _buttonContainer(),
          _textContainer(),
        ],
      ),
    );
  }

  Widget _textContainer() {
    return const Stack(
      children: [
        Positioned(
            top: 80,
            left: -10,
            child: Text(
              "My Bills",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Color(0xFF293952),
              ),
            )),
        Positioned(
            top: 50,
            left: 50,
            child: Text(
              "My Bills",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ],
    );
  }

  _buttonContainer() {
    return Positioned(
        bottom: 3,
        right: 50,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 190,
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            child: Container(
                              color: const Color(0xFFEEF1F4).withOpacity(0.7),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 250,
                            )),
                        Positioned(
                          top: 0,
                          right: 50,
                          child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 20),
                            width: 60,
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                                color: AppColor.mainColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppButton(
                                    icon: Icons.cancel,
                                    iconColor: AppColor.mainColor,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.pop(context);
                                    }),
                                AppButton(
                                  icon: Icons.add,
                                  iconColor: AppColor.mainColor,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  onTap: () {},
                                  text: "Add Bill",
                                ),
                                AppButton(
                                  icon: Icons.history,
                                  iconColor: AppColor.mainColor,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  onTap: () {},
                                  text: "History",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("images/lines.png")),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 1),
                      color: const Color(0xFF11324d).withOpacity(0.2))
                ]),
          ),
        ));
  }

  _curveImageContainer() {
    return Positioned(
        left: 0,
        right: -2,
        bottom: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.11,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "images/curve.png",
            ),
            fit: BoxFit.cover,
          )),
        ));
  }

  _mainBackground() {
    return Positioned(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
