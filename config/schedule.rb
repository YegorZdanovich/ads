every 1.day, :at => '12am' do
  rake "status:publish"
end

every 1.day, :at => '11:50pm' do
  rake "status:archiv"
end
