namespace :diagnoses do

  #Read diagnoses from  Excel sheet and write those to database
  task :get_from_excel => :environment do

    #Get access to gems
    require 'rubygems'
    #Provide data from Excel sheets
    require 'spreadsheet'

    puts 'I am working'

    path_to_file = '/home/denis/ICD10RUS.xls'

    book = Spreadsheet.open path_to_file
    sheet1 = book.worksheet 0 # can use an index or worksheet name

    sheet1.each_with_index{|row, index|
      if index > 0
        new_diagnose = Diagnosis.new

        new_diagnose.class_code = row[0]
        new_diagnose.class_name = row[1]
        new_diagnose.block_code = row[2]
        new_diagnose.block_name = row[3]
        new_diagnose.code = row[4]
        new_diagnose.code_name = row[5]

        new_diagnose.save

        puts "I have read #{index} rows" if index % 10 == 0
      end
    }
  end
end