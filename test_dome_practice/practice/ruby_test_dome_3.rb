module FileOwners

  def self.group_by_owners(files)
    group = {}
    index = 0
    files.length.times do
      new_value = files.keys[index]
      new_key =  files[new_value]
      group[new_key] = [] unless group[new_key]
      group[new_key] << new_value
      index += 1
    end
    return group
  end
  
end

files = {
  'Input.txt' => 'Randy',
  'Code.py' => 'Stan',
  'Output.txt' => 'Randy',
}
puts FileOwners.group_by_owners(files)
