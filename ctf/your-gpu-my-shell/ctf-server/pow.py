#!/usr/bin/python3 -u
# encoding: utf-8

import random, string, sys, os
from hashlib import sha256
from itertools import product

os.chdir(os.path.dirname(os.path.realpath(__file__)))

def solve_pow(suffix, digest):
    chars = string.ascii_letters + string.digits
    for p in product(chars, repeat=4):
        prefix = "".join(p)
        if sha256((prefix + suffix).encode("utf8")).hexdigest() == digest:
            return prefix            
    return None

def proof_of_work():
    proof = "".join([random.choice(string.ascii_letters+string.digits) for i in range(20)])
    digest = sha256(proof.encode("utf8")).hexdigest()
    print("sha256(xxxx+%s) == %s"%(proof[4:],digest))
    print("Give me xxxx:")
    
    x = sys.stdin.read(4)
    if len(x) != 4 or x != proof[:4]:
        return False
    return True

if __name__ == '__main__':
    print(solve_pow(sys.argv[1], sys.argv[2]))
