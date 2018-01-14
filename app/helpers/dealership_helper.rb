module DealershipHelper

    def editing(f)
        f.options[:html][:method].to_s.include?("patch")
    end
end
