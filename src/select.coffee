import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

select = curry binary do ->
  
  ( Generic.make "select" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      yield x for await x from i when predicate.call @, x
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .filter predicate.bind @
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.filter predicate.bind @
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.values().filter predicate.bind @

export { select }
export default select