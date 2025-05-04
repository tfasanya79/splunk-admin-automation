
import requests
from utils.splunk_client import SplunkClient

def create_index(env, index_name, params):
    client = SplunkClient(env)
    endpoint = "/services/data/indexes"
    data = {"name": index_name, **params}
    resp = client.post(endpoint, data)
    if resp.status_code == 201:
        print(f"✅ Index '{index_name}' created in {env}")
    else:
        print(f"❌ Failed to create index: {resp.text}")
