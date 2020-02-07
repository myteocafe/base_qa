mockServer = require('mockserver-client');
mockServerClient = mockServer.mockServerClient;

var PORT = 8080, HOST = "mockserver";
var BASE_API = "/api/teocafe/people";
var ENDPOINT = "/07826015";

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
                        "firstName": "Kei",
                        "lastName": "Takayama Higuchi",
                        "documentNumber": "07826015",
                        "address": "688 King Trail Suite 663 Jacobschester, HI 25446",
                        "phoneNumber": "970000001",
                        "company": "Reichert Ltd",
                        "debt": 3500.22
                    }
                },
                "errors": []
            })
        },
        'times': {
            'unlimited': true
        }}
);
