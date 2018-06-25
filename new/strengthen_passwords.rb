# Complete the function below.



def strengthen_passwords(passwords) 
  def rule_1(passwords)
    i = 0
    passwords.length.times do
      j = 0
      passwords[i].length.times do
        letter = passwords[i][j]
        if letter == 's' || letter == 'S'
          passwords[i][j] = '5'
        end
        j += 1
      end
      i += 1
    end
    passwords
  end

  def rule_2(passwords)
    i = 0
    passwords.length.times do
      middle = (passwords[i].length - 1) / 2
      if passwords[i].length % 2 > 0 &&
         passwords[i][middle] !~ /\D/ && 
         middle > 0
         passwords[i][middle] = (passwords[i][middle].to_i * 2).to_s
      end
      i += 1
    end
    passwords
  end

  def rule_3(passwords)
    i = 0
    passwords.length.times do
      if passwords[i].length % 2 == 0
         aux_first = passwords[i][0]
         aux_last = passwords[i][passwords[i].length - 1]

         last = aux_last =~ /\p{Lower}/ ? aux_last.upcase : aux_last.downcase
         first = aux_first =~ /\p{Lower}/ ? aux_first.upcase : aux_first.downcase
         passwords[i][0] = last
         passwords[i][passwords[i].length - 1] = first
      end
      i += 1
    end
    passwords
  end

  def rule_4(passwords)
    i = 0
    
    passwords.length.times do
      if passwords[i] =~ /nextcapital/i
        j = 0
        first_time = true
        passwords[i].length.times do
          if passwords[i][j] =~ /n/i &&
             passwords[i][j + 1] =~ /e/i &&
             passwords[i][j + 2] =~ /x/i &&
             passwords[i][j + 3] =~ /t/i &&
             first_time

             aux_first = passwords[i][j]
             aux_second = passwords[i][j + 1]
             aux_third = passwords[i][j + 2]
             aux_last = passwords[i][j + 3]

             passwords[i][j] = aux_last
             passwords[i][j + 1] = aux_third
             passwords[i][j + 2] = aux_second
             passwords[i][j + 3] =  aux_first

             first_time = false
          end
          j += 1
        end
      end
      i += 1
    end
    passwords
  end

  def result(passwords)
    filter_1 = rule_1(passwords)
    filter_2 = rule_2(filter_1)
    filter_3 = rule_3(filter_2)
    filter_4 = rule_4(filter_3)
  end

  result(passwords)
  
end

passwords_1 = ['GoCardinals', 'Doge', 'nExTcapITalxnextcapital', 'ThreeSThree']

passwords_3 = [
  "Qwerty",
  "traY",
  "DfghjK",
  "zxcv3456nmxc"
]

passwords_4 = [
  "nextcapital",
  "NeXtcapital",
  "nExtCapitAli5cool",
  "hooRayNexTcapItaLnextcapitall"
]


p strengthen_passwords(passwords_1)
p strengthen_passwords(passwords_3)
p strengthen_passwords(passwords_4)