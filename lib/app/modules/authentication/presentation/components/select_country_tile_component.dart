import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';

import '../../data/model/county_model.dart';

class SelectCountryTileComponent extends StatelessWidget {
  final CountryModel? country;
  final VoidCallback onTap;
  const SelectCountryTileComponent({
    super.key,
    this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              color: color.alwaysF9FAFB,
              borderRadius: BorderRadius.circular(
                Spacings.spacing16,
              ),
            ),
            child: Row(
              children: [
                if (country == null) ...[
                  BaseText(
                    "Select country",
                    color: color.always9CA3AF,
                    fontWeight: FontWeight.w400,
                    fontSize: TextSizes.size16,
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down),
                ],
                if (country != null) ...[
                  SvgPicture.asset(country!.flag),
                  const SizedBox(width: Spacings.spacing10),
                  BaseText(
                    country!.name,
                    color: color.always111827,
                    fontWeight: FontWeight.w700,
                    fontSize: TextSizes.size16,
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
