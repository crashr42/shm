class BoolChart
  def self.build(patient_id, parameter_id, from, to)
    data = ::DiagnosticFactory.chart(patient_id, parameter_id, from, to)
    parameter = BoolParameter.find(parameter_id)
    {
        chart: {
            plotBackgroundColor: nil,
            plotBorderWidth: nil,
            plotShadow: false
        },
        title: {
            text: parameter.name
        },
        subtitle: {
            text: "#{from} - #{to}"
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            percentageDecimals: 1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false,
                    color: '#000000',
                    connectorColor: '#000000'
                },
                showInLegend: true
            }
        },
        series: [{
            type: 'pie',
            name: parameter.name,
            data: [
                ['No', data[0]],
                ['Yes', data[1]]
            ]
        }]
    }
  end
end