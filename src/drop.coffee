import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

drop = curry binary do ->
  
  ( Generic.make "drop" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      skipping = true
      for await x from i
        if skipping && predicate x then continue
        skipping = false
        yield x
      return
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .dropWhile predicate
      
    .define [ Function, Array ], ( predicate, ax ) ->
      array
        .values()
        .dropWhile predicate

    .define [ Number, isReactive ], ( n, i ) ->
      count = 0
      yield x for await x from i when count++ >= n
      return
        
    .define [ Number, isIterable ], ( n, i ) ->
      Iterator
        .from i
        .drop n
      
    .define [ Number, Array ], ( n, ax ) ->
      array
        .values()
        .drop n

export { drop }
export default drop