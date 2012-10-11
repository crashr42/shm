describe 'ByArrayNumberRenderer', ->

  beforeEach ->
    beforeEach ->
    days =
      1: "Monday"
      2: "Tuesday"
      3: "Wednesday"
      4: "Thursday"
      5: "Friday"
      6: "Saturday"
      7: "Sunday"
    @n = new ByArrayNumber days, [-53...0].concat([1...54]), 'week_days'
    @r = new ByArrayNumberRenderer()
    @r.render @n

  it 'must be add and remove element', ->
    $(@r.enterValue).val(1)
    $($(@r.elementsSelector).find('option').get(3)).prop('selected', 'selected')
    $(@r.addButton).click()
    expect($(@r.elementsContainer).find('button').length).toEqual(1)
    expect(@r.data.elements.length).toEqual(1)
    expect(@r.data.elements[0]).toEqual('1_4')
    $(@r.elementsContainer).find('button').first().click()
    expect($(@r.elementsContainer).find('button').length).toEqual(0)
    expect(@r.data.elements.length).toEqual(0)

  it 'must be render elements', ->
    @n.addElement 1, 1
    @n.addElement 2, 3
    @r.render @n
    expect($(@r.elementsContainer).find('button').length).toEqual(2)
    expect($($(@r.elementsContainer).find('button').get(0)).prop('data-key')).toEqual('1_1')
    expect($($(@r.elementsContainer).find('button').get(1)).prop('data-key')).toEqual('2_3')
    expect(@r.data.elements.length).toEqual(2)
    expect(@r.data.elements[0]).toEqual('1_1')
    expect(@r.data.elements[1]).toEqual('2_3')