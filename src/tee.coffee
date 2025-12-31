import Generic from "@dashkite/generic"
import { isIterable, isReactive } from "@dashkite/joy/type"
import BufferedIterator from "./buffered/iterator"
import BufferedReactor from "./buffered/reactor"

tee = do ->

  ( Generic.make "tee" )

    .define [ isReactive ], ( i ) ->

      j = do ->
        for await value from i
          left.push value
          right.push value
          yield value

      [ 
        left = BufferedReactor.make j
        right = BufferedReactor.make j
      ]

    .define [ isIterable ], ( i ) ->

      j = Iterator.from do ->
        for value from i
          left.push value
          right.push value
          yield value

      [ 
        left = BufferedIterator.make j
        right = BufferedIterator.make j
      ]

export { tee }
export default tee