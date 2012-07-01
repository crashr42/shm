describe 'ByArrayRenderer', ->
  it 'render only ByNumber instance', ->
    renderer = new ByArrayRenderer()
    expect(-> renderer.render new ByWeekDays()).toThrow({message: 'instance_type_not_alowed'})

  it 'should be restore state', ->
    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
    number.addElement 1
    number.addElement 2
    number.addElement 3
    renderer = new ByArrayRenderer()
    expect($(renderer.render number).find('button[class="btn btn-primary"]').length).toEqual(3)

#  it 'should be remove element', ->
#    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
#    number.addElement 1
#    number.addElement 2
#    number.addElement 3
#    renderer = new ByArrayRenderer()
#    $(renderer.render number).find('button[class="btn btn-primary"]').first().click()
#    expect($(renderer.render number).find('button[class="btn btn-primary"]').length).toEqual(2)
#    expect(number.elements.length).toEqual(2)
#
#  it 'should be add element', ->
#    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
#    renderer = new ByArrayRenderer()
#    $(renderer.render number)
#    $(renderer.enterValue).val(1)
#    $(renderer.addButton).click()
#    expect($(renderer.render number).find('button[class="btn btn-primary"]').length).toEqual(1)
#    expect(number.elements.length).toEqual(1)
#
#  it 'should be not add element', ->
#    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
#    renderer = new ByArrayRenderer()
#    $(renderer.render number)
#    $(renderer.enterValue).val(123)
#    $(renderer.addButton).click()
#    expect(number.elements.length).toEqual(0)
#    expect($(renderer.render number).find('button[class="btn btn-primary"]').length).toEqual(0)