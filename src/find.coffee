import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

find = curry binary do ->
  
  ( Generic.make "find" )
  
    .define [ Function, isReactive ], ( predicate, i ) ->
      return x for await x from i when predicate x
      undefined
        
    .define [ Function, isIterable ], ( predicate, i ) ->
      Iterator
        .from i
        .find predicate
        
    .define [ Function, Iterator ], ( predicate, i ) ->
      i.find predicate
      
    .define [ Function, Array ], ( predicate, ax ) ->
      ax.find predicate

export { find }
export default find