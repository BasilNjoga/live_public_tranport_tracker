import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools;


const _base = "sandbox.safaricom.co.ke";
const _tokenEndpoint = "mpesa/stkpush/v1/processrequest";

var darajaEndpoint = Uri(
    scheme: 'https',
    host: _base,
    path: _tokenEndpoint,
    );

void getPayment() async {
  devtools.log("Just called this function");
  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer slTLGWwkOCNl3M7ATFWWFAaG0bry'
  };

  var payload = {
    "BusinessShortCode": 174379,
    "Password":
        "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjMxMTMwMTUxMzM2",
    "Timestamp": "20231130151336",
    "TransactionType": "CustomerPayBillOnline",
    "Amount": 1,
    "PartyA": 254796814233,
    "PartyB": 174379,
    "PhoneNumber": 254796814233,
    "CallBackURL": "https://mydomain.com/path",
    "AccountReference": "CompanyXLTD",
    "TransactionDesc": "Payment of X"
  };

  var response = await http.post(
      darajaEndpoint,
      headers: headers,
      body: jsonEncode(payload));
  devtools.log(response.toString());
}
