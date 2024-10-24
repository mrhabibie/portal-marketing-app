import 'package:bps_portal_marketing/domain/core/model/contact/response/follow_up_response.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/theme.dart';
import '../utils/resources/enums.dart';

class FollowUpItem extends StatelessWidget {
  const FollowUpItem({
    super.key,
    required this.customer,
    this.isDetail = false,
  });

  final Customer customer;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: contactStatusBgColor[customer.status],
      child: Padding(
        padding: EdgeInsets.all(AppDimension.style10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: AppDimension.width30,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: AppDimension.height4),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimension.width6,
                      vertical: AppDimension.height2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimension.style4),
                      color: contactStatusColor[customer.status],
                    ),
                    child: Text(
                      contactStatusInitial[customer.status] ?? '-',
                      style: TextStyles.smallNormalBold
                          .copyWith(color: Pallet.neutralWhite),
                    ),
                  ),
                  Text(
                    customer.brand.substring(0, 3).toUpperCase(),
                    style: TextStyles.smallNormalBold,
                  ),
                ],
              ),
            ),
            SizedBox(width: AppDimension.width10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    customer.contact,
                    style: TextStyles.regularNormalBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: AppDimension.height4),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Iconsax.shop5,
                          size: AppDimension.style14,
                          color: Pallet.neutral600,
                        ),
                        SizedBox(width: AppDimension.width6),
                        Expanded(
                          child: Text(
                            customer.group,
                            style: TextStyles.smallNormalBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Iconsax.message5,
                        size: AppDimension.style14,
                        color: Pallet.neutral600,
                      ),
                      SizedBox(width: AppDimension.width6),
                      Expanded(
                        child: Text(
                          customer.response,
                          style: TextStyles.smallNormalRegular.copyWith(
                            color: Pallet.neutral700,
                          ),
                          maxLines: isDetail ? null : 2,
                          overflow: isDetail ? null : TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
