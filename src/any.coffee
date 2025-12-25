import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

any = curry binary do ->
  
  ( Generic.make "any" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      return true for await x from i when predicate x
      false
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .some predicate
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.some predicate
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.some predicate

export { any }
export default any