require 'nokogiri'

module Jekyll
    module AmpFilter
        def amp_images(input, responsive = true, wi = nil, he = nil)
            width = wi || @context.registers[:site].config['img_width'] || 700
            height = he || @context.registers[:site].config['img_height'] || 300
            doc = Nokogiri::HTML.fragment(input);
            doc.css('img:not([width])').each do |image|
                image['width'] = width.to_s
                image['height'] = height.to_s
            end
            doc.css('img').each do |image|
                image.name = "amp-img"
                image["layout"] = "responsive" if responsive
            end
            doc.to_s
        end
    end
end

Liquid::Template.register_filter(Jekyll::AmpFilter)