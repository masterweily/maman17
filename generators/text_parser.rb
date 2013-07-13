module TextParser

  def self.parse_table raw
    raw_rows = raw.split("\n")

    keys = raw_rows.shift.split("\t").map(&:strip)
    rows = []
    raw_rows.each do |raw_row|
      arr_row = raw_row.split("\t")
      row = {}
      for i in 0..keys.length-1
        key = keys[i]
        value = arr_row[i].strip
        row[key] = value
      end
      rows << row
    end
    return rows
  end

end