import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

done = ( x ) -> x?.done == true

merge = curry binary do ->
  
  ( Generic.make "merge" )
  
    .define [ isReactive, isReactive ], ( i, j ) ->

      # TODO use await using when available

      i = i[ Symbol.asyncIterator ]()
      j = j[ Symbol.asyncIterator ]()

      while !(( done p ) && ( done q ))
        if ! done p
          p = await i.next()
          yield p.value unless done p
        if ! done q
          q = await j.next()
          yield q.value unless done q
        
    .define [ isIterable, isIterable ], ( i, j ) ->

      # TODO use await using when available
      i = Iterator.from i
      j = Iterator.from j

      while !(( done p ) && ( done q ))
        if ! done p
          p = i.next()
          yield p.value unless done p
        if ! done q
          q = j.next()
          yield q.value unless done q

export { merge }
export default merge        