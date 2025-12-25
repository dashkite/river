import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

group = curry binary do ->
  
  ( Generic.make "groupBy" )
  
    .define [ Function, isReactive ], ( getter, i ) ->
      groups = new Map()
      for await x from i
        key = getter x
        unless groups.has key
          groups.set key, []
        groups
          .get key
          .push x
      groups
        
    .define [ Function, isIterable ], ( getter, i ) ->
      Map.groupBy i, keySelector

export { group }
export default group