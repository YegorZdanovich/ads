namespace :status do
  
  desc "publish all approved ads"
  task :publish => :environment do
    Advertisement.approved.each(&:publish)
  end

  desc "published ads go to archiv"
  task :archiv => :environment do
    Advertisement.published.each do |ads|
      time_now = Time.now.to_i
      time_last_updtate = ads.updated_at.to_time.to_i

      # 86400 - one day in seconds
      if ((time_now - time_last_updtate)/ 86400 ) >= 3 
        ads.archiv
      end
    end
  end

end