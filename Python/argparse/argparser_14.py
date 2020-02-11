# Notice that so far we’ve been using verbosity level to change the text
# that gets displayed. The following example instead uses verbosity level
# to display more text instead:

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("x", type=int, help="the base")
parser.add_argument("y", type=int, help="the exponent")
parser.add_argument("-v", "--verbosity", action="count", default=0)
args = parser.parse_args()
answer = args.x**args.y
if args.verbosity >= 2:
    print("Running '{}'".format(__file__))
if args.verbosity >= 1:
    print("{}^{} == ".format(args.x, args.y), end="")
    #print("Hi")
print(answer)

# Run arguments suggested: 4 2; 4 2 -v; 4 2 -vv; 4 2 -vvv.
