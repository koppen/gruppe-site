const { env } = require("../configuration.js");

module.exports = {
  module: {
    rules: [
      {
        test: /\.(scss|sass|css)$/i,
        use: [
          // Creates `style` nodes from JS strings
          'style-loader',
          // Translates CSS into CommonJS
          'css-loader',
          // Rewrites URLs to work with Sass
          'resolve-url-loader',
          // Compiles Sass to CSS
          'sass-loader',
        ],
      },
    ],
  },
};
