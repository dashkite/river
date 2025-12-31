class BufferedIterator extends Iterator

  @make: ( i ) -> Object.assign ( new @ ), { i, buffer: [] }

  push: ( value ) -> @buffer.push value

  next: ->

    until ( @buffer.length > 0 ) || ( result?.done == true ) 
      result = @i.next()

    if @buffer.length > 0
      value: @buffer.shift(), done: false
    else result 


export { BufferedIterator }
export default BufferedIterator