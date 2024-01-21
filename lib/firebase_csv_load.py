import json
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate('/lib/indecisionmate-24594-firebase-adminsdk-jrfa7-6df310a140.json')
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

# Path to your JSON file
json_file_path = '/output_suggestions.json'

# Read JSON file
with open(json_file_path, 'r') as file:
    data = json.load(file)

# Add data to Firestore
collection_name = 'Suggestion'

for activity in data:
    db.collection(collection_name).add(activity)

print('Data has been uploaded to Firestore.')
