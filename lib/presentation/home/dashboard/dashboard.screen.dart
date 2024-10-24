import 'package:bps_portal_marketing/domain/core/model/home/response/price_response.dart';
import 'package:bps_portal_marketing/presentation/home/dashboard/controllers/dashboard.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../../infrastructure/utils/extension/extension.dart';
import '../../../infrastructure/widgets/widgets.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.controller});

  final DashboardController controller;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              pinned: true,
              snap: true,
              primary: true,
              forceElevated: false,
              backgroundColor: Pallet.neutralWhite,
              flexibleSpace: TabBar(
                controller: _tabController,
                tabs: const <Tab>[
                  Tab(text: 'PGC 100'),
                  Tab(text: 'PGC 1.5'),
                  Tab(text: 'PGC 1'),
                ],
                labelStyle: TextStyles.smallNormalBold,
                automaticIndicatorColorAdjustment: true,
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: WidgetStateColor.resolveWith(
                    (states) => Pallet.purple[200]!),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Pallet.purple,
                      width: 2,
                    ),
                  ),
                ),
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ];
      },
      body: Obx(
        () => TabBarView(
          controller: _tabController,
          children: <Widget>[
            widget.controller.isLoading.isTrue
                ? Column(
                    children: <Widget>[
                      ...Iterable.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.only(
                              left: 15, top: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ShimmerLoading(
                                    width: 50,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  ShimmerLoading(
                                    width: 150,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                              index != 6
                                  ? const Divider(color: Pallet.neutral300)
                                  : const Center(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '',
                                  style: TextStyles.regularNormalRegular,
                                ),
                                Text(
                                  '',
                                  style: TextStyles.regularNormalBold,
                                ),
                              ],
                            ),
                            const Divider(color: Pallet.neutral300),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ...Iterable.generate(
                              widget.controller.price!.pgc100.length,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 700),
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          widget.controller.price!.pgc100
                                              .elementAt(index)
                                              .perkalian,
                                          style: TextStyles.regularNormalRegular
                                              .copyWith(
                                            color: widget
                                                    .controller.price!.pgc100
                                                    .elementAt(index)
                                                    .isThreshold
                                                ? widget.controller
                                                    .animatedColor.value
                                                : Pallet.neutral900,
                                          ),
                                        ),
                                        Text(
                                          widget.controller.price!.pgc100
                                              .elementAt(index)
                                              .harga
                                              .toRupiah,
                                          style: TextStyles.regularNormalBold
                                              .copyWith(
                                            color: widget
                                                    .controller.price!.pgc100
                                                    .elementAt(index)
                                                    .isThreshold
                                                ? widget.controller
                                                    .animatedColor.value
                                                : Pallet.neutral900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  index !=
                                          widget.controller.price!.pgc100
                                                  .length -
                                              1
                                      ? const Divider(color: Pallet.neutral300)
                                      : const Center(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            widget.controller.isLoading.isTrue
                ? Column(
                    children: <Widget>[
                      ...Iterable.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.only(
                              left: 15, top: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ShimmerLoading(
                                    width: 50,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  ShimmerLoading(
                                    width: 150,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                              index != 6
                                  ? const Divider(color: Pallet.neutral300)
                                  : const Center(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: AppDimension.width14,
                          top: AppDimension.height14,
                          right: AppDimension.width14,
                          bottom: AppDimension.height4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyles.regularNormalRegular,
                            ),
                            Text(
                              '',
                              style: TextStyles.regularNormalBold,
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Pallet.neutral300),
                      Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.controller.price?.pgc15.length ?? 0,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const Divider(color: Pallet.neutral300),
                          itemBuilder: (context, index) {
                            final PGCEcer pgcEcer =
                                widget.controller.price!.pgc15.elementAt(index);

                            return Container(
                              margin: EdgeInsets.only(
                                left: AppDimension.width14,
                                right: AppDimension.width14,
                                bottom: AppDimension.height4,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      pgcEcer.perkalian,
                                      style: TextStyles.regularNormalBold,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      pgcEcer.name,
                                      style: TextStyles.regularNormalRegular,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      widget.controller.isLoading.isTrue
                                          ? '...'
                                          : pgcEcer.harga.toRupiah,
                                      style: TextStyles.regularNormalBold,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            widget.controller.isLoading.isTrue
                ? Column(
                    children: <Widget>[
                      ...Iterable.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.only(
                              left: 15, top: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ShimmerLoading(
                                    width: 50,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  ShimmerLoading(
                                    width: 150,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                              index != 6
                                  ? const Divider(color: Pallet.neutral300)
                                  : const Center(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: AppDimension.width14,
                          top: AppDimension.height14,
                          right: AppDimension.width14,
                          bottom: AppDimension.height4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyles.regularNormalRegular,
                            ),
                            Text(
                              '',
                              style: TextStyles.regularNormalBold,
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Pallet.neutral300),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.controller.price?.pgc1.length ?? 0,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const Divider(color: Pallet.neutral300),
                        itemBuilder: (context, index) {
                          final PGCEcer pgcEcer =
                              widget.controller.price!.pgc1.elementAt(index);

                          return Container(
                            margin: EdgeInsets.only(
                              left: AppDimension.width14,
                              right: AppDimension.width14,
                              bottom: AppDimension.height4,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    pgcEcer.perkalian,
                                    style: TextStyles.regularNormalBold,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    pgcEcer.name,
                                    style: TextStyles.regularNormalRegular,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.controller.isLoading.isTrue
                                        ? '...'
                                        : pgcEcer.harga.toRupiah,
                                    style: TextStyles.regularNormalBold,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

    return Scaffold(
      backgroundColor: Pallet.neutralWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.purple,
        foregroundColor: Pallet.neutralWhite,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3.copyWith(color: Pallet.neutralWhite),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: "change-lang-text".tr,
          onPressed: () => Get.updateLocale(Get.locale == const Locale('id')
              ? const Locale('en')
              : const Locale('id')),
          icon: const Icon(Iconsax.language_circle),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "user-profile-text".tr,
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(Iconsax.user),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getPrice(),
        color: Pallet.purple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () => Card(
                elevation: 0,
                color: Pallet.purple,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'live-gold-price-text'.tr,
                        style: TextStyles.regularNormalBold
                            .copyWith(color: Pallet.neutralWhite),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: controller.isLoading.isTrue
                                  ? '...'
                                  : controller.price!.goldPriceIdr.toRupiah,
                              style: TextStyles.largeNormalBold.copyWith(
                                fontSize: 26,
                                color: Pallet.neutralWhite,
                              ),
                            ),
                            TextSpan(
                              text: controller.isLoading.isTrue
                                  ? ''
                                  : '  ≈ ${controller.price!.loko.toIdr}',
                              style: TextStyles.smallNormalBold.copyWith(
                                fontSize: 14,
                                color: Pallet.neutralWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimension.height20),
                      Text(
                        'usd-to-idr-text'.tr,
                        style: TextStyles.regularNormalBold
                            .copyWith(color: Pallet.neutralWhite),
                      ),
                      RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: controller.isLoading.isTrue
                                  ? '...'
                                  : 1.toDollar,
                              style: TextStyles.largeNormalBold.copyWith(
                                fontSize: 26,
                                color: Pallet.neutralWhite,
                              ),
                            ),
                            TextSpan(
                              text: controller.isLoading.isTrue
                                  ? ''
                                  : '  ≈ ${controller.price!.usDtoIdr.toRupiah}',
                              style: TextStyles.smallNormalBold.copyWith(
                                fontSize: 14,
                                color: Pallet.neutralWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimension.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'last-update-text'.tr,
                                style: TextStyles.tinyNormalRegular
                                    .copyWith(color: Pallet.neutralWhite),
                              ),
                              Text(
                                controller.isLoading.isTrue
                                    ? '...'
                                    : controller.currentDate.toIdDateTime,
                                style: TextStyles.tinyNormalBold
                                    .copyWith(color: Pallet.neutralWhite),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => controller.getPrice(),
                            tooltip: 'refresh-text'.tr,
                            icon: const Icon(
                              Iconsax.refresh_circle,
                              color: Pallet.neutralWhite,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: CustomTabBar(controller: controller)),
          ],
        ),
      ),
    );
  }
}
