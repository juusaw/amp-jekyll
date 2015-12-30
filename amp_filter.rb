module Jekyll
    module AmpFilter
        def amp_images(input, responsive = true, wi = nil, he = nil)
            if responsive
                layout = ' layout="responsive"'
            else
                layout = ""
            end
            width = wi || @context.registers[:site].config['img_width'] || 700
            height = he || @context.registers[:site].config['img_height'] || 300
            input.gsub!('<img ', '<amp-img width='+width.to_s+' height='+height.to_s+layout+' ')
            input
        end
    end
end

Liquid::Template.register_filter(Jekyll::AmpFilter)