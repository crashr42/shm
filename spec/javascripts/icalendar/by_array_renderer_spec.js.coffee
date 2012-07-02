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

  it 'should be remove element', ->
    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
    number.addElement 1
    number.addElement 2
    number.addElement 3
    renderer = new ByArrayRenderer()
    $(renderer.render number).find('button[class="btn btn-primary"]').first().click()
    expect($(renderer.render number).find('button[class="btn btn-primary"]').length).toEqual(2)
    expect(number.elements.length).toEqual(2)

  it 'should be add element', ->
    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
    renderer = new ByArrayRenderer()
    renderer.render number
    $(renderer.elementsSelector).find('option:first').attr('selected', 'selected')
    $(renderer.addButton).click()
    expect($(renderer.body).find('button[class="btn btn-primary"]').length).toEqual(1)
    expect($(renderer.elementsSelector).find('option[value="1"]').hasClass('hide')).toEqual(true)
    expect($(renderer.elementsSelector).find('option:not(.hide):first').val()).toEqual('2')
    expect(number.elements.length).toEqual(1)

  it 'should be hide elementsSelector when in restore state all elements select', ->
    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
    number.addElement 1
    number.addElement 2
    number.addElement 3
    renderer = new ByArrayRenderer()
    renderer.render number
    expect($(renderer.elementsSelector).hasClass('hide')).toEqual(true)

  it 'should be hide elementsSelector when all elements select', ->
    number = new ByNumber({1:'January', 2:'Febriary', 3:'May'}, 'key')
    renderer = new ByArrayRenderer()
    renderer.render number
    $($(renderer.elementsSelector).find('option').get(0)).attr('selected', 'selected')
    $(renderer.addButton).click()
    $($(renderer.elementsSelector).find('option').get(1)).attr('selected', 'selected')
    $(renderer.addButton).click()
    $($(renderer.elementsSelector).find('option').get(2)).attr('selected', 'selected')
    $(renderer.addButton).click()
    expect($(renderer.elementsSelector).hasClass('hide')).toEqual(true)