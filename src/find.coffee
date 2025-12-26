import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

find = curry binary do ->
  
  ( Generic.make "find" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      return x for await x from i when predicate.call @, x
      undefined
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .find predicate.bind @
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.find predicate.bind @
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.find predicate.bind @

export { find }
export default find