import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/countries_data.dart';

import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../../data/model/county_model.dart';

Future<void> selectCountryBottomSheeet(
  BuildContext context, {
  required ValueChanged<CountryModel> onCountrySelected,
}) async {
  await showModalBottomSheet<void>(
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          Spacings.spacing40,
        ),
        topRight: Radius.circular(
          Spacings.spacing40,
        ),
      ),
    ),
    builder: (context) {
      return SelectCountrySheetComponent(
        onCountry: onCountrySelected,
      );
    },
  );
}

class SelectCountrySheetComponent extends HookConsumerWidget {
  final ValueChanged<CountryModel> onCountry;
  const SelectCountrySheetComponent({
    super.key,
    required this.onCountry,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return Container(
          height: 500,
          padding: const EdgeInsets.symmetric(
            vertical: Spacings.spacing20,
            horizontal: Spacings.spacing30,
          ),
          decoration: BoxDecoration(
            color: color.lightWhiteDarkBlack,
            borderRadius: BorderRadius.circular(Spacings.spacing40),
          ),
          child: Column(
            children: [
              const SizedBox(height: Spacings.spacing10),
              Row(
                children: [
                  const Expanded(
                    child: CustomTextField(
                      hint: "Search",
                    ),
                  ),
                  const SizedBox(width: Spacings.spacing10),
                  GestureDetector(
                    onTap: () => pop(context),
                    child: BaseText(
                      "Cancel",
                      fontWeight: FontWeight.w700,
                      color: color.always111827,
                      fontSize: TextSizes.size16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacings.spacing30),
              ListView.separated(
                shrinkWrap: true,
                itemCount: countries.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: Spacings.spacing40),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return GestureDetector(
                    onTap: () {
                      onCountry(country);
                      pop(context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(country.flag),
                        const SizedBox(width: Spacings.spacing14),
                        BaseText(
                          country.code,
                          fontSize: TextSizes.size16,
                          color: color.always6B7280,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: Spacings.spacing14),
                        BaseText(
                          country.name,
                          fontSize: TextSizes.size16,
                          color: color.always111827,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
