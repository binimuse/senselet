import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

import '../../../../constants/const.dart';
import '../../controllers/order_history_controller.dart';
import '../../data/Model/order_history_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    this.order,
    required this.orderitem,
    required this.history,
    required this.controller,
    required this.status,
  }) : super(key: key);

  final OrderHistoryModel? order;
  final OrderHistoryItemsModel orderitem;
  final bool history;
  final String status;

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
                              child: Container(
                                width: 16.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: themeColor,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: CachedNetworkImage(
                                    imageUrl: IMAGE_URL +
                                        widget.orderitem.prodact_images
                                            .toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                      GestureDetector(
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
                            padding: EdgeInsets.symmetric(
                                vertical: 0.2.w, horizontal: 0.3.w),
                            child: Icon(
                              !isExpanded
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.keyboard_arrow_up_rounded,
                              color: Colors.white,
                              size: 8.w,
                            ),
                          ),
                        ),
                      ),
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
                              "Your Item",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black87,
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
                                  "Item Total",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  widget.order!.order_total.toString(),
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "status",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  widget.order!.status.toString(),
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
                                  "Tax",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${widget.order!.tax.toString()} Birr",
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
                            height: 1.5.h,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 3,
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Delivery Fee",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Icon(
                                  Icons.error,
                                  color: Colors.grey.shade200,
                                  size: 4.w,
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  "${widget.order!.delivery_fee.toString()} Birr",
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

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total",
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
                                Text(
                                  widget.order!.total.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(2.w),
                            child: Material(
                              color: const Color(0xffEBF5F4),
                              borderRadius: BorderRadius.circular(2.w),
                              child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "Total saving",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Text(
                                      "0 Birr",
                                      style: TextStyle(
                                        color: themeColor,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          //order Status

                          //   buildOrderStatus(widget.status),
                          widget.status.toString() == "ORDERED" ||
                                  widget.status.toString() == "ARRIVED"
                              ? requestRefend()
                              : const SizedBox(),

                          SizedBox(
                            height: 1.h,
                          ),

                          widget.status == "ORDERED" ||
                                  widget.status == "ARRIVED"
                              ? qrCode()
                              : const SizedBox(),

                          widget.status == "ORDERED" ||
                                  widget.status == "ARRIVED"
                              ? trackYourOrderButton()
                              : const SizedBox(),

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
          Row(children: [
            // Icon(
            //   FontAwesomeIcons.cartPlus,
            //   color: themeColor,
            //   size: 4.w,
            // ),
            SizedBox(
              width: 0.5.h,
            ),
            Text(
              "Order Id: : ${widget.order!.id.toString()} ",
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
            height: 0.5.h,
          ),
          Row(children: [
            // Icon(
            //   FontAwesomeIcons.locationArrow,
            //   color: themeColor,
            //   size: 4.w,
            // ),
            SizedBox(
              width: 0.5.h,
            ),
            Text(
              "Address: ${widget.order!.placeName.toString()} ",
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
                  size: 3.w,
                ),
                SizedBox(
                  width: 0.5.h,
                ),
                Text(
                  timeAgo(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ]),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                " ${widget.order!.total.toString()} Birr",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: themeColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String timeAgo({bool numericDates = true}) {
    var dateFormat = 'MM/dd/yy HH:mm';
    final DateTime docDateTime =
        DateTime.parse(widget.order!.created_at.toString());
    DateFormat(dateFormat).format(docDateTime);

    // var inputFormat = DateFormat('MM/dd/yy HH:mm');

    final date2 = DateTime.now();
    final difference = date2.difference(docDateTime);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
