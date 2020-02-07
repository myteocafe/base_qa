mockServer = require('mockserver-client');
mockServerClient = mockServer.mockServerClient;

var PORT = 8080, HOST = "mockserver";
var BASE_API = "/api/teocafe/people";
var ENDPOINT = "/10209964";

mockServerClient(HOST, PORT).mockAnyResponse(
    {
        'httpRequest': {
            'method': 'GET',
            'path': BASE_API + ENDPOINT,
        },
        'httpResponse': {
            'statusCode': 200,
            'headers': [
                {"name": "Content-Type","values": ["application/json; charset=utf-8"]},
                {"name": "Access-Control-Allow-Headers","values": ["Content-Type"]},
                {"name": "Access-Control-Allow-Origin","values": ["*"]},
                {"name": "Access-Control-Allow-Methods","values": ["POST, GET, OPTIONS, DELETE"]}
            ],
            'body': JSON.stringify({
                "success": true,
                "response": {
                    "Information": {
                        "firstName": "Misael",
                        "lastName": "Castillo Chumpitaz",
                        "documentNumber": "10209964",
                        "address": "28729 Diana Views Suite 546 New Aurore, KS 66506-1791",
                        "phoneNumber": "970000001",
                        "company": "Nicolas, Runte and Quigley",
                        "debt": 100000.21
                    }
                },
                "errors": []
            })
        },
        'times': {
            'unlimited': true
        }}
);
