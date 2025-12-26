import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

any = curry binary do ->
  
  ( Generic.make "any" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      return true for await x from i when predicate.call @, x
      false
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .some predicate.bind @
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.some predicate.bind @
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.some predicate.bind @

export { any }
export default any