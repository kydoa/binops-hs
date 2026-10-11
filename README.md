# binops-hs

[![Language](https://img.shields.io/badge/Language-Haskell-5e5086)](t1.hs)
[![Status](https://img.shields.io/badge/Status-Prototype-orange)]()

A small Haskell program with recursive functions that manipulate binary values represented as lists of booleans.

## Table of Contents

- [What This Project Does](#what-this-project-does)
- [Why This Project Is Useful](#why-this-project-is-useful)
- [Getting Started](#getting-started)
- [Usage Examples](#usage-examples)
- [Project Structure](#project-structure)
- [Where To Get Help](#where-to-get-help)
- [Maintainers and Contributions](#maintainers-and-contributions)

## What This Project Does

`binops-hs` is a small Haskell module that allows you to:

- Convert unsigned binary numbers to decimal (`bin2dec`) and back (`dec2bin`).
- Convert two's complement binary numbers to decimal (`bincompl2dec`) and back (`dec2bincompl`).
- Add two two's complement numbers with a fixed bit width, reporting overflow (`somarBin`).

A binary number is a list of `Bool`, where `True` is bit `1` and `False` is bit `0`, most significant bit first. For example, `[True, False, True]` represents `101`.

The functions only return values (they never print), and no Prelude base-conversion functions are used.

| # | Function | Signature | Description |
|---|----------|-----------|-------------|
| 1 | `bin2dec` | `[Bool] -> Int` | Unsigned binary to decimal |
| 2 | `dec2bin` | `Int -> Int -> [Bool]` | Non-negative decimal to unsigned binary with N bits |
| 3 | `bincompl2dec` | `[Bool] -> Int` | Two's complement binary to decimal |
| 4 | `dec2bincompl` | `Int -> Int -> [Bool]` | Decimal to two's complement binary with N bits |
| 5 | `somarBin` | `[Bool] -> [Bool] -> Int -> ([Bool], Bool)` | Two's complement addition, returns `(result, overflow)` |

## Why This Project Is Useful

- Demonstrates recursion over lists in Haskell.
- Shows the difference between unsigned and two's complement representations.
- Provides a lightweight example of bit-width limits and overflow detection in binary arithmetic.

## Getting Started

### Prerequisites

- [GHC](https://www.haskell.org/ghc/) (includes `ghci`) installed and available on your `PATH`.

### Load and run

From the repository root run:

```bash
ghci t1.hs
```

What this does:

1. Compiles and loads `t1.hs` into the GHCi interpreter.
2. Lets you call any of the functions interactively (use `:r` to reload after editing).

## Usage Examples

After running `ghci t1.hs` you can call the functions directly:

```haskell
-- 1) bin2dec
bin2dec [True, False, True]            -- 5
bin2dec []                             -- 0   (edge case)

-- 2) dec2bin
dec2bin 2 8                            -- [False,False,False,False,False,False,True,False]
dec2bin 5 0                            -- []  (edge case: zero bits)

-- 3) bincompl2dec
bincompl2dec [True,True,True,True,True,True,True,False]   -- -2
bincompl2dec [True]                    -- -1  (edge case: smallest 1-bit value)

-- 4) dec2bincompl
dec2bincompl (-2) 8                    -- [True,True,True,True,True,True,True,False]
dec2bincompl 5 0                       -- []  (edge case: zero bits)

-- 5) somarBin (operands must have exactly N bits)
somarBin [False,False,True,False] [False,False,True,True] 4   -- ([False,True,False,True], False)   2 + 3 = 5
somarBin [False,True,False,True]  [False,True,False,True]  4   -- ([True,False,True,False], True)    5 + 5 overflows 4 bits
somarBin [False,True,True] [False,False,True] 3                -- ([True,False,False], True)         3 + 1 overflows 3 bits
```

Design notes:

- When the requested number of bits is not enough, `dec2bin` and `dec2bincompl` truncate the result, keeping the least significant bits.
- In two's complement, the first bit has negative weight; negative inputs to `dec2bincompl` are converted by adding `2^bits`.
- `somarBin` adds bit by bit from the least significant bit, propagating the carry and discarding the final carry. Overflow happens when both operands have the same sign and the result has a different one.
- `somarBin` expects both operands to have exactly `bits` bits and to be non-empty.

## Project Structure

```text
.
├── README.md
└── t1.hs        # The 5 functions, with usage examples in comments
```

## Where To Get Help

- Inspect [t1.hs](t1.hs) for the implementation; each exercise includes its statement and usage examples as comments.

## Maintainers and Contributions

Maintainer:

- [@kydoa](https://github.com/kydoa)
