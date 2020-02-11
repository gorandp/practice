import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--verbose", help="increase output verbosity",
                    action="store_true")
args = parser.parse_args()
if args.verbose:
    print("verbosity turned on")

"""
> The option is now more of a flag than something that requires a value.
We even changed the name of the option to match that idea. Note that we
now specify a new keyword, action, and give it the value "store_true".
This means that, if the option is specified, assign the value True to
args.verbose. Not specifying it implies False.

> It complains when you specify a value, in true spirit of what flags
actually are.

> Notice the different help text.
"""
