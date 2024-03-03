import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/county_model.dart';
import 'package:smart_pay/app/modules/authentication/data/model/register_model.dart';
import 'package:smart_pay/app/modules/authentication/domain/provider/register_provider.dart';
import 'package:smart_pay/app/modules/authentication/presentation/components/select_country_sheet_component.dart';
import 'package:smart_pay/app/modules/authentication/presentation/pages/set_pin_page.dart';

import 'package:smart_pay/app/shared/shared.dart';

import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../../data/model/user_model.dart';
import '../../domain/service/authentication_service.dart';
import '../components/select_country_tile_component.dart';

class RegisterPage extends StatefulHookConsumerWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  String password = "";

  @override
  Widget build(BuildContext context) {
    final username = useState("");
    final fullName = useState("");

    final country = useState<CountryModel?>(null);

    return ThemeBuilder(
      appBar: const CustomAppBar(),
      builder: (context, colors, ref) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Spacings.spacing30),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Hey there!tell us a bit\n',
                        style: TextStyle(
                          color: colors.always111827,
                          fontSize: TextSizes.size24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      TextSpan(
                        text: 'about ',
                        style: TextStyle(
                          height: 1.5,
                          color: colors.always111827,
                          fontSize: TextSizes.size24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      TextSpan(
                        text: 'yourself',
                        style: TextStyle(
                          color: colors.always0A6375,
                          fontSize: TextSizes.size24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacings.spacing30),
                Expanded(
                  child: ListView(
                    children: [
                      CustomTextField(
                        hint: "Full name",
                        onChanged: (v) {
                          fullName.value = v.trim();
                        },
                      ),
                      const SizedBox(height: Spacings.spacing14),
                      CustomTextField(
                        hint: "Username",
                        onChanged: (v) {
                          username.value = v.trim();
                        },
                      ),
                      const SizedBox(height: Spacings.spacing14),
                      SelectCountryTileComponent(
                        country: country.value,
                        onTap: () {
                          selectCountryBottomSheeet(
                            context,
                            onCountrySelected: (data) {
                              country.value = data;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Spacings.spacing14),
                      CustomTextField(
                        hint: "Password",
                        onChanged: (v) {
                          password = v.trim();
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: Spacings.spacing10),
                      if (password != "")
                        BaseText(
                          _passwordState(),
                          color:
                              _passwordStrong() ? Colors.green : Colors.orange,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacings.spacing30),
                CustomButtonComponent(
                  text: "Continue",
                  validator: () {
                    return username.value.isNotEmpty &&
                        fullName.value.isNotEmpty &&
                        country.value != null &&
                        password.isNotEmpty &&
                        _passwordStrong();
                  },
                  onPressed: () async {
                    showLoader(context);
                    final p = ref.read(registerProvider);
                    final email_ = await SecureStorage.retrive(
                        key: SecureStorageKeys.email);
                    p.register(
                      RegisterModel(
                        email: email_ ?? "",
                        password: password,
                        fullName: fullName.value,
                        username: username.value,
                        country:
                            (country.value == null) ? "" : country.value!.code,
                      ),
                      onDone: (state) {
                        pop(context);
                        if (state.error) {
                          context.showError(state.message);
                          return;
                        }

                        _updateUser(state.data!, ref);

                        context.showSuccess("Registeration Success!");
                        pushTo(context, const SetPinPage());
                      },
                    );
                  },
                ),
                const SizedBox(height: Spacings.spacing20),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _passwordStrong() {
    return password.isNotEmpty &&
        password.length > 6 &&
        password.containsUppercase &&
        password.containsSpecialCharacter &&
        password.containsDigit;
  }

  String _passwordState() {
    if (password.isEmpty) {
      return ' Password should not be empty';
    } else if (password.isNotEmpty && password.length < 6) {
      return ' Password must be more than 6 characters';
    } else if (!password.containsUppercase) {
      return ' Password must contain at least one upper case';
    } else if (!password.containsSpecialCharacter) {
      return ' Password must contain at least one special character';
    } else if (!password.containsDigit) {
      return ' Password should contain one digit';
    } else {
      return ' Password seems good';
    }
  }
}

void _updateUser(User user, WidgetRef ref) {
  ref.read(userProvider.notifier).state = user;
}
