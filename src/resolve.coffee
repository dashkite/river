import Generic from "@dashkite/generic"
import { unary } from "@dashkite/joy/function"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

resolve = unary do ->
  
  ( Generic.make "resolve" )
  
    .define [ isReactive ], ( i ) ->
      yield await p for await p from i
        
    .define [ isIterable ], ( i ) ->
      yield await p for p from i
        
    .define [ Array ], ( ax ) ->
      yield await p for p in ax

export { resolve }
export default resolve