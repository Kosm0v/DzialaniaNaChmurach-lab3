import json
import requests
import os
import boto3


def lambda_handler(event, context):
    dynamodb_client = boto3.client("dynamodb")
    dynamodb_table_name = "ceny"
    response = dynamodb_client.get_item(
        TableName=dynamodb_table_name,
        Key={
            'NazwaProduktu': {
                'S': 'szkolenie',
            }
        },
        AttributesToGet=[
            'Cena',
        ]
    )

    product_price = response.get('Item').get('Cena').get("N")
    prices = {"PLN": product_price, "EUR": product_price*4.58,
              "USD": product_price*4.3, "CHF": product_price*4.4}
    print(prices)
    return prices
