
import requests

headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer fhfV4ebHDZPVhQElGOOPNsbaOsjp'
}

payload = {
    "BusinessShortCode": 174379,
    "Password": "MTc0Mzc5YmZiMjc5ZjlhYTliZGJjZjE1OGU5N2RkNzFhNDY3Y2QyZTBjODkzMDU5YjEwZjc4ZTZiNzJhZGExZWQyYzkxOTIwMjMxMTMwMDIwMjUw",
    "Timestamp": "20231130020250",
    "TransactionType": "CustomerPayBillOnline",
    "Amount": 1,
    "PartyA": 254796814233,
    "PartyB": 174379,
    "PhoneNumber": 254796814233,
    "CallBackURL": "https://mydomain.com/path",
    "AccountReference": "CompanyXLTD",
    "TransactionDesc": "Payment of X" 
  }

response = requests.request("POST", 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest', headers = headers, data = payload)
print(response.text.encode('utf8'))
