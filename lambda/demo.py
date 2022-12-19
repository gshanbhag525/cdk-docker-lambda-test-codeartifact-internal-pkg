import internalparser

def handler(event, context):
    print("hello")
    return {
        "statusCode": 200,
        "body": "invoked"
    }