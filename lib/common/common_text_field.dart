import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/helper/validate_helper.dart';
import 'bloc/text_field/text_field_cubit.dart';

class CommonTextFormField extends StatelessWidget {
  final String? title;
  final String hint;
  final TextStyle? titleTextStyle;
  final int validatorID;
  final TextInputFormatter? filteringTextInputFormatter;
  final bool? readOnly;
  final Color? fillColor;
  final int? maxline;
  final IconData? icons;
  final TextInputType type;
  final BoxShadow? shadow;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obsecureText;
  final ValueChanged<String>? onChanged;

  const CommonTextFormField({
    super.key,
    this.shadow,
    this.fillColor,
    this.filteringTextInputFormatter,
    this.readOnly,
    this.titleTextStyle,
    this.icons,
    this.title,
    this.validator,
    required this.hint,
    required this.validatorID,
    required this.type,
    required this.controller,
    required this.obsecureText,
    this.onChanged,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty ?? false)
          Text(
            title!,
            style: titleTextStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              ?shadow,
            ],
          ),
          child: BlocBuilder<TextFieldCubit, TextFieldState>(
            builder: (context, state) {
              return TextFormField(
                style: Theme.of(context).textTheme.bodySmall,
                readOnly: readOnly ?? false,
                autovalidateMode: AutovalidateMode.always,
                keyboardType: type,
                maxLines: maxline ?? 1,
                obscureText: obsecureText == false ? false : state.isInvisible,
                controller: controller,
                inputFormatters: [
                  ?filteringTextInputFormatter,
                ],
                onChanged: onChanged,
                decoration: InputDecoration(
                  prefixIcon: icons != null ? Icon(icons) : null,
                  prefixIconColor: icons != null
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  filled: true,
                  fillColor: fillColor ?? Theme.of(context).cardColor,
                  focusColor: Theme.of(context).cardColor,
                  suffixIcon: validatorID == 0
                      ? IconButton(
                          onPressed: () {
                            context.read<TextFieldCubit>().toggleVisible();
                          },
                          icon: Icon(
                            state.isInvisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 10.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  hintText: hint,
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                ),
                validator: validator ??
                    (value) {
                      if (validatorID == 0) {
                        return ValidateHelper.isPasswordValidate(
                            value!, context);
                      } else if (validatorID == 1) {
                        return ValidateHelper.isEmailValidate(value!, context);
                      } else if (validatorID == 2) {
                        return ValidateHelper.isPhoneNumberValidate(
                            value!, context);
                      } else if (validatorID == 3) {
                        return ValidateHelper.isNormalValidate(
                          value!,
                          title == null ? '' : '$title ',
                          context,
                        );
                      }
                      return null;
                    },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
