# amp-jekyll

Jekyll plugin for creating Accelerated Mobile Page versions of posts. Supports Jekyll version 3.

[AMP project](https://www.ampproject.org/)
### Usage
- Place the Ruby files (`amp_generate.rb` and `amp_filter.rb`) in folder _plugins at the root of the project
- Place the layout file (`amp.html`) to the _layouts folder
- Add `amphtml`-link to post heads (see page linking below)
(Add CSS styles to the html template)
- Generate your site with `jekyll serve`

### Setting things up

The AMP standard is somewhat restrictive on allowed HTML elements and requires some extra information on element placing. To make sure that your generated AMP pages are valid by the standard, you can run the AMP version of your post with **#development=1** appended to the URL and check the browser's Javascript console for the validation.

IMPORTANT! The AMP standard forces you to specify the width and height of many elements (most notably images) inline. At the moment the best option is to include images as pure HTML in post markdown and include the dimensions of the images. If the dimensions aren't specified the plugin checks if the dimensions are given as a filter parameter in the amp.html template. If the dimensions are still unspecified, config parameters are used. Make sure to specify the size.

Several HTML elements must be replaced with tags specified in the AMP specs to ensure compatibility with the standard. The `amp_filter.rb` Jekyll filter replaces the tags after converting the markdown to HTML. At the moment only replacing `<img>` tags is supported.


### Configuration
Jekyll config variables can be used to specify the behavior of the plugins. Config variables should be added to the `_config.yml` file in the root of the project. All of the variables described are optional. Pre-defined default values will be used unless the variables are set.

Currently supported variables are

- `amp_image_width`: default width of amp-image elements set if the element has no size set
- `amp_image_height`: default height

### Page linking
To make your AMP page discoverable (by search engines etc.) you need to link it to the regular version of the page. Add the following element to your post headers.

```
<link rel="amphtml" href="{{ page.id | append:'/index.html' | prepend: site.baseurl | prepend: site.url }}">
```

There are several possible solutions to adding the tag to post pages only. One option is to use a separate head template for posts. The easiest (though a bit gimmicky) solution is adding the following conditional expression around the tag.

```
{% if page.path contains '_posts' %}
<link rel="amphtml" href="{{ page.id | append:'/index.html' | prepend: site.baseurl | prepend: site.url }}">
{% endif %}
```

### CSS
CSS rules for AMP must be included inline in the `<style amp-custom>` tag in the `<head>` element in the HTML. You can write the CSS rules by hand or use jekyll includes. Do note that the AMP specification forbids the use of some CSS selectors and attributes. Because of this, it is not a good idea to include the main stylesheet by default.
