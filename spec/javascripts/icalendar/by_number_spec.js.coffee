describe 'ByNumber', ->
  it 'then add exists element must throw exception', ->
    number = new ByNumber([1], 'key')
    number.addElement(1)
    expect(-> number.addElement(1)).toThrow({message: 'already_exists'})

  it 'serialization test', ->
    number = new ByNumber([1, 2], 'key')
    number.addElement(1)
    number.addElement(2)
    expect(number.serialize()).toEqual({key: [1,2]})

  it 'deserialization test good data', ->
    number = new ByNumber([1, 2], 'key')
    number.deserialize {'key': [1, 2]}
    expect(number.elements).toEqual([1, 2])

  it 'deserialization test, element 3 not alowed', ->
    number = new ByNumber([1, 2], 'key')
    expect(-> number.deserialize {'key': [1, 2, 3]}).toThrow({message: 'element_not_alowed'})

  it 'test remove element', ->
    number = new ByNumber([1, 2], 'key')
    number.addElement 1
    number.removeElement 1
    expect(number.elements.length).toEqual(0)

  it 'work with object', ->
    number = new ByNumber({1:'January', 2:'Febriary'}, 'key')
    number.addElement(1)
    expect(number.elements.length).toEqual(1)

  it 'work with object, duplicate element', ->
    number = new ByNumber({1:'January', 2:'Febriary'}, 'key')
    number.addElement(1)
    expect(-> number.addElement(1)).toThrow({message:'already_exists'})

  it 'work with object, serialization test', ->
    number = new ByNumber({1:'January', 2:'Febriary'}, 'key')
    number.addElement(1)
    number.addElement(2)
    expect(number.serialize()).toEqual({key: [1,2]})

  it 'work with object, deserialization test good data', ->
    number = new ByNumber({1:'January', 2:'Febriary'}, 'key')
    number.deserialize {'key': [1, 2]}
    expect(number.elements).toEqual([1, 2])

  it 'work with object, deserialization test, element 3 not alowed', ->
    number = new ByNumber({1:'January', 2:'Febriary'}, 'key')
    expect(-> number.deserialize {'key': [1, 2, 3]}).toThrow({message: 'element_not_alowed'})

