import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import { 
  map 
  reduce
  select
  reject
  find
  any
  all
  collect
} from "../src"

import { pipe } from "@dashkite/joy/function"
import { negate } from "@dashkite/joy/predicate"

double = ( x ) -> x * 2
sum = ( a, b ) -> a + b
even = ( x ) -> ( x % 2 ) == 0
odd = negate even

do ->

  print await test "DashKite River", [

    test "all", [
      test "iterator"
      test "reactor"
    ]
    
    test "any", [
      test "iterator"
      test "reactor"
    ]

    test "collect", [
      test "iterator"
      test "reactor"
    ]

    test "drop", [
      test "iterator"
      test "reactor"
    ]

    test "each", [
      test "iterator"
      test "reactor"
    ]

    test "find", [

      test "iterator", ->
        assert.deepEqual 2,
          find even, [ 1..5 ]

      test "reactor"

    ]

    test "group", [
      test "iterator"
      test "reactor"
    ]

    test "map", [

      test "iterator", ->
        assert.deepEqual [ 2, 4, 6 ], 
          Array.from map double, [ 1..3 ]

      test "reactor"

    ]

    test "merge", [
      test "iterator"
      test "reactor"
    ]

    test "reduce", [

      test "iterator", ->
        assert.equal 6,
          reduce 0, sum, [ 1..3 ]

      test "reactor"

    ]

    test "reject", [

      test "iterator", ->
        odd = ( x ) -> ( x % 2 ) != 0
        assert.deepEqual [ 2, 4 ],
          Array.from reject odd, [ 1..5 ]

      test "reactor"

    ]

    test "resolve", [
      test "iterator"
      test "reactor"
    ]

    test "select", [

      test "iterator", ->
        assert.deepEqual [ 1, 3, 5 ],
          Array.from select odd, [ 1..5 ]

      test "reactor"

    ]

    test "spread", [
      test "iterator"
      test "reactor"
    ]

    test "start", [
      test "iterator"
      test "reactor"
    ]

    test "take", [
      test "iterator"
      test "reactor"
    ]

    test "tap", [
      test "iterator"
      test "reactor"
    ]

    test "unique", [
      test "iterator"
      test "reactor"
    ]

    test "uniquely", [
      test "iterator"
      test "reactor"
    ]

    test "zip", [
      test "iterator"
      test "reactor"
    ]


  ]

  process.exit if success then 0 else 1
