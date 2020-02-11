# Run arguments suggested: 5; 5 -vv; 5 -v 2 [ERROR]; 5 -vvv [BUG]; 5 --verbosity --verbosity.
# order does not matter

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("square", type=int,
                    help="display the square of a given number")
parser.add_argument("-v", "--verbosity", action="count",
                    help="increase output verbosity")
args = parser.parse_args()
answer = args.square**2
if args.verbosity == 2:
    print("the square of {} equals {}".format(args.square, answer))
elif args.verbosity == 1:
    print("{}^2 == {}".format(args.square, answer))
else:
    print(answer)

# BUG > It doesn't verbose more or the max with values greater than 2
