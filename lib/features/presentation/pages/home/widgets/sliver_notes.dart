// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class SliverNotes extends StatelessWidget {
  final Widget child;

  const SliverNotes({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (_, __) {
        return [_appBar(context)];
      },
      body: RefreshIndicator(
        displacement: 80,
        onRefresh: () => AppFunction.onRefresh(context),
        child: child,
      ),
    );
  }

  _appBar(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      sliver: SliverAppBar(
        floating: true,
        snap: true,
        titleSpacing: 0,
        toolbarHeight: 50,
        leadingWidth: 0,
        forceMaterialTransparency: true,
        title: CommonSearchBar(),
        systemOverlayStyle: AppDevice.setStatusBartSilverAppBar(),
        leading: SizedBox(),
      ),
    );
  }
}
