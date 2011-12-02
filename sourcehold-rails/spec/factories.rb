Factory.define :user do |f|
  f.sequence :id do |i|
    "#{i}"
  end

  f.sequence :email do |s| 
    "#{s}email@test.com"
  end

  f.sequence :username do |u|
    "#{u}name"
  end

  f.sequence :password do |p|
    "!Sf2gki{p}"
  end
end

Factory.define :email do |e|
  e.sequence :id do |i|
    "#{i}"
  end

  e.sequence :email_address do |s| 
    "#{s}email@test.com"
  end
end

Factory.define :repository do |r|
  r.sequence :id do |i|
    "#{i}"
  end
end

Factory.define :message do |r|
  r.sequence :id do |i|
    "#{i}"
  end
end
