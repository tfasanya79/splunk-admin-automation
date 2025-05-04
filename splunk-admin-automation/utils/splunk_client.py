
import requests
import yaml

class SplunkClient:
    def __init__(self, env):
        config = yaml.safe_load(open("config/splunk_instances.yaml"))
        self.host = config[env]["host"]
        self.auth = (config[env]["username"], config[env]["password"])
        self.headers = {"Content-Type": "application/x-www-form-urlencoded"}

    def get(self, path):
        return requests.get(f"{self.host}{path}", auth=self.auth, headers=self.headers, verify=False)

    def post(self, path, data):
        return requests.post(f"{self.host}{path}", data=data, auth=self.auth, headers=self.headers, verify=False)
