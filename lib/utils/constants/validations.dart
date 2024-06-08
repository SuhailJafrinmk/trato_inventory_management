import 'package:trato_inventory_management/utils/constants/regex.dart';

class AppValidations {
  static String? emailValidation(String email) {
    if (!RegexUtils.emailRegExp.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegexUtils.atLeastAnUppercase.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegexUtils.atLeastANumber.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!RegexUtils.specialChar.hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? passwordConfirmation(
      String? passwordConfirmation, String? enteredPassword) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return 'please enter a password';
    }
    if (passwordConfirmation != enteredPassword) {
      return 'passwords didnt match';
    }
    return null;
  }

  static String? gstValidation(String? gst) {
    if (gst == null || gst.isEmpty) {
      return 'please enter a gst';
    }
    if (!RegexUtils.gstValidation.hasMatch(gst)) {
      return 'please enter a valid gst id';
    }
    return null;
  }

  static String? productName(
      String? productName, List<String> availableProducts) {
    if (productName == null || productName.trim().isEmpty) {
      return 'please add a product name';
    }
    if (productName.trim().length > 30) {
      return 'Product length should be less than 30';
    }
    if (availableProducts.contains(productName)) {
      return 'Product already added';
    }
    return null;
  }

  static String? purchasePrice(String ?purchasePrice) {
    if (purchasePrice == null || purchasePrice.trim().isEmpty) {
      return 'please add Purchase price';
    }
    if (purchasePrice.trim().length > 10) {
      return 'Product price should be less than 10';
    }
    return null;
  }

  static String? sellingPrice(String ?sellingPrice) {
    if (sellingPrice == null || sellingPrice.trim().isEmpty) {
      return 'please add selling price';
    }
    if (sellingPrice.trim().length > 50) {
      return 'Product length should be less than 30';
    }
    return null;
  }

  static String? minimumQuantity(String? minimumQuantity) {
    if (minimumQuantity == null || minimumQuantity.trim().isEmpty) {
      return 'please add minimum quantity';
    }
    if (minimumQuantity.trim().length > 2) {
      return 'Minimum quantity should be less than 100';
    }
    return null;
  }

  static String? supplierName(String? supplierName) {
    if (supplierName == null || supplierName.trim().isEmpty) {
      return 'please add supplier name';
    }
    if (supplierName.trim().length > 50) {
      return 'supplier name should be less than 30 characters';
    }
    return null;
  }
}
