module AttrecordHelper
    #this helper will to be ensure everything gets reset at the month period when it should be.
    def reset_flexes(user)
        flex = user.attrecords.first
        time = Time.now
        flexes = []
        flexes.push(flex.flexone, flex.flextwo, flex.flexthree)
        flexes.each do|f|
            if f != nil and f.month != time.month
                f = nil
            end
        end
        flexes.each_with_index do |f, index|
            if f == nil
                if index == 1
                    flex.update(flexone: :nil)
                elsif index == 2
                    flex.update(flextwo: :nil)
                else
                    flex.update(flexthree: :nil)
                end
            end
        end
    end
end
