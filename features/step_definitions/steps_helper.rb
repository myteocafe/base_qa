module Step_Helper

  def self.data_table_to_list(table, column_name = nil)
    list = []
    table.hashes.each do |array_item|
      if column_name.nil?
        column_name = table.column_names.last
      end
      list.push(array_item[column_name])
    end
    list
  end

end