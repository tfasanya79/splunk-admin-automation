
from utils.splunk_client import SplunkClient

def get_indexer_health(env):
    client = SplunkClient(env)
    endpoint = "/services/server/info"
    resp = client.get(endpoint)
    if resp.status_code == 200:
        print("✅ Indexer health info retrieved")
        print(resp.text)
    else:
        print("❌ Failed to fetch indexer health info")
