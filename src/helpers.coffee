isIterable = ( value ) -> value[ Symbol.iterator ]?

isReactive = ( value ) -> value[ Symbol.asyncIterator ]?

export {
  isIterable
  isReactive
}