describe 'ByMangerRenderer', ->

  beforeEach ->
    @m = new ByManager()
    @r = new ByManagerRenderer()

  it 'must be create valid html', ->
    @r.render @m
    expect($(@r.buttonsGroup).find('button').length).toEqual(9)