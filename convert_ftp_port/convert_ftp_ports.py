#!/usr/bin/python3
import argparse
import sys
parser = argparse.ArgumentParser()
parser.add_argument('-1', dest='one', nargs=1)
parser.add_argument('-2', dest='two', nargs=1)
try:
    args = parser.parse_args()
except:
    print("error on argparse")
    sys.exit()

high_dec = int(args.one[0])
low_dec = int(args.two[0])
high_x = hex(high_dec)
low_x = hex(low_dec)
port = int(high_x, base=16)*256 | int(low_x, base=16)

print(high_dec, low_dec, '=> hex', high_x, low_x, "=> port", port)
