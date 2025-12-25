import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

select = curry binary do ->
  
  ( Generic.make "select" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      yield x for await x from i when predicate x
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .filter predicate
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.filter predicate
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.values().filter predicate

export { select }
export default select