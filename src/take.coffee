import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

take = curry binary do ->
  
  ( Generic.make "take" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      for await x from i
        break if ! predicate x
        yield x
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator.from(i).takeWhile predicate
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.values().takeWhile predicate

    .define [ Number, isReactive ], ( n, i ) ->
      count = 0
      for await x from i
        yield x
        break if ++count >= n
        
    .define [ Number, isIterable ], ( n, i ) ->
      Iterator
        .from i
        .take n
      
    .define [ Number, Array ], ( n, ax ) ->
      ax
        .values()
        .take n

export { take }
export default take