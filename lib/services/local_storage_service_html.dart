// import 'package:syntonic_components/models/account_model.dart';
// import 'package:syntonic_components/models/authorities_model.dart';
// import 'package:syntonic_components/models/authority_model.dart';
// import 'package:syntonic_components/models/customer_authority_model.dart';
// import 'package:syntonic_components/models/sale_authority_model.dart';
// import 'package:syntonic_components/models/salon_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class LocalStorageService {
//   /// Get request token.
//   static Future<String?> getToken() async {
//     FlutterSecureStorage _localStorage = new FlutterSecureStorage();
//     String? _requestToken = await _localStorage.read(key: "request_token");
//
//     return _requestToken;
//   }
//
//   /// Get own authorities.
//   static get myAuthorities async {
//     FlutterSecureStorage _localStorage = new FlutterSecureStorage();
//
//     // Plan Type
//     String? currentPlanType;
//     if (_localStorage.read(key: 'current_plan_type') != null) {
//       currentPlanType = await _localStorage.read(key: 'current_plan_type');
//     }
//     // Salon Id.
//     String? salonId;
//     if (_localStorage.read(key: 'salon_id') != null) {
//       salonId = await _localStorage.read(key: 'salon_id');
//     }
//
//     String? groupId;
//     if (_localStorage.read(key: 'group_id') != null) {
//       groupId = await _localStorage.read(key: 'group_id');
//     }
//
//
//
//     SalonModel.mine(
//         id: BigInt.from(int.parse(salonId!)),
//         groupId: BigInt.from(int.parse(groupId!)),
//         planType: _getPlanType(currentPlanType!));
//
//     AccountModel accountModel = AccountModel.mine();
//
//     if (_localStorage.read(key: 'accountAuthority') != null) {
//       String? account = await _localStorage.read(key: 'accountAuthority');
//       List<int> accountAuthorities = _getSplitEachChar(account!);
//       accountModel.authorities.account = AuthorityModel(
//           canView: _getTrueFalseValue(
//               accountAuthorities.length > 0 ? accountAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               accountAuthorities.length > 1 ? accountAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               accountAuthorities.length > 2 ? accountAuthorities[2] : null));
//     }
//
//     if (_localStorage.read(key: 'customerAuthority') != null) {
//       String? customer = await _localStorage.read(key: 'customerAuthority');
//       List<int> customerAuthorities = _getSplitEachChar(customer!);
//       accountModel.authorities.customer = CustomerAuthorityModel(
//           canView: _getTrueFalseValue(
//               customerAuthorities.length > 0 ? customerAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               customerAuthorities.length > 1 ? customerAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               customerAuthorities.length > 2 ? customerAuthorities[2] : null),
//           canViewPrivacy: _getTrueFalseValue(
//               customerAuthorities.length > 3 ? customerAuthorities[3] : null));
//     }
//
//     if (_localStorage.read(key: 'contractAuthority') != null) {
//       String? contract = await _localStorage.read(key: 'contractAuthority');
//       List<int> contractAuthorities = _getSplitEachChar(contract!);
//       accountModel.authorities.contract = AuthorityModel(
//           canView: _getTrueFalseValue(
//               contractAuthorities.length > 0 ? contractAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               contractAuthorities.length > 1 ? contractAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               contractAuthorities.length > 2 ? contractAuthorities[2] : null));
//     }
//
//     if (_localStorage.read(key: 'accountingAuthority') != null) {
//       String? accounting = await _localStorage.read(key: 'accountingAuthority');
//       List<int> accountingAuthorities = _getSplitEachChar(accounting!);
//       accountModel.authorities.accounting = AuthorityModel(
//           canView: _getTrueFalseValue(accountingAuthorities.length > 0
//               ? accountingAuthorities[0]
//               : null),
//           canEdit: _getTrueFalseValue(accountingAuthorities.length > 1
//               ? accountingAuthorities[1]
//               : null),
//           canDelete: _getTrueFalseValue(accountingAuthorities.length > 2
//               ? accountingAuthorities[2]
//               : null));
//     }
//
//     if (_localStorage.read(key: 'reservationAuthority') != null) {
//       String? reservation =
//           await _localStorage.read(key: 'reservationAuthority');
//       List<int> reservationAuthorities = _getSplitEachChar(reservation!);
//       accountModel.authorities.appointment = AuthorityModel(
//           canView: _getTrueFalseValue(reservationAuthorities.length > 0
//               ? reservationAuthorities[0]
//               : null),
//           canEdit: _getTrueFalseValue(reservationAuthorities.length > 1
//               ? reservationAuthorities[1]
//               : null),
//           canDelete: _getTrueFalseValue(reservationAuthorities.length > 2
//               ? reservationAuthorities[2]
//               : null));
//     }
//
//     if (_localStorage.read(key: 'staffAuthority') != null) {
//       String? staff = await _localStorage.read(key: 'staffAuthority');
//       List<int> staffAuthorities = _getSplitEachChar(staff!);
//       accountModel.authorities.staff = AuthorityModel(
//           canView: _getTrueFalseValue(
//               staffAuthorities.length > 0 ? staffAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               staffAuthorities.length > 1 ? staffAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               staffAuthorities.length > 2 ? staffAuthorities[2] : null));
//     }
//
//     if (_localStorage.read(key: 'techniqueAuthority') != null) {
//       String? tech = await _localStorage.read(key: 'techniqueAuthority');
//       List<int> techniqueAuthorities = _getSplitEachChar(tech!);
//       accountModel.authorities.technique = AuthorityModel(
//           canView: _getTrueFalseValue(
//               techniqueAuthorities.length > 0 ? techniqueAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               techniqueAuthorities.length > 1 ? techniqueAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(techniqueAuthorities.length > 2
//               ? techniqueAuthorities[2]
//               : null));
//     }
//
//     if (_localStorage.read(key: 'productAuthority') != null) {
//       String? product = await _localStorage.read(key: 'productAuthority');
//       List<int> productAuthorities = _getSplitEachChar(product!);
//       accountModel.authorities.product = AuthorityModel(
//           canView: _getTrueFalseValue(
//               productAuthorities.length > 0 ? productAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               productAuthorities.length > 1 ? productAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               productAuthorities.length > 2 ? productAuthorities[2] : null));
//     }
//
//     if (_localStorage.read(key: 'salesAuthority') != null) {
//       String? sales = await _localStorage.read(key: 'salesAuthority');
//       List<int> salesAuthorities = _getSplitEachChar(sales!);
//       accountModel.authorities.sales = SaleAuthorityModel(
//           canView: _getTrueFalseValue(
//               salesAuthorities.length > 0 ? salesAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               salesAuthorities.length > 1 ? salesAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               salesAuthorities.length > 2 ? salesAuthorities[2] : null),
//           canViewGroupSalon: _getTrueFalseValue(
//               salesAuthorities.length > 3 ? salesAuthorities[3] : null));
//     }
//
//     if (_localStorage.read(key: 'informationAuthority') != null) {
//       String? information =
//           await _localStorage.read(key: 'informationAuthority');
//       List<int> informationAuthorities = _getSplitEachChar(information!);
//       accountModel.authorities.information = AuthorityModel(
//           canView: _getTrueFalseValue(informationAuthorities.length > 0
//               ? informationAuthorities[0]
//               : null),
//           canEdit: _getTrueFalseValue(informationAuthorities.length > 1
//               ? informationAuthorities[1]
//               : null),
//           canDelete: _getTrueFalseValue(informationAuthorities.length > 2
//               ? informationAuthorities[2]
//               : null));
//     }
//
//     if (_localStorage.read(key: 'messageAuthority') != null) {
//       String? message = await _localStorage.read(key: 'messageAuthority');
//       List<int> messageAuthorities = _getSplitEachChar(message!);
//       accountModel.authorities.message = AuthorityModel(
//           canView: _getTrueFalseValue(
//               messageAuthorities.length > 0 ? messageAuthorities[0] : null),
//           canEdit: _getTrueFalseValue(
//               messageAuthorities.length > 1 ? messageAuthorities[1] : null),
//           canDelete: _getTrueFalseValue(
//               messageAuthorities.length > 2 ? messageAuthorities[2] : null));
//     }
//
//     if (_localStorage.read(key: 'externalServiceAuthority') != null) {
//       String? integration =
//           await _localStorage.read(key: 'externalServiceAuthority');
//       List<int> integrationAuthorities = _getSplitEachChar(integration!);
//       accountModel.authorities.integration = AuthorityModel(
//           canView: _getTrueFalseValue(integrationAuthorities.length > 0
//               ? integrationAuthorities[0]
//               : null),
//           canEdit: _getTrueFalseValue(integrationAuthorities.length > 1
//               ? integrationAuthorities[1]
//               : null),
//           canDelete: _getTrueFalseValue(integrationAuthorities.length > 2
//               ? integrationAuthorities[2]
//               : null));
//     }
//     // save state not found
//     // if (_localStorage.read(key: 'systemAuthority') != null) {
//     //   String? owner = await _localStorage.read(key: 'systemAuthority');
//     //   bool isOwner = _getTrueFalseValue(int.parse(owner!));
//     //   accountModel.isOwner = isOwner;
//     // }
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
//
//     return _values[value];
//   }
//
//   /// Get true or false.
//   static bool _getTrueFalseValue(int? value) {
//     return (value == 1) ? true : false;
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
//   /// deleteLocalstorage
//   static get deleteLocalstorage async {
//     FlutterSecureStorage _localStorage = new FlutterSecureStorage();
//     await _localStorage.deleteAll();
//   }
// }
