import json
from requests import request
import os
import boto3


def lambda_handler(event, context):

    dynamodb_client = boto3.client("dynamodb")  # initialize dynamodb client
    # declare dynamodb database name - to do pass via env variables
    dynamodb_table_name = os.getenv("DYNAMODB_TABLE_NAME")
    # get price for item "szkolenia"
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
    # get value from dictionary
    product_price = response.get('Item').get(
        'Cena').get("N")

    # API REQUEST
    base_symbol = "PLN"  # base currency
    to_symbols = "EUR,USD,CHF"  # to which currencies we want to convert our price

    url = f"https://api.apilayer.com/exchangerates_data/latest?symbols={to_symbols}&base={base_symbol}"
    headers = {
        "apikey": os.getenv("API_KEY")
    }
    response = requests.request("GET", url, headers=headers)
    result = response.text
    result_json = json.loads(result)
    rates = result_json.get("rates")

    # prepare dictionary that will contain prices in all currencies
    prices = {"PLN": product_price}

    for key, value in rates.items():
        updated_price = product_price*value
        prices[key] = round(updated_price, 2)

    print(prices)
    return prices
