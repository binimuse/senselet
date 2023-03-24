import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../const.dart';
import 'cache_image_network.dart';
import 'global_style.dart';

class ReusableWidget {
  PreferredSizeWidget bottomAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey[100],
          height: 1.0,
        ));
  }

  Widget buildSearchList(context, index, data) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //  Get.toNamed(Routes.PRODACT_DETAIL, arguments: {"id": data[index].id});
      },
      child: Wrap(
        children: [
          Container(
            width: 100.w,
            margin: EdgeInsets.only(
              left: 4.w,
              top: 4.w,
              bottom: 4.w,
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CachedNetworkImage(
                        imageUrl: IMAGE_URL + data[index].image),
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          data[index].name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          '${data[index].short_description}',
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          '${data[index].description}',
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            const Text(
                              "returnable",
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              style: GlobalStyle.textTag,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(
                              width: 1.h,
                            ),
                            data[index].is_returnable == true
                                ? const Text("Yes",
                                    style: GlobalStyle.textRatingDistances)
                                : const Text("No",
                                    style: GlobalStyle.textRatingDistances),
                            SizedBox(
                              width: 1.h,
                            ),
                            // // Text(
                            // //   '${data[index].price.toString()} ETB',
                            //   style: GlobalStyle.textPromo,
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {},
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
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.white,
                                    size: 8.w,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.5.h,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalListCard(context, index, data, topRatedPharmaBranch) {
    final double imageWidth = (MediaQuery.of(context).size.width / 2.3);
    final double imageheight = (MediaQuery.of(context).size.width / 2.57);
    return SizedBox(
      width: imageWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(6)),
                  child: buildCacheNetworkImage(
                      width: imageWidth,
                      height: imageheight,
                      url: data[index].image)),
              Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 20,
                        child: Text(data[index].name,
                            style: GlobalStyle.cardTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRestaurantList(context, index, data) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize,
                      height: boxImageSize,
                      url: data[index].image,
                      plColor: Colors.transparent),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].name,
                        style: GlobalStyle.textRestaurantNameBig,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Text(
                      //   data[index].tag,
                      //   style: GlobalStyle.textTag,
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.phone,
                              color: Colors.orange, size: 15),
                          const SizedBox(width: 5),
                          Text(data[index].phone.toString(),
                              style: GlobalStyle.textRatingDistances),
                          const SizedBox(width: 6),
                          const Icon(Icons.location_pin,
                              color: themeColor, size: 15),
                          const SizedBox(width: 2),
                          Text(data[index].address.toString(),
                              style: GlobalStyle.textRatingDistances),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        (index == data.length - 1)
            ? Wrap()
            : Divider(
                height: 0,
                color: Colors.grey[400],
              )
      ],
    );
  }

  buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 11.h,
      title: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
            child: ClipRRect(
              child: Image.asset('assets/images/logo_green.png'),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(
            "SENSELET",
            style: TextStyle(
              color: const Color(0xff129797),
              fontWeight: FontWeight.w400,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: const Color(0xffF6FBFB),
      shadowColor: Colors.transparent,
    );
  }

  Widget deliveryInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: const Text(
            'Delivery Information',
            style: GlobalStyle.deliveryInformationTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: SOFT_BLUE),
                    child: const Center(
                        child: Icon(Icons.local_pharmacy,
                            size: 12, color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Text('M3GC+C2 Mexico, Addis abeba, Ethiopia',
                        style: GlobalStyle.deliveryInformationAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Container(
                  margin: const EdgeInsets.only(left: 11),
                  width: 1,
                  height: 12,
                  color: SOFT_GREY),
              const SizedBox(height: 2),
              Row(
                children: const [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(
                        child: Icon(Icons.location_pin,
                            size: 24, color: themeColor)),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text('Home Address',
                        style: GlobalStyle.deliveryInformationAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              Divider(
                height: 32,
                color: Colors.grey[400],
              ),
              const Text('Deliverd By',
                  style: GlobalStyle.deliveryInformationNoteTitle),
              const SizedBox(height: 4),
              const Text('Yetem Deleivery',
                  style: GlobalStyle.deliveryInformationNoteValue)
            ],
          ),
        )
      ],
    );
  }

  Widget divider1() {
    return Container(
      height: 8,
      color: Colors.grey[100],
    );
  }

  Widget divider2() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 32,
        color: Colors.grey[400],
      ),
    );
  }

  Widget divider3() {
    return Divider(
      height: 32,
      color: Colors.grey[400],
    );
  }
}
