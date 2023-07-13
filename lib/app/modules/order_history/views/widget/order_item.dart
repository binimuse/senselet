// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../../constants/const.dart';
import '../../../../constants/reusable/keyboard.dart';
import '../../controllers/cancellationreason.dart';
import '../../controllers/order_history_controller.dart';
import '../../data/Model/order_history_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_svg/flutter_svg.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    this.order,
    required this.history,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final OrderModel? order;

  final bool history;

  final int index;

  final OrderHistoryController controller;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.only(
        bottom: 3.w,
        right: 4.w,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 5,
        shadowColor: themeColorFaded.withOpacity(0.2),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 6,
              shadowColor: themeColorFaded.withOpacity(0.2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(3.w),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 20.w,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 4.w,
                              bottom: 0,
                              top: 0,
                              child: SvgPicture.asset("assets/icons/order.svg",
                                  color: themeColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      itemDetail(),
                      SizedBox(
                        width: 4.w,
                      ),
                      buildbutton(),
                    ],
                  ),
                ),
              ),
            ),
            isExpanded
                ? Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                            ),
                            child: Text(
                              "Order detail",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: themeColorFaded,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order description",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        widget.order!.detail.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Divider(
                            height: 0,
                            color: Colors.grey[400],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.w,
                            ),
                            child: Text(
                              "Address details",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: themeColorFaded,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pickup location",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        widget.order!.pickuplocationname
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery location",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Align(
                                      child: Text(
                                        widget.order!.deliverylocationname
                                            .toString()
                                            .trim(),
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery approved",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.order!.deliveryApproved
                                          .toString()
                                          .contains("null")
                                      ? "Pending"
                                      : widget.order!.deliveryApproved
                                          .toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 1.h,
                          ),
                          //order Status

                          //   buildOrderStatus(widget.status),
                          // widget.status.toString() == "ORDERED" ||
                          //         widget.status.toString() == "ARRIVED"
                          //     ? requestRefend()
                          //     : const SizedBox(),

                          SizedBox(
                            height: 1.h,
                          ),
                          builqr(widget.order!.orderStatus.toString()),
                          buildtrack(widget.order!.orderStatus.toString()),
                          buildcancelorder(
                              widget.order!.orderStatus.toString()),

                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  buildOrderStatus(String status) {
    return Column(
      children: [
        //TITLE
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                status,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.5.h,
        ),

        ///NUMBERS STAUS
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: themeColor,
                radius: 4.w,
                child: Text(
                  '1',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1.0,
                  dashLength: 6.0,
                  dashGapLength: 3.0,
                  dashColor: Colors.black45,
                ),
              ),
              CircleAvatar(
                backgroundColor:
                    widget.history == true ? themeColor : Colors.grey.shade200,
                radius: 4.w,
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: widget.history == false ? themeColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1.0,
                  dashLength: 6.0,
                  dashGapLength: 3.0,
                  dashColor: Colors.black45,
                ),
              ),
              CircleAvatar(
                backgroundColor:
                    widget.history == true ? themeColor : Colors.grey.shade200,
                radius: 4.w,
                child: Text(
                  '3',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: widget.history == false ? themeColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.5.h,
        ),

        ///buttons status
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.h,
                      ),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.history == true
                        ? themeColor
                        : Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.h,
                      ),
                      child: Text(
                        'on the way',
                        style: TextStyle(
                          color: widget.history == false
                              ? themeColor
                              : Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.history == true
                        ? themeColor
                        : Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2.h,
                      ),
                      child: Text(
                        'Arrived',
                        style: TextStyle(
                          color: widget.history == false
                              ? themeColor
                              : Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  qrCode() {
    return SizedBox(
      height: 33.h,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: QrImage(
                data: widget.order!.id.toString(),
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  trackYourOrderButton() {
    return widget.history == false
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [themeColor, themeColorFaded],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  //   Get.toNamed(Routes.ORDER_TRACKING, arguments: widget.order);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 2.3.h),
                ),
                child: Text(
                  'Track Your Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  requestRefend() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15),
      child: Row(
        children: [
          Text(
            'Request refund',
            style: TextStyle(
              color: themeColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          const Icon(Icons.info, color: Colors.grey, size: 12),
        ],
      ),
    );
  }

  itemDetail() {
    return Expanded(
      flex: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.5.h,
          ),
          Row(children: [
            Icon(
              FontAwesomeIcons.list,
              color: themeColor,
              size: 4.w,
            ),
            SizedBox(
              width: 0.5.h,
            ),
            Text(
              "Order Number: ${widget.index.toString()} ",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Row(children: [
                Icon(
                  FontAwesomeIcons.clock,
                  color: themeColor,
                  size: 4.w,
                ),
                SizedBox(
                  width: 0.5.h,
                ),
                Text(
                  timeago.format(
                      DateTime.parse(widget.order!.createdAt.toString())),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(children: [
            Icon(
              FontAwesomeIcons.paperclip,
              color: themeColor,
              size: 4.w,
            ),
            SizedBox(
              width: 1.h,
            ),
            Text(
              widget.order!.orderStatus.toString().contains("null")
                  ? "Pending"
                  : widget.order!.orderStatus.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: themeColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget builqr(String orderStatus) {
    return orderStatus == "ORDERED" || orderStatus == "ARRIVED"
        ? qrCode()
        : const SizedBox();
  }

  buildtrack(String status) {
    return status == "ORDERED" || status == "ARRIVED"
        ? trackYourOrderButton()
        : const SizedBox();
  }

  buildbutton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [themeColor, themeColorFaded],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.2.w, horizontal: 0.3.w),
          child: Icon(
            !isExpanded
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_up_rounded,
            color: Colors.white,
            size: 8.w,
          ),
        ),
      ),
    );
  }

  buildcancelorder(String orderStatus) {
    return orderStatus == "null" || orderStatus == "ASSIGNED"
        ? canclebutton()
        : const SizedBox();
  }

  canclebutton() {
    return SizedBox(
      height: 12.h,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: SizedBox(
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
                        _showCancelReasonsDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shadowColor: themeColor,
                        padding: EdgeInsets.symmetric(vertical: 2.3.h),
                      ),
                      child: Text(
                        'Cancel order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelReasonsDialog() {
    List<Widget> reasonButtons = widget.controller.cancellationReasonModel
        .map((reason) =>
            _cancelReasonButton(reason, (String cancellationReason) {
              // Handle the button press here, using the passed id

              widget.controller.cancelOrder(context, cancellationReason,
                  widget.order!.id.toString(), widget.order!.orderId);
              Get.back(); // Close the dialog
            }))
        .toList();

    Get.defaultDialog(
      title: 'Cancel Order',
      content: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Column(
          children: reasonButtons,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          icon: const Icon(Icons.close),
          alignment: Alignment.topRight,
        ),
      ],
    );
  }

  Widget _cancelReasonButton(
      CancellationReasonModel reason, Function(String) onPressedCallback) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0), // update padding values
      child: SizedBox(
        width: 40.w,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [themeColor, themeColorFaded],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
              onPressedCallback(
                  reason.name); // Pass the reason.id to the callback function
              KeyboardUtil.hideKeyboard(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 2.0.h),
            ),
            child: Text(
              reason.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
