class IteratorQueue extends Iterator

  @make: -> new Queue

  constructor: ->
    super()
    @buffer = []
    @closed = false

  enqueue: ( value ) ->
    if !@closed
      @buffer.push value
    else
      throw new Error "attempt to enqueue with a closed queue"
    @

  dequeue: -> 
    if buffer.length > 0 
      @buffer.shift()
    else
      throw new Error "attempt to dequeue from an empty queue"

  close: -> 
    @closed = true
    @

  next: ->
    if @buffer.length > 0
      value: @buffer.shift(), done: false
    else
      done: true

export { IteratorQueue }
export default IteratorQueue