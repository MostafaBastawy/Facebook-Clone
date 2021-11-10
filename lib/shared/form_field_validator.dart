import 'package:form_field_validator/form_field_validator.dart';

class FormFieldValidate {
  static final emailValidator = MultiValidator([
    EmailValidator(errorText: 'email is invalid'),
    RequiredValidator(errorText: 'Required *'),
  ]);
  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Required *'),
    LengthRangeValidator(
        min: 6, max: 12, errorText: 'password range must be 6~12 character'),
  ]);
  static final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Required *'),
    LengthRangeValidator(
        min: 11, max: 11, errorText: 'phone number must be 11 digits'),
  ]);
  static final fullNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Required *'),
    MinLengthValidator(6, errorText: 'full name must be entered'),
  ]);
}
