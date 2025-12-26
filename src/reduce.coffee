import { curry, ternary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

isAny = -> true

reduce = curry ternary do ->
  
  ( Generic.make "reduce" )

    .define [ isAny, Function, isReactive ], ( seed, reducer, i ) ->
      result = seed
      for await x from i
        result = reducer.call @, result, x 
      result

    .define [ isAny, Function, isIterable ], ( seed, reducer, i ) ->
      Iterator
        .from i
        .reduce ( reducer.bind @ ), seed

    .define [ isAny, Function, Iterator ], ( seed, reducer, i ) ->
      i.reduce ( reducer.bind @ ), seed

    .define [ isAny, Function, Array ], ( seed, reducer, ax ) ->
      ax.reduce ( reducer.bind @ ), seed

export { reduce }
export default reduce