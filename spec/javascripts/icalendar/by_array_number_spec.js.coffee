describe 'ByArrayNumber', ->

  beforeEach ->
    days =
      1: "Monday"
      2: "Tuesday"
      3: "Wednesday"
      4: "Thursday"
      5: "Friday"
      6: "Saturday"
      7: "Sunday"
    @n = new ByArrayNumber days, [-53...0].concat([1...54])

  it 'must be add element', ->
    @n.addElement 1, 1
    expect(@n.elements.length).toEqual(1)
    expect(@n.elements[0]).toEqual([1, 1].join('_'))

  it 'duplicate add element', ->
    @n.addElement 1, 1
    expect($.proxy((-> @n.addElement(1, 1)), @)).toThrow({message: "already_exists"})
    expect(@n.elements.length).toEqual(1)

  it 'is not allowed element', ->
    expect($.proxy((-> @n.addElement(1123, 1)), @)).toThrow({message: "element_not_alowed"})
    expect(@n.elements.length).toEqual(0)

  it 'get value by key', ->
    expect(@n.getValue(1)).toEqual('Monday')
    expect(@n.getValue(6)).toEqual('Saturday')

  it 'serialization test', ->
    @n.addElement 1, 1
    @n.addElement 1, 2
    @n.addElement 2, 1
    expect(@n.serialize()).toEqual(['1_1', '1_2', '2_1'])

  it 'deserialization test', ->
    @n.deserialize ['1_1', '1_2', '2_1']
    expect(@n.elements).toEqual(['1_1', '1_2', '2_1'])