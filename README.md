# amp-jekyll

Jekyll plugin for creating Accelerated Mobile Page versions of posts. Supports Jekyll version 3.

[AMP project](https://www.ampproject.org/)
### Usage
- Place the Ruby files (`amp_generate.rb` and `amp_filter.rb`) in folder _plugins at the root of the project
- Place the layout file (`amp.html`) to the _layouts folder
- Add `amphtml`-link to post heads (see page linking below)
(Add CSS styles to the html template)
- Generate your site with `jekyll serve`

AMP-Jekyll uses [Nokogiri][nokogiri] gem for HTML parsing and [FastImage][fastimage] for image processing. You can install the gems with

```
gem install nokogiri
```

```
gem install fastimage
```

### Setting things up

The AMP standard is somewhat restrictive on allowed HTML elements and requires some extra information on element placing. To make sure that your generated AMP pages are valid by the standard, you can run the AMP version of your post with **#development=1** appended to the URL and check the browser's Javascript console for the validation.

Several HTML elements must be replaced with tags specified in the AMP specs to ensure compatibility with the standard. The `amp_filter.rb` Jekyll filter replaces the tags after converting the markdown to HTML. At the moment only replacing `<img>` tags is supported.

To disable image responsivity, add false to `amp_images` responsive parameter in amp.html. This is enabled by default for header and footer.

### The AMP folder
specify amp folder in `_config.yml` as `ampdir: YOURDIR`

### Page linking
The easiest (though a bit gimmicky) solution is adding the following conditional expression around the tag.

```
{% if page.path contains '_posts' %}
  <link rel="amphtml" href="{{ page.id | prepend: '/YOURDIR' | prepend: site.baseurl | prepend: site.url }}">
{% endif %}
```

### CSS
CSS rules for AMP must be included inline in the `<style amp-custom>` tag in the `<head>` element in the HTML. You can write the CSS rules by hand or use jekyll includes. Do note that the AMP specification forbids the use of some CSS selectors and attributes. Because of this, it is not a good idea to include the main stylesheet by default.

[nokogiri]: http://www.nokogiri.org/
[fastimage]: https://github.com/sdsykes/fastimage
