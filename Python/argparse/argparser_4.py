import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--verbosity", help="increase output verbosity", type=float)
args = parser.parse_args()
if args.verbosity:
    print("verbosity turned on")
    print(args.verbosity)
