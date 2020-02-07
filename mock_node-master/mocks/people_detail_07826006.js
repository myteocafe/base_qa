mockServer = require('mockserver-client');
mockServerClient = mockServer.mockServerClient;

var PORT = 8080, HOST = "mockserver";
var BASE_API = "/api/teocafe/people";
var ENDPOINT = "/07826006";

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
                        "firstName": "Zulema",
                        "lastName": "Santacruz Calle",
                        "documentNumber": "07826006",
                        "address": "65 Tuet Nok Tsap Path Tsin Sam Hong Kong",
                        "phoneNumber": "966965789",
                        "company": "Leffler Ltd",
                        "debt": 5000.45
                    }
                },
                "errors": []
            })
        },
        'times': {
            'unlimited': true
        }}
);
