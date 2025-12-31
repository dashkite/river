import Generic from "@dashkite/generic"
import { curry, binary } from "@dashkite/joy/function"
import { isIterable, isReactive } from "@dashkite/joy/type"
import tap from "./tap"
import BufferedIterator from "./buffered/iterator"
import BufferedReactor from "./buffered/reactor"

partition = curry binary do ->

  ( Generic.make "partition" )

    .define [ Function, isReactive ], ( predicate, i ) ->

      classify = ( value ) ->
        ( if predicate value then selected else rejected )
          .push value

      j = do ->
        for await value from i
          classify value
          yield value

      [
        selected = BufferedReactor.make j
        rejected = BufferedReactor.make j
      ]

    .define [ Function, isIterable ], ( predicate, i ) ->

      classify = ( value ) ->
        ( if predicate value then selected else rejected )
          .push value

      j = Iterator.from do ->
        for value from i
          classify value
          yield value

      [
        selected = BufferedIterator.make j
        rejected = BufferedIterator.make j
      ]

export { partition }
export default partition