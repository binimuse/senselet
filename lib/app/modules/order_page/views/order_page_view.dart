import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:senselet/app/constants/const.dart';
import 'package:senselet/app/modules/order_page/views/widget/map_pin_my_address.dart';
import 'package:senselet/app/modules/order_page/views/widget/order_sucess.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/reusable/keyboard.dart';
import '../controllers/order_page_controller.dart';

class OrderPageView extends GetView<OrderPageController> {
  const OrderPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: themebackground,
      appBar: controller.buildAppforpages(context),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: Colors.yellow[600],
                        size: 20.0,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          'To send'.tr,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MapMyAddressPickers()),
                    );

                    //  _pickupLocationController.text = selectedLocation;
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Pickup location'.tr,
                      enabled: false,
                      labelStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: themeColor,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.location_pin,
                        color: themeColorFaded,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () async {

                    //  _pickupLocationController.text = selectedLocation;
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dropoff location',
                      enabled: false,
                      labelStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: themeColor,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.location_pin,
                        color: themeColorFaded,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  height: 20.h,
                  child: TextFormField(
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      labelText: 'Detail ',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: themeColor,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                buildpickvehcle(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildpickvehcle(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 50.w,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [themeColor, themeColorFaded],
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                KeyboardUtil.hideKeyboard(context);
                _showBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 2.3.h),
              ),
              child: Text(
                'Select Vehicle'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.bottomSheet(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Vehicle type',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                physics: const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  return cardview();
                },
              ),
            ),
            SizedBox(height: 1.h),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 10.0,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        enableDrag: true,
      );
    });
  }

  cardview() {
    return InkWell(
      onTap: () {
        Get.to(OrderSuccessView());
      },
      child: Card(
        elevation: 4.0, // Add shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Add border radius to the card
          side: const BorderSide(
              color: Colors.grey, width: 0.1), // Add a border around the card
        ),
        child: const ListTile(
          leading: Icon(
            FontAwesomeIcons.truck,
            color: themeColorFaded,
            size: 30,
          ),
          title: Text('Pickup truck'),
          subtitle: Text('Greater than 300KG'),
        ),
      ),
    );
  }
}
