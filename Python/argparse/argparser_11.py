# Run arguments suggested: 5 [ERROR BUG]; 5 -v 2 [ERROR]; --verbosity 5 --verbosity.
# order does not matter

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("square", type=int,
                    help="display a square of a given number")
parser.add_argument("-v", "--verbosity", action="count",
                    help="increase output verbosity")
args = parser.parse_args()
answer = args.square**2

# bugfix: replace == with >=
if args.verbosity >= 2:
    print("the square of {} equals {}".format(args.square, answer))
elif args.verbosity >= 1:
    print("{}^2 == {}".format(args.square, answer))
else:
    print(answer)

# BUG > The None value cannot be compared to an int value
#       (hence the TypeError exception). Set default=0 in line 8.
