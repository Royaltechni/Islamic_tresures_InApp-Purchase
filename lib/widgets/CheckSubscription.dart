import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidsapp/providers/lanprovider.dart';
import 'package:kidsapp/screens/inAppPurchese.dart';
import 'package:kidsapp/screens/login.dart';
import 'package:provider/provider.dart';

class CheckSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Text(
            'You need to Subscribe',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: 200,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                onPressed: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => inAppPurchese()));
                },
                child: Text(
                  Provider.of<Lanprovider>(context, listen: true).isenglish
                      ? 'Subscribe Now'
                      : ' إشترك الأن',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 200,
            height: 40,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.transparent)),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  Provider.of<Lanprovider>(context, listen: true).isenglish
                      ? 'not now '
                      : ' ليس الأن',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
          )
        ],
      ),
    );
  }
}
