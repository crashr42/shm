#encoding: utf-8

namespace :medicaments do

  #Read diagnoses from  Excel sheet and write those to database
  task :get_from_excel => :environment do

    #Get access to gems
    require 'rubygems'
    #Provide data from Excel sheets
    require 'spreadsheet'

    puts 'I am working'

    path_to_file = '/home/denis/реестр30.09.2011.xls'

    book = Spreadsheet.open path_to_file
    sheet1 = book.worksheet 0 # can use an index or worksheet name

    sheet1.each_with_index{|row, index|
      if index > 0
        new_medicament = Medicament.new

        new_medicament.reg_num = row[0]
        new_medicament.commercial_name = row[2]
        new_medicament.producer =  row[7]
        new_medicament.med_type = row[1]
        new_medicament.atx_class = row[11]
        new_medicament.form_factor = row[12]

        new_medicament.save

        puts "I have read #{index} rows" if index % 10 == 0
      end
    }
  end
end