import json
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate('indecisionmate-24594-firebase-adminsdk-jrfa7-6df310a140.json')
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

# Path to your JSON file
json_file_path = 'output_suggestions.json'

# Read JSON file
with open(json_file_path, 'r') as file:
    data = json.load(file)

# Add data to Firestore
collection_name = 'Suggestions'

# Function to split fields by comma and return as a list
def process_fields(item, fields_to_process):
    for field in fields_to_process:
        if field in item and isinstance(item[field], str):
            item[field] = item[field].split(', ')
    return item

# Fields to process as arrays
fields_to_process = ['Mood', 'Interest', 'Budget', 'InOut', 'People']

# Process data before uploading
processed_data = [process_fields(activity, fields_to_process) for activity in data]

# Upload processed data to Firestore
for activity in processed_data:
    db.collection(collection_name).add(activity)

print('Data has been uploaded to Firestore.')
