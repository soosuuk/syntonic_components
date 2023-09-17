// import 'package:syntonic_components/models/appointment_personal_setting_view_options_model.dart';
// import 'package:syntonic_components/models/chat_model.dart';
// import 'package:syntonic_components/models/equipment_model.dart';
// import 'package:syntonic_components/models/salon_model.dart';
// import 'package:syntonic_components/models/staff_model.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// import '../../models/account_model.dart';
// import '../../models/authorities_model.dart';
// import '../../models/authority_model.dart';
// import '../../models/customer_authority_model.dart';
// import '../../models/sale_authority_model.dart';
//
// class LocalStorageService {
//   /// Get request token.
//   static Future<String?> getToken() async {
//     String? _requestToken;
//     final logDirectory = await getApplicationDocumentsDirectory();
//     print("logDirectory ===" + logDirectory.toString());
//     var filePath = File('${logDirectory.path}/token.txt');
//     print("file path ===" + filePath.toString());
//
//     if (filePath.existsSync()) {
//       print("file exist");
//       _requestToken = await filePath.readAsString();
//     }
//     return _requestToken;
//   }
//
//   /// Get own authorities.
//   static get myAuthorities async {
//     final logDirectory = await getApplicationDocumentsDirectory();
//
//     // Plan Type
//     File currentPlanTypeFilePath =
//         File('${logDirectory.path}/current_plan_type.txt');
//     String? currentPlanType;
//     if (currentPlanTypeFilePath.existsSync()) {
//       currentPlanType = await _getStringFromFilePath(currentPlanTypeFilePath);
//     }
//
//     // Salon id.
//     File salonIdFilePath = File('${logDirectory.path}/salon_id.txt');
//     String? salonId;
//     if (salonIdFilePath.existsSync()) {
//       salonId = await _getStringFromFilePath(salonIdFilePath);
//     }
//
//     File groupIdFilePath = File('${logDirectory.path}/group_id.txt');
//     String? groupId;
//     if (groupIdFilePath.existsSync()) {
//       groupId = await _getStringFromFilePath(groupIdFilePath);
//     }
//
//     SalonModel.mine(
//         id: BigInt.from(int.parse(salonId!)),
//         groupId: BigInt.from(int.parse(groupId!)),
//         planType: _getPlanType(currentPlanType!));
//
//     AccountModel accountModel = AccountModel.mine();
//
//     File accountAuthorityFilePath =
//         File('${logDirectory.path}/account_authority.txt');
//     if (accountAuthorityFilePath.existsSync()) {
//       String account = await _getStringFromFilePath(accountAuthorityFilePath);
//       List<int> accountAuthorities = _getSplitEachChar(account);
//       accountModel.authorities.account = AuthorityModel(
//           canView: _getTrueFalseValue(accountAuthorities.length > 0 ? accountAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(accountAuthorities.length > 1 ? accountAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(accountAuthorities.length > 2 ? accountAuthorities[2] : null));
//     }
//
//     File customerAuthorityFilePath =
//         File('${logDirectory.path}/customer_authority.txt');
//     if (customerAuthorityFilePath.existsSync()) {
//       String customer = await _getStringFromFilePath(customerAuthorityFilePath);
//       List<int> customerAuthorities = _getSplitEachChar(customer);
//       accountModel.authorities.customer = CustomerAuthorityModel(
//           canView: _getTrueFalseValue(customerAuthorities.length > 0 ? customerAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(customerAuthorities.length > 1 ? customerAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(customerAuthorities.length > 2 ? customerAuthorities[2] : null),
//           canViewPrivacy: _getTrueFalseValue(customerAuthorities.length > 3 ? customerAuthorities[3] : null));
//     }
//
//     File contractAuthorityFilePath =
//         File('${logDirectory.path}/contract_authority.txt');
//     if (contractAuthorityFilePath.existsSync()) {
//       String contract = await _getStringFromFilePath(contractAuthorityFilePath);
//       List<int> contractAuthorities = _getSplitEachChar(contract);
//       accountModel.authorities.contract = AuthorityModel(
//           canView: _getTrueFalseValue(contractAuthorities.length > 0 ? contractAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(contractAuthorities.length > 1 ? contractAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(contractAuthorities.length > 2 ? contractAuthorities[2] : null));
//     }
//
//     File accountingAuthorityFilePath =
//         File('${logDirectory.path}/accounting_authority.txt');
//     if (accountingAuthorityFilePath.existsSync()) {
//       String accounting =
//           await _getStringFromFilePath(accountingAuthorityFilePath);
//       List<int> accountingAuthorities = _getSplitEachChar(accounting);
//       accountModel.authorities.accounting = AuthorityModel(
//         canView: _getTrueFalseValue(accountingAuthorities.length > 0 ? accountingAuthorities[0] : null),
//         canEdit: _getTrueFalseValue(accountingAuthorities.length > 1 ? accountingAuthorities[1] : null),
//         canDelete: _getTrueFalseValue(accountingAuthorities.length > 2 ? accountingAuthorities[2] : null));
//     }
//
//     File reservationAuthorityFilePath =
//         File('${logDirectory.path}/reservation_authority.txt');
//     if (reservationAuthorityFilePath.existsSync()) {
//       String reservation =
//           await _getStringFromFilePath(reservationAuthorityFilePath);
//       List<int> reservationAuthorities = _getSplitEachChar(reservation);
//       accountModel.authorities.appointment = AuthorityModel(
//           canView: _getTrueFalseValue(reservationAuthorities.length > 0 ? reservationAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(reservationAuthorities.length > 1 ? reservationAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(reservationAuthorities.length > 2 ? reservationAuthorities[2] : null));
//     }
//
//     File staffAuthorityFilePath =
//         File('${logDirectory.path}/staff_authority.txt');
//     if (staffAuthorityFilePath.existsSync()) {
//       String staff = await _getStringFromFilePath(staffAuthorityFilePath);
//       List<int> staffAuthorities = _getSplitEachChar(staff);
//       accountModel.authorities.staff = AuthorityModel(
//           canView: _getTrueFalseValue(staffAuthorities.length > 0 ? staffAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(staffAuthorities.length > 1 ? staffAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(staffAuthorities.length > 2 ? staffAuthorities[2] : null));
//     }
//
//     File techniqueAuthorityFilePath =
//         File('${logDirectory.path}/technique_authority.txt');
//     if (techniqueAuthorityFilePath.existsSync()) {
//       String tech = await _getStringFromFilePath(techniqueAuthorityFilePath);
//       List<int> techniqueAuthorities = _getSplitEachChar(tech);
//       accountModel.authorities.technique = AuthorityModel(
//           canView: _getTrueFalseValue(techniqueAuthorities.length > 0 ? techniqueAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(techniqueAuthorities.length > 1 ? techniqueAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(techniqueAuthorities.length > 2 ? techniqueAuthorities[2] : null));
//     }
//
//     File productAuthorityFilePath =
//         File('${logDirectory.path}/product_authority.txt');
//     if (productAuthorityFilePath.existsSync()) {
//       String product = await _getStringFromFilePath(productAuthorityFilePath);
//       List<int> productAuthorities = _getSplitEachChar(product);
//       accountModel.authorities.product = AuthorityModel(
//           canView: _getTrueFalseValue(productAuthorities.length > 0 ? productAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(productAuthorities.length > 1 ? productAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(productAuthorities.length > 2 ? productAuthorities[2] : null));
//     }
//
//     File salesAuthorityFilePath =
//         File('${logDirectory.path}/sales_authority.txt');
//     if (salesAuthorityFilePath.existsSync()) {
//       String sales = await _getStringFromFilePath(salesAuthorityFilePath);
//       List<int> salesAuthorities = _getSplitEachChar(sales);
//       accountModel.authorities.sales = SaleAuthorityModel(
//           canView: _getTrueFalseValue(salesAuthorities.length > 0 ? salesAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(salesAuthorities.length > 1 ? salesAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(salesAuthorities.length > 2 ? salesAuthorities[2] : null),
//           canViewGroupSalon: _getTrueFalseValue(salesAuthorities.length > 3 ? salesAuthorities[3] : null));
//     }
//
//     File informationAuthorityFilePath =
//         File('${logDirectory.path}/information_authority.txt');
//     if (informationAuthorityFilePath.existsSync()) {
//       String information =
//           await _getStringFromFilePath(informationAuthorityFilePath);
//       List<int> informationAuthorities = _getSplitEachChar(information);
//       accountModel.authorities.information = AuthorityModel(
//           canView: _getTrueFalseValue(informationAuthorities.length > 0 ? informationAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(informationAuthorities.length > 1 ? informationAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(informationAuthorities.length > 2 ? informationAuthorities[2] : null));
//     }
//
//     File messageAuthorityFilePath =
//         File('${logDirectory.path}/message_authority.txt');
//     if (messageAuthorityFilePath.existsSync()) {
//       String message = await _getStringFromFilePath(messageAuthorityFilePath);
//       List<int> messageAuthorities = _getSplitEachChar(message);
//       accountModel.authorities.message = AuthorityModel(
//           canView: _getTrueFalseValue(messageAuthorities.length > 0 ? messageAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(messageAuthorities.length > 1 ? messageAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(messageAuthorities.length > 2 ? messageAuthorities[2] : null));
//     }
//
//     File integrationAuthorityFilePath =
//         File('${logDirectory.path}/external_service_authority.txt');
//     if (integrationAuthorityFilePath.existsSync()) {
//       String integration =
//           await _getStringFromFilePath(integrationAuthorityFilePath);
//       List<int> integrationAuthorities = _getSplitEachChar(integration);
//       accountModel.authorities.integration = AuthorityModel(
//           canView: _getTrueFalseValue(integrationAuthorities.length > 0 ? integrationAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(integrationAuthorities.length > 1 ? integrationAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(integrationAuthorities.length > 2 ? integrationAuthorities[2] : null));
//     }
//
//     File systemAuthorityFilePath =
//         File('${logDirectory.path}/system_authority.txt');
//     if (systemAuthorityFilePath.existsSync()) {
//       String owner = await systemAuthorityFilePath.readAsString();
//       bool isOwner = _getTrueFalseValue(int.parse(owner));
//       accountModel.isOwner = isOwner;
//     }
//
//     accountModel.authorities = AuthoritiesModel(
//         account: accountModel.authorities.account,
//         accounting: accountModel.authorities.accounting,
//         sales: accountModel.authorities.sales,
//         appointment: accountModel.authorities.appointment,
//         contract: accountModel.authorities.contract,
//         customer: accountModel.authorities.customer,
//         information: accountModel.authorities.information,
//         message: accountModel.authorities.message,
//         technique: accountModel.authorities.technique,
//         product: accountModel.authorities.product,
//         integration: accountModel.authorities.integration,
//         staff: accountModel.authorities.staff);
//
//     AccountModel.mine(
//         authorities: accountModel.authorities, isOwner: accountModel.isOwner);
//   }
//
//   /// Get Plan Type
//   static PlanType? _getPlanType(String plan) {
//     int value = int.parse(plan);
//     final _values = {
//       1: PlanType.lite,
//       2: PlanType.standard,
//       3: PlanType.aesthetic
//     };
//     print('\n\n\n\n\n Plan Type => ${_values[value]}\n\n\n');
//     return _values[value];
//   }
//
//   /// Get true or false.
//   static bool _getTrueFalseValue(int? value) {
//     return (value == 1) ? true : false;
//   }
//
//   /// Get string from file path.
//   static Future<String> _getStringFromFilePath(File filePath) async {
//     return await filePath.readAsString();
//   }
//
//   /// Get list of each char from string.
//   static List<int> _getSplitEachChar(String string) {
//     List<int> chars = [];
//     for (var rune in string.runes) {
//       chars.add(int.parse(String.fromCharCode(rune)));
//     }
//     return chars;
//   }
//
//   /// Delete local storage.
//   static get deleteLocalstorage async {
//     final logDirectory = await getApplicationDocumentsDirectory();
//     String emailPath = '${logDirectory.path}/email.txt';
//     String tokenPath = '${logDirectory.path}/token.txt';
//     String twoStepCertificationFlgPath = '${logDirectory.path}/two_step_certification_flg.txt';
//     String authorityIdPath = '${logDirectory.path}/authority_id.txt';
//     String authorityNamePath = '${logDirectory.path}/authority_name.txt';
//     String accountAuthorityPath = '${logDirectory.path}/account_authority.txt';
//     String customerAuthorityPath = '${logDirectory.path}/customer_authority.txt';
//     String contractAuthorityPath = '${logDirectory.path}/contract_authority.txt';
//     String accountingAuthorityPath = '${logDirectory.path}/accounting_authority.txt';
//     String reservationAuthorityPath = '${logDirectory.path}/reservation_authority.txt';
//     String staffAuthorityPath = '${logDirectory.path}/staff_authority.txt';
//     String techniqueAuthorityPath = '${logDirectory.path}/technique_authority.txt';
//     String productAuthorityPath = '${logDirectory.path}/product_authority.txt';
//     String salesAuthorityPath = '${logDirectory.path}/sales_authority.txt';
//     String informationAuthorityPath = '${logDirectory.path}/information_authority.txt';
//     String messageAuthorityPath = '${logDirectory.path}/message_authority.txt';
//     String externalServiceAuthorityPath = '${logDirectory.path}/external_service_authority.txt';
//     String currentPlanTypePath = '${logDirectory.path}/current_plan_type.txt';
//     String salonIdPath = '${logDirectory.path}/salon_id.txt';
//
//     File emailFilePath = File(emailPath);
//     File tokenFilePath = File(tokenPath);
//     File twoStepCertificationFilePath = File(twoStepCertificationFlgPath);
//     File authorityIdFilePath = File(authorityIdPath);
//     File authorityNameFilePath = File(authorityNamePath);
//     File accountAuthorityFilePath = File(accountAuthorityPath);
//     File customerAuthorityFilePath = File(customerAuthorityPath);
//     File contractAuthorityFilePath = File(contractAuthorityPath);
//     File accountingAuthorityFilePath = File(accountingAuthorityPath);
//     File reservationAuthorityFilePath = File(reservationAuthorityPath);
//     File staffAuthorityFilePath = File(staffAuthorityPath);
//     File techniqueAuthorityFilePath = File(techniqueAuthorityPath);
//     File productAuthorityFilePath = File(productAuthorityPath);
//     File salesAuthorityFilePath = File(salesAuthorityPath);
//     File informationAuthorityFilePath = File(informationAuthorityPath);
//     File messageAuthorityFilePath = File(messageAuthorityPath);
//     File externalServiceAuthorityFilePath = File(externalServiceAuthorityPath);
//     File currentPlanTypeFilePath = File(currentPlanTypePath);
//     File salonIdFilePath = File(salonIdPath);
//
//     List authorityPath = [
//       emailFilePath,
//       tokenFilePath,
//       twoStepCertificationFilePath,
//       authorityIdFilePath,
//       authorityNameFilePath,
//       accountAuthorityFilePath,
//       customerAuthorityFilePath,
//       contractAuthorityFilePath,
//       accountingAuthorityFilePath,
//       reservationAuthorityFilePath,
//       staffAuthorityFilePath,
//       techniqueAuthorityFilePath,
//       productAuthorityFilePath,
//       salesAuthorityFilePath,
//       informationAuthorityFilePath,
//       messageAuthorityFilePath,
//       externalServiceAuthorityFilePath,
//       currentPlanTypeFilePath,
//       salonIdFilePath
//     ];
//
//     for (var i = 0; i < authorityPath.length; i++) {
//       authorityPath[i].deleteSync(recursive: true);
//     }
//   }
// }
