import 'package:bps_portal_marketing/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class PGCTab extends StatefulWidget {
  const PGCTab({
    super.key,
    required this.title,
    required this.children,
  });

  final List<Widget> title;
  final List<Widget> children;

  @override
  State<PGCTab> createState() => _PGCTabState();
}

class _PGCTabState extends State<PGCTab> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    assert(widget.title.length == widget.children.length);

    _scrollController = ScrollController();

    _tabController = TabController(length: widget.children.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              tabs: widget.title,
              labelStyle: TextStyles.smallNormalBold,
              automaticIndicatorColorAdjustment: true,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: WidgetStateColor.resolveWith(
                  (states) => Pallet.info700.withOpacity(0.1)),
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Pallet.info700,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.children,
      ),
    );
  }
}
