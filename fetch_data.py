import os
import json
import requests
import boto3



#Instantiate vars
#Environment variables used for portability
file_name = os.environ.get('FILE_NAME', 'spacex_data.json')
bucket_name = os.environ.get('BUCKET_NAME', '')
path_name = os.environ.get('PATH_NAME', 'space-fetch')
object_name = os.environ.get('OBJECT_NAME', 'spacex_data.json')
#Place in tmp because Lambdas are read-only
temp_file = os.path.join("/tmp", file_name)

def fetch_json_data(url):
    try:
        json_response = requests.get(url, timeout=10)
    except requests.exceptions.Timeout:
        print("Request timed out")
    json_response.raise_for_status()
    return json_response.json()

def output_to_json(spacex_data, temp_file):
    with open(temp_file, 'w') as file:
        json.dump(spacex_data, file)

def upload_file_to_s3(temp_file, bucket_name, path_name, object_name=None):
    """
    Upload a file to an S3 bucket
    Use environment variables to config
    """

    #Strip leading and trailing slashes when concatenating
    full_object_name = f"{path_name.rstrip('/')}/{object_name}".lstrip('/')
    s3_client = boto3.client('s3')

    try:
        s3_response = s3_client.upload_file(temp_file, bucket_name, full_object_name)
    except boto3.exceptions.S3UploadFailedError as e:
        print(f"Upload failed: {e}")
        return False
    return True


def combine_data():
    """
    Merge into one JSON. 
    Both are separate in rockets and payloads.
    """
    rockets_url = 'https://api.spacexdata.com/v3/rockets'
    payloads_url = 'https://api.spacexdata.com/v3/payloads'

    rockets_data = fetch_json_data(rockets_url)
    payloads_data = fetch_json_data(payloads_url)
    parsed_rockets_data = [{
        "rocket_name": rocket["rocket_name"],
        "country": rocket["country"]
    } for rocket in rockets_data]


    parsed_payloads_data = [{
        "payload_type": payload["payload_type"],
        "payload_id": payload["payload_id"]
    } for payload in payloads_data]

    combined_data = {
        "rockets": parsed_rockets_data,
        "payloads": parsed_payloads_data
    }

    return combined_data


def lambda_handler(event, context):

    combined_data = combine_data()

    output_to_json(combined_data, temp_file)

    upload_success = upload_file_to_s3(temp_file, bucket_name, path_name, object_name)

    if upload_success:
        print("Upload successful.")
    else:
        print("Upload failed.")

    return {
        'statusCode': 200,
        'body': json.dumps('Execution completed.')
    }

if __name__ == "__main__":
    mock_event = {}
    mock_context = None

    response = lambda_handler(mock_event, mock_context)
