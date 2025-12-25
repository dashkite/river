import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

all = curry binary do ->
  
  ( Generic.make "all" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      return false for await x from i when ! predicate.call @, x
      true
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .every predicate.bind @
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.every predicate.bind @
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.every predicate.bind @

export { all }
export default all