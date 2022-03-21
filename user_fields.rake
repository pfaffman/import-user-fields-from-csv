# frozen_string_literal: true

require "csv"
desc "Import user fields"
task "user_fields:import_csv", [:filename] => [:environment] do |_, args|

  puts "Filename: #{args[:filename]}"
  data = CSV.read(args[:filename], headers: true );

  data.each_entry do |row|
    puts "doing row."
    row.to_h.each do |x|
      user_id = row['user_id']
      if x.first == 'user_id'
        u = User.find(user_id)
        puts "Got user: #{u.username}"
      else
        name = x.first
        val = row[x.first]
        ucf = UserCustomField.find_by(user_id: row['user_id'], name: name)
        if ucf
          if val != ucf.value
            puts "Updating UCF: #{row['user_id']} Name: #{name}, Found #{ucf.value}}"
            ucf.update(value: val)
          end
        else
          if val
            puts "Creating UCF: #{row['user_id']} Name: #{name}, value: #{val}"
            UserCustomField.create(user_id: user_id, name: name, value: val)
          end
        end
      end
    end
  end
end
