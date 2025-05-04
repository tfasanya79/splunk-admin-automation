
import argparse
from modules.scheduler import start_scheduler

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--env", required=True)
    args = parser.parse_args()

    start_scheduler(args.env)
