import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import { 
  all
  any
  collect
  drop
  each
  find
  group
  map 
  merge
  partition
  IteratorQueue
  ReactorQueue as Queue
  reduce
  reject
  resolve
  select
  spread
  start
  take
  tap
  tee
  unique
  uniquely
  zip
} from "../src"

import { pipe } from "@dashkite/joy/function"
import { negate } from "@dashkite/joy/predicate"

call = ( args..., f ) -> f.call null, args...

double = ( x ) -> x * 2
sum = ( a, b ) -> a + b
even = ( x ) -> ( x % 2 ) == 0
odd = negate even

resolving = ( i ) ->
  for x from i
    yield await Promise.resolve x

rejecting = ->
  yield await Promise.reject new Error "Reactor Failure"

promised = ( i ) -> i.map ( x ) -> Promise.resolve x

cycle = ( i ) ->
  loop yield x for x from i

# --- Test Suite ---
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

      test "iterator", ->
        assert.deepEqual [ 1, 2 ], 
          collect [ 1, 2 ].values()

      test "reactor", ->
        assert.deepEqual [ 1, 2 ], 
          await collect resolving [ 1, 2 ]
    ]

    test "drop", [

      test "iterator", ->
        assert.deepEqual [ 3, 4 ], collect drop 2, [ 1..4 ]

      test "reactor", ->
        assert.deepEqual [ 3, 4 ], 
          await collect drop 2, resolving [ 1..4 ]
    ]

    test "each", [

      test "iterator", ->
        x = 0
        add = ( y ) -> x += y
        each add, [ 1..3 ]
        assert.equal 6, x

      test "reactor", ->
        x = 0
        add = ( y ) -> x += y
        await each add, resolving [ 1..3 ]
        assert.equal 6, x
    ]

    test "find", do -> 

      # for testing short-circuit
      x = undefined
      integers = -> yield x++ while x < 100

      [

        test "iterator", ->
          x = 1
          assert.equal 2, find even, integers()
          assert.equal 3, x

        test "reactor", ->
          x = 1
          assert.equal 2, 
            await find even, resolving integers()
          assert.equal 3, x

      ]

    test "group", [
      test "iterator"
      test "reactor"
    ]

    test "map", [

      test "iterator", [

        test "function", ->
          assert.deepEqual [ 2, 4, 6 ], 
            collect map double, [ 1..3 ]

        test "method", ->
          class Name
            constructor: ( @value ) ->
            append: ( x ) -> "#{ x }-#{ @value }"
            appendAll: pipe [
              map Name::append
              collect
            ]
          
          foo = new Name "foo"
          assert.deepEqual [ "1-foo", "2-foo", "3-foo" ],
            foo.appendAll [ 1..3 ]

      ]

      test "reactor", ->
        assert.deepEqual [ 2, 4, 6 ], 
          await collect map double, resolving [ 1..3 ]

    ]

    test "merge", [

      test "iterator", ->
        assert.deepEqual [ 1, 3, 2, 4 ],
          collect merge [ 1, 2 ], [ 3, 4 ]

      test "reactor", ->
        assert.deepEqual [ 1, 3, 2, 4 ],
          await collect merge ( resolving [ 1, 2 ]), ( resolving [ 3, 4 ])

    ]

    test "queue", [

      test "reactor", [

        test "drain buffer", [

          test "close before", ->

            q = Queue.make()
            q.enqueue "last item"

            q.close()

            await do ->
              for await value from q
                assert.equal "last item", value

          test "close after", ->

            q = Queue.make()
            q.enqueue "last item"

            pending = do ->
              for await value from q
                assert.equal "last item", value

            q.close()

            await pending

          test "close empty", ->

            q = Queue.make()

            assert.rejects ->
              value for await value from q

            q.close()

        ]


      ]
    ]

    test "partition", [

      test "iterator", -> 
        # prove that we can handle one-time use iterators
        source = [ 1..4 ].values()
        [ evens, odds ] = partition even, source
        assert.deepEqual [ 2, 4 ], collect evens
        assert.deepEqual [ 1, 3 ], collect odds

      test "reactor", ->
        [ evens, odds ] = partition even, resolving [ 1..4 ]
        assert.deepEqual [ 2, 4 ], await collect evens
        assert.deepEqual [ 1, 3 ], await collect odds    

    ]

    test "reduce", [

      test "iterator", ->
        assert.equal 6,
          reduce 0, sum, [ 1..3 ]

      test "reactor"

    ]

    test "reject", [
      test "iterator", ->
        assert.deepEqual [ 1, 3, 5 ],
          collect reject even, [ 1..5 ]
    ]

    test "resolve", [

      test "iterable", ->
        assert.deepEqual [ 1..5 ], 
          await collect resolve promised [ 1..5 ]

      test "reactive"

    ]

    test "select", [

      test "iterator", ->
        assert.deepEqual [ 1, 3, 5 ],
          collect select odd, [ 1..5 ]

      test "reactor"

    ]

    test "spread", do ->

      clone = ( x ) -> [ x, x ]

      [

        test "iterator", ->
          assert.deepEqual [ 1, 1, 2, 2 ], 
            collect spread clone, [ 1, 2 ]

        test "reactor", ->
          assert.deepEqual [ 1, 1, 2, 2 ], 
            await collect spread clone, resolving [ 1, 2 ]

      ]

    test "start", [
      test "iterator"
      test "reactor"
    ]

    test "take", [

      test "iterator", ->
        assert.deepEqual [ 1, 2, 1, 2 ], 
          collect take 4, cycle [ 1, 2 ]

      test "reactor", ->
        assert.deepEqual [ 1, 2, 1, 2 ], 
          await collect take 4, resolving cycle [ 1, 2 ]

    ]

    test "tap", [

      test "iterator", ->
        x = 0
        f = -> x++
        collect tap f, [ 1..5 ]
        assert.equal 5, x

      test "reactor", ->
        x = 0
        f = -> x++
        await collect tap f, resolving [ 1..5 ]
        assert.equal 5, x

    ]

    test "tee", [

      test "iterator", ->
        [ i, j ] = tee [ 1..5 ].values()
        assert.deepEqual [ 1..5 ], collect i
        assert.deepEqual [ 1..5 ], collect j

      test "reactor", ->
        [ i, j ] = tee resolving [ 1..5 ]
        assert.deepEqual [ 1..5 ], await collect i
        assert.deepEqual [ 1..5 ], await collect j

    ]

    test "unique", [
      test "iterator", ->
        assert.deepEqual [ 1, 2 ], 
          collect unique [ 1, 1, 2, 2 ]        
      test "reactor"
    ]

    test "uniquely", [
      test "iterator"
      test "reactor"
    ]

    test "zip", [

      test "iterator", ->
        assert.deepEqual [[ 1, 3 ], [ 2, 4 ]],
          collect zip [ 1, 2 ], [ 3, 4 ]

      test "reactor", ->
        assert.deepEqual [[ 1, 3 ], [ 2, 4 ]],
          await collect zip ( resolving [ 1, 2 ]), ( resolving [ 3, 4 ])

    ]


  ]