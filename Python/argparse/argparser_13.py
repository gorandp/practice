# Run arguments suggested: [ERROR]; -h; 4 2 -v; 4 3 -vv; 4 [ERROR]; 4 -v [ERROR];.
# order DOES matter to the positional arguments (x,y)
# on the other hand order does NOT matter to optional args (-v,-h)

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("x", type=int, help="the base")
parser.add_argument("y", type=int, help="the exponent")
parser.add_argument("-v", "--verbosity", action="count", default=0)
args = parser.parse_args()
answer = args.x**args.y
if args.verbosity >= 2:
    print("{} to the power {} equals {}".format(args.x, args.y, answer))
elif args.verbosity >= 1:
    print("{}^{} == {}".format(args.x, args.y, answer))
else:
    print(answer)
