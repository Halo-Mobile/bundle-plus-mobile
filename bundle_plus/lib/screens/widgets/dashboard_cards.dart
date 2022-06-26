import 'package:bundle_plus/screens/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredPage extends StatelessWidget {
  const StaggeredPage({
    Key? key,
    required this.totalRevenue,
    required this.completedOrders,
    required this.pendingOrders,
  }) : super(key: key);

  final double totalRevenue;
  final int completedOrders;
  final int pendingOrders;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            // StaggeredGridTile.count(
            //   crossAxisCellCount: 2,
            //   mainAxisCellCount: 2,
            //   child: Tile(index: 0),
            // ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Tile(
                index: 1,
                backgroundColor: Colors.orange,
                icondata: Icons.attach_money,
                title: 'Total Revenue',
                subtitle: "RM " + totalRevenue.toString(),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Tile(
                index: 2,
                backgroundColor: Colors.pink,
                icondata: Icons.check_circle,
                title: 'Completed Orders',
                subtitle: completedOrders.toString(),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Tile(
                index: 3,
                backgroundColor: Colors.blue,
                icondata: Icons.warning,
                title: 'Pending Orders',
                subtitle: pendingOrders.toString(),
              ),
            ),
            // StaggeredGridTile.count(
            //   crossAxisCellCount: 4,
            //   mainAxisCellCount: 2,
            //   child: Tile(index: 4),
            // ),
          ],
        ),
      ),
    );
  }
}
