import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

uniquely = curry binary do ->
  
  ( Generic.make "uniqueBy" )
  
    .define [ Function, isReactive ], ( getter, i ) ->
      seen = new Set()
      for await x from i
        key = getter x
        unless seen.has key
          seen.add key
          yield x
      return
        
    .define [ Function, isIterable ], ( getter, i ) ->
      seen = new Set()
      for x from i
        key = getter x
        unless seen.has key
          seen.add key
          yield x
        
export { uniquely }
export default uniquely