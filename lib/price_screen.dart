import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import 'coin_data.dart';
import 'network.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  bool _isVisible = true;
  String selectedItem = currenciesList[0];
  String curency;
  String valuerate;
  void marchData() async {
    print('--------//////////////////////////////////////////////----');
    var jsonData = await getNetwork(selectedItem);
    setState(() {
      String coin = jsonData['asset_id_base'];
      curency = jsonData['asset_id_quote'];
      double valuer = jsonData['rate'];
      valuerate = valuer.toStringAsFixed(2);
      _isVisible = false;
      print(
          '////////////////////////////////////////////// $curency,$valuerate');
    });
  }

  DropdownButton<String> getDropDownListAndroid() {
    List<DropdownMenuItem<String>> liiu = [];

    for (int i = 0; i < currenciesList.length; i++) {
      DropdownMenuItem<String> dropDownItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );

      liiu.add(dropDownItem);
    }

    return DropdownButton<String>(
        menuMaxHeight: 80.0,
        value: selectedItem,
        icon: Icon(
          Icons.arrow_drop_down_circle_sharp,
        ),
        items: liiu,
        onChanged: (value) {
          setState(() {
            selectedItem = value;
            marchData();
            _isVisible = true;
            // curency = value;
          });
        });
  }

  CupertinoPicker getDropDownListIos() {
    List<Text> allText = [];
    for (String newValue in currenciesList) {
      Text eachText = Text(newValue);
      allText.add(eachText);
    }
    allText;
    return CupertinoPicker(
      onSelectedItemChanged: (int value) {
        print(value);
      },
      itemExtent: 30,
      children: allText,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    marchData();
    super.initState();
    // print(getNetwork(selectedItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 22.0),
                    child: Text(
                      '1 BTC = ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isVisible,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Visibility(
                      visible: !_isVisible,
                      child: Text(
                        ' $valuerate $curency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Lottie.asset(
            'asset/3097-network-error.json',
            animate: false,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue.shade300,
            child: Platform.isIOS
                ? getDropDownListIos()
                : getDropDownListAndroid(),
          ),
        ],
      ),
    );
  }
}
