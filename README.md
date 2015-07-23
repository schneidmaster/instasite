# Instawidget

Free, simple embeddable Instagram widget.

![Instawidget Screenshot](https://cloud.githubusercontent.com/assets/1896112/8843217/a342d5fc-30cb-11e5-95a5-ba2e8f82a73e.png)

## Usage

1. The widget uses [BassCSS](http://www.basscss.com/). The minified version (11KB) is provided in `dist/production.min.css` as a convenience; if your site already uses BassCSS, you're all set.
2. Grab `dist/production.min.js` and include it in your site. If you already have jQuery as a dependency, you can just grab `dist/production.lite.min.js` instead.
3. Create a blank div and initialize the plugin with jQuery:

```javascript
$('#my_container_div').instawidget({
  'username': 'schneidmaster',       // required
  'access_token': 'my_access_token', // required
  'hashtag': 'nofilter'              // optional
});
```

You must provide your username and access token; you can generate an access token from [PixelUnion](http://instagram.pixelunion.net/) if you need one. If you provide a hashtag, the widget will show photos from across Instagram with that hashtag. If you don't, it will display your photos.

To check out a simple example, clone the repository, insert your username and access token in `examples/index.html`, and open it in a browser.

## Contributing

1. Fork it ( https://github.com/schneidmaster/instawidget/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
