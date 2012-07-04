describe 'ByManager', ->

  beforeEach ->
    @m = new ByManager()

  it 'must be valid part by frequency WEEKLY', ->
    @m.setFrequency 'WEEKLY'
    expect(@m.getParts().hasOwnProperty('month_days')).toEqual(false)
    expect(@m.getParts().hasOwnProperty('year_days')).toEqual(false)
    expect(@m.getParts().hasOwnProperty('weeks')).toEqual(false)

  it 'serialization test', ->
    parts = @m.getParts()
    parts.seconds.addElement 1
    parts.minutes.addElement 2
    parts.hours.addElement 3
    parts.month_days.addElement 2
    parts.year_days.addElement 45
    parts.weeks.addElement 5
    parts.positions.addElement 255
    parts.months.addElement 1
    parts.week_days.addElement 1, 3
    expect(@m.serialize().hasOwnProperty('seconds')).toEqual(true)
    expect(@m.serialize()['seconds']).toEqual([1])
    expect(@m.serialize().hasOwnProperty('month_days')).toEqual(true)
    expect(@m.serialize()['month_days']).toEqual([2])

  it 'deserialization test', ->
    data =
      seconds:    [1, 3]
      week_days:  ['1_3', '3_5']
      positions:  [244, 13, 11]

    @m.deserialize(data)
    expect(@m.getParts().seconds.elements).toEqual([1, 3])
    expect(@m.getParts().week_days.elements).toEqual(['1_3', '3_5'])
    expect(@m.getParts().positions.elements).toEqual([244, 13, 11])
