import { curry, binary, tee } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"


tap = curry binary do ->
  
  ( Generic.make "tap" )
  
    .define [ Function, isReactive ], ( f, i ) ->
      for await x from i
        f x
        yield x
        
    .define [ Function, isIterable ], ( f, i ) ->
      Iterator
        .from i
        .map tee f
        
    .define [ Function, Iterator ], ( f, i ) ->
      i.map tee f
      
    .define [ Function, Array ], ( f, ax ) ->
      ax
        .values()
        .map tee f

export { tap }
export default tap