import json
import os
import boto3


def lambda_handler(event, context):

    dynamodb_client = boto3.resource("dynamodb")  # initialize dynamodb client
    # declare dynamodb database name
    dynamodb_table_name = os.getenv("DYNAMODB_TABLE_NAME")
    table = dynamodb_client.Table(dynamodb_table_name)
    # # get price for item "szkolenia"
    response = table.get_item(
        TableName=dynamodb_table_name,
        Key={
            'Usluga': "Szkolenie"
        }
    )

    product_prices = response['Item']["Ceny"]

    results = {}
    try:
        query = event["queryStringParameters"]["currency"].upper()
        currencies = query.split(",")
        print(currencies)
        for currency in currencies:
            print(currency)
            print(product_prices[currency])
            results[currency] = product_prices[currency]

    except:
        results = product_prices
    return results
