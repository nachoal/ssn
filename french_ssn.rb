require 'date'
require 'yaml'


def valid_number?(ssn_key, ssn)
  # A 2 digits key (46, equal to the remainder of the division of (97 - ssn_without_key) by 97.)

  ssn_without_key = ssn.gsub(/\d{2}$/, "").gsub(/\s*/,"").to_i

  ssn_key.to_i == (97 - (ssn_without_key  % 97))
end

def french_ssn_info(ssn)

  # Check if the number is valid 
  regex = /^(?<gender>[1-2])\W?(?<birth_year>\d{2})\W?(?<birth_month>\d{2})\W?(?<department>\d{2})\W?(\d{3})\W?(\d{3})\W?(?<ssn_key>\d{2})/
  match_group = ssn.match(regex)
  ssn_info = nil
  
  if ssn.match?(regex) && valid_number?(match_group[:ssn_key], ssn)
    gender      = match_group[:gender] == "1" ? "a man, born in" : "a woman, born in" 
    birth_month = Date::MONTHNAMES[match_group[:birth_month].to_i]
    birth_year  =  if [0,1,2].include?(match_group[:birth_year][0])
                    "20#{match_group[:birth_year]}"
                  else
                    "19#{match_group[:birth_year]}"
                  end
    
    departments = YAML.load_file('data/french_departments.yml')
    department  = departments[match_group[:department]]

    ssn_info = "#{gender} #{birth_month}, #{birth_year} in #{department}."
    # if so extract the information that we need and store in variables
      # Gender (1 == man, 2 == woman)
      # Year of birth (84)
      # Month of birth (12)
      # Department of birth (76, basically included between 01 and 99)
      # 6 random digits (451 089)
      # A 2 digits key (46, equal to the remainder of the division of (97 - ssn_without_key) by 97.)

    # Return a string containing the info that we need: 
      # If right "a man, born in December, 1984 in Seine-Maritime."
  else
    ssn_info = "The number is invalid"
  end
  

  ssn_info
end