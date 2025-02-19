# lambda_function.py
import json

def lambda_handler(event, context):
    # Simulate fetching or processing preprocessed data
    data = {
        "timestamp": "2025-02-19T12:00:00Z",
        "value": 42,
        "message": "Dynamic data updated!"
    }
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"  # Enable CORS
        },
        "body": json.dumps(data)
    }
