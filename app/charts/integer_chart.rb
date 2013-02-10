class IntegerChart
  def self.build(patient_id, parameter_id, from, to)
    data = ::DiagnosticFactory.chart(patient_id, parameter_id, from, to)
    parameter = IntegerParameter.find(parameter_id)
    {
        chart: {
            type: 'spline'
        },
        title: {
            text: parameter.name
        },
        subtitle: {
            text: "#{from} - #{to}"
        },
        rangeSelector: {
            buttons: [{
                type: 'week',
                count: 1,
                text: 'w'
            }, {
                type: 'week',
                count: 2,
                text: '2w'
            }, {
                type: 'month',
                count: 1,
                text: '1m'
            }, {
                type: 'month',
                count: 3,
                text: '3m'
            }, {
                type: 'month',
                count: 6,
                text: '6m'
            }, {
                type: 'year',
                count: 1,
                text: '1y'
            }, {
                type: 'all',
                text: 'All'
            }],
            selected: 0,
            inputEnabled: false
        },
        xAxis: {
            type: 'datetime',
            gridLineWidth: 0
        },
        yAxis: {
            min: parameter.metadata[:validators][:min],
            max: parameter.metadata[:validators][:max],
            minorGridLineWidth: 0,
            gridLineWidth: 0,
            alternateGridColor: nil,
            #plotBands: [{
            #    from: 0,
            #    to: 36,
            #    color: 'rgba(255, 0, 0, 0.2)'
            #}, {
            #    from: 36,
            #    to: 37,
            #    color: 'rgba(0, 255, 0, 0.5)'
            #}, {
            #    from: 36,
            #    to: 100,
            #    color: 'rgba(255, 0, 0, 0.2)'
            #}]
        },
        plotOptions: {
            spline: {
                lineWidth: 4,
                states: {
                    hover: {
                        lineWidth: 5
                    }
                },
                marker: {
                    enabled: true,
                    states: {
                        hover: {
                            enabled: true,
                            symbol: 'circle',
                            radius: 5,
                            lineWidth: 1
                        }
                    }
                }
            }
        },
        series: [
            {
                name: parameter.name,
                lineWidth: 4,
                data: data,
                marker: {
                    radius: 4
                }
            }
        ]
    }
  end
end