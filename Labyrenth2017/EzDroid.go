package main

import (
	"fmt"
	"math/big"
)

func bigInt(n uint64) *big.Int { return new(big.Int).SetUint64(n) }

func main() {
	// x * -37 == 17206538649
	// trying to solve for x here
	// let's express that as: x * b == a

	big1 := bigInt(1)
	a := uint64(17206538649) // 91 - 42 = 49
	b := int64(-37)
	bb := uint64(b) // re-interpret b as an unsigned 64-bit number

	// modulus is 64 because Longs are 64-bits
	N := new(big.Int).Lsh(big1, 64) // modulus is 1 << 64
	Nmask := new(big.Int).Sub(N, big1) // mask is 0xFFF... (64 bits)

	// calculate multiplicative inverse of b using extended Euclidean algo
	// see https://math.stackexchange.com/questions/1583264/multiplicative-inverse-of-47-mod-64
	invB := new(big.Int)
	gcd := new(big.Int).GCD(invB, nil, bigInt(bb), N)
	if gcd.Cmp(big1) != 0 {
		panic("GCD != 1")
	}

	// now to divide a by b
	// we simply rewrite it to be inv(b) * a
	x := new(big.Int).Mul(invB, bigInt(a))

	// truncate to 64-bits
	x.And(x, Nmask)

	fmt.Printf("ans = %d signed %d", x, int64(x.Uint64()))
}
