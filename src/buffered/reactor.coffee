class BufferedReactor

  @make: ( i ) -> Object.assign ( new @ ), { i, buffer: [] }

  push: ( value ) -> @buffer.push value

  next: ->

    until ( @buffer.length > 0 ) || ( result?.done == true ) 
      result = await @i.next()

    if @buffer.length > 0
      value: @buffer.shift(), done: false
    else result

  [ Symbol.asyncIterator ]: -> @


export { BufferedReactor }
export default BufferedReactor