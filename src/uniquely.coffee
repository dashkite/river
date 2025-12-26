import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

uniquely = curry binary do ->
  
  ( Generic.make "uniqueBy" )
  
    .define [ Function, isReactive ], ( getter, i ) ->
      seen = new Set()
      for await x from i
        key = getter.call @, x
        unless seen.has key
          seen.add key
          yield x
      return
        
    .define [ Function, isIterable ], ( getter, i ) ->
      seen = new Set()
      for x from i
        key = getter.call @, x
        unless seen.has key
          seen.add key
          yield x
        
export { uniquely }
export default uniquely