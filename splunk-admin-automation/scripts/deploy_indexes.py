
import argparse
from modules import index_management

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", required=True)
    parser.add_argument("--index_name", required=True)
    parser.add_argument("--retention", default="90d")
    args = parser.parse_args()

    index_params = {
        "frozenTimePeriodInSecs": str(int(args.retention.rstrip("d")) * 86400)
    }

    index_management.create_index(args.env, args.index_name, index_params)
