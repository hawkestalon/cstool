module MissHelper
    def atoToMiss(user)
        ato = Ato.where(:user_id => user.id)
        time = Time.now
        ato.each do |at|
            if at.a_date < time
                temp = at.attributes
                attributes = temp.select{|key, value| key == "reason" or key == "a_date" or key == "hours"}
                if(!Miss.exists?(:a_date => attributes["a_date"] ))
                    miss = user.miss.build(attributes)
                    miss.save
                end
            end
        end
    end
   
end
