mockServer = require('mockserver-client');
mockServerClient = mockServer.mockServerClient;

var PORT = 8080, HOST = "mockserver";
var BASE_API = "/api/teocafe";
var ENDPOINT = "/people";

mockServerClient(HOST, PORT).mockAnyResponse(
    {
        'httpRequest': {
            'method': 'GET',
            'path': BASE_API + ENDPOINT,
        },
        'httpResponse': {
            'statusCode': 200,
            'headers': [
                {"name": "Content-Type", "values": ["application/json; charset=utf-8"]},
                {"name": "Access-Control-Allow-Headers", "values": ["Content-Type"]},
                {"name": "Access-Control-Allow-Origin", "values": ["*"]},
                {"name": "Access-Control-Allow-Methods", "values": ["POST, GET, OPTIONS, DELETE"]}
            ],
            'body': JSON.stringify({
                "success": true,
                "response": {
                    "employees": [
                        {
                            "firstName": "Kei",
                            "lastName": "Takayama",
                            "documentNumber": "07826015"
                        },
                        {
                            "firstName": "Zulema",
                            "lastName": "SantaCruz",
                            "documentNumber": "07826006"
                        },
                        {
                            "firstName": "Misael",
                            "lastName": "Castillo",
                            "documentNumber": "10209964"
                        }
                    ],
                    "city": "Castle Rock",
                    "state": "Maine"
                },
                "errors": []
            })
        },
        'times': {
            'unlimited': true
        }
    }
);
