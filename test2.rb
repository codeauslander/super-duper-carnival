def contains_capital(word)
  capital = "nextcapital".split("")
  capital.each do |letter|
    return false if !word.include?(letter)
  end
  true
end

p contains_capital('asdofnextcasdfsadapitalijasdkf')
p contains_capital('asdofnetcasdfsadapitalijasdkf')