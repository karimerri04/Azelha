import 'package:azelha/contsants/shared_prefs_helper.dart';
import 'package:azelha/data/bloc/eco_card_bloc.dart';
import 'package:azelha/data/bloc/user_bloc.dart';
import 'package:azelha/data/model/eco_card_model.dart';
import 'package:azelha/data/model/user_model.dart';
import 'package:azelha/widgets/button_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EcoCardScreen extends StatefulWidget {
  @override
  _EcoCardScreenState createState() => _EcoCardScreenState();
}

class _EcoCardScreenState extends State<EcoCardScreen> {
  final _creditCardBloc = new EcoCardBloc();
  var uuid = new Uuid();
  String _cardNumber = '';
  String _expiryDate = '';
  String _cardHolderName = '';
  String _cvvCode = '';
  bool _isCvvFocused = false;
  String _ccType = '';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _userBloc = new UserBloc();
  User _user;
  String email = '';

  @override
  void initState() {
    super.initState();

    getPref().then((data) {
      setState(() {
        this.email = data;
        retrieveUserFromBackend().then((data) {
          setState(() {
            this._user = data;
          });
        });
      });
    });
  }

  Future getPref() async {
    email = prefsHelper.email;
    return email;
  }

  Future retrieveUserFromBackend() async {
    await _userBloc.initUserData(email);
    User user = await _userBloc.userController.first;
    return user;
  }

  void saveCardOrderItem(EcoCard cardItem) async {
    await _creditCardBloc.addCreditCardOrder(cardItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Credit card'),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        CreditCardWidget(
                          cardNumber: _cardNumber,
                          expiryDate: _expiryDate,
                          cardHolderName: _cardHolderName,
                          cvvCode: _cvvCode,
                          showBackView: _isCvvFocused,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: CreditCardForm(
                              onCreditCardModelChange: onCreditCardModelChange,
                              formKey: null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ButtonSecondary(
                  onPressed: () {
                    saveCardOrderItem(new EcoCard(
                        user: _user.toMap(),
                        ecoCardNum: _cardNumber,
                        expDate: _expiryDate,
                        cardHolderName: _cardHolderName,
                        cvv: _cvvCode,
                        isActive: true,
                        ecoCardType: _ccType));
                    Navigator.pop(context);
                  },
                  text: 'CONFIRM',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        icon = Image.asset(
          'icons/visa.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        _ccType = 'visa';
        break;

      case CardType.americanExpress:
        icon = Image.asset(
          'icons/amex.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        _ccType = 'americanExpress';
        break;

      case CardType.mastercard:
        icon = Image.asset(
          'icons/mastercard.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        _ccType = 'americanExpress';
        break;

      case CardType.discover:
        icon = Image.asset(
          'icons/discover.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        _ccType = 'discover';
        break;

      default:
        icon = Container(
          height: 48,
          width: 48,
        );
        _ccType = 'otherBrand';
        break;
    }

    return icon;
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      _cardNumber = creditCardModel.cardNumber;
      _expiryDate = creditCardModel.expiryDate;
      _cardHolderName = creditCardModel.cardHolderName;
      _cvvCode = creditCardModel.cvvCode;
      _isCvvFocused = creditCardModel.isCvvFocused;
      getCardTypeIcon(_cardNumber);
    });
  }
}

/// Credit Card prefix patterns as of March 2019
/// A [List<String>] represents a range.
/// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
Map<CardType, Set<List<String>>> cardNumPatterns =
    <CardType, Set<List<String>>>{
  CardType.visa: <List<String>>{
    <String>['4'],
  },
  CardType.americanExpress: <List<String>>{
    <String>['34'],
    <String>['37'],
  },
  CardType.discover: <List<String>>{
    <String>['6011'],
    <String>['622126', '622925'],
    <String>['644', '649'],
    <String>['65']
  },
  CardType.mastercard: <List<String>>{
    <String>['51', '55'],
    <String>['2221', '2229'],
    <String>['223', '229'],
    <String>['23', '26'],
    <String>['270', '271'],
    <String>['2720'],
  },
};

/// This function determines the Credit Card type based on the cardPatterns
/// and returns it.
CardType detectCCType(String cardNumber) {
  //Default card type is other
  CardType cardType = CardType.otherBrand;

  if (cardNumber.isEmpty) {
    return cardType;
  }

  cardNumPatterns.forEach(
    (CardType type, Set<List<String>> patterns) {
      for (List<String> patternRange in patterns) {
        // Remove any spaces
        String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        final int rangeLen = patternRange[0].length;
        // Trim the Credit Card number string to match the pattern prefix length
        if (rangeLen < cardNumber.length) {
          ccPatternStr = ccPatternStr.substring(0, rangeLen);
        }

        if (patternRange.length > 1) {
          // Convert the prefix range into numbers then make sure the
          // Credit Card num is in the pattern range.
          // Because Strings don't have '>=' type operators
          final int ccPrefixAsInt = int.parse(ccPatternStr);
          final int startPatternPrefixAsInt = int.parse(patternRange[0]);
          final int endPatternPrefixAsInt = int.parse(patternRange[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt &&
              ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            cardType = type;
            break;
          }
        } else {
          // Just compare the single pattern prefix with the Credit Card prefix
          if (ccPatternStr == patternRange[0]) {
            // Found a match
            cardType = type;
            break;
          }
        }
      }
    },
  );

  return cardType;
}
