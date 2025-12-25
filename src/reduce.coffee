import { curry, ternary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

isAny = -> true

reduce = curry ternary do ->
  
  ( Generic.make "reduce" )

    .define [ isAny, Function, isReactive ], ( seed, reducer, i ) ->
      result = seed
      result = reducer acc, x for await x from i
      result

    .define [ isAny, Function, isIterable ], ( seed, reducer, i ) ->
      Iterator
        .from i
        .reduce reducer, seed

    .define [ isAny, Function, Iterator ], ( seed, reducer, i ) ->
      i.reduce reducer, seed

    .define [ isAny, Function, Array ], ( seed, reducer, ax ) ->
      ax.reduce reducer, seed

export { reduce }
export default reduce