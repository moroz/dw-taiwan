const path = require("path");
const glob = require("glob");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const UglifyJsPlugin = require("uglifyjs-webpack-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const ImageminPlugin = require("imagemin-webpack-plugin").default;
const imageminMozjpeg = require("imagemin-mozjpeg");

module.exports = (env, options) => ({
  devtool: "cheap-eval-source-map",
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: { app: "./js/app.js", admin: "./js/admin.js" },
  resolve: {
    extensions: [".ts", ".tsx", ".js", ".sass"],
    mainFields: ["es2015", "module", "main"],
    alias: {
      "../../theme.config$": path.join(__dirname, "theme.config")
    }
  },
  output: {
    filename: "[name].js",
    path: path.resolve(__dirname, "../priv/static/js")
  },
  module: {
    rules: [
      {
        test: /\.(j|t)sx?$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      },
      {
        test: /\.less$/,
        use: [
          "style-loader",
          MiniCssExtractPlugin.loader,
          "css-loader",
          "less-loader"
        ]
      },
      {
        test: /\.(css|sass|scss)$/,
        use: [
          "style-loader",
          MiniCssExtractPlugin.loader,
          "css-loader",
          "sass-loader"
        ]
      },
      {
        test: /\.(png|jpe?g|gif|svg)$/,
        exclude: /node_modules/,
        use: {
          loader: "url-loader",
          options: {
            limit: 8192,
            outputPath: "../images/",
            name: "[hash].[ext]"
          }
        }
      },
      {
        test: /\.(jpe?g|png|gif|svg)$/,
        loader: "image-webpack-loader",
        enforce: "pre"
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: "../css/[name].css" }),
    new CopyWebpackPlugin([{ from: "static/", to: "../" }]),
    new ImageminPlugin({
      test: /\.(jpe?g|png|gif|svg)$/i,
      plugins: [
        imageminMozjpeg({
          quality: 80,
          progressive: true
        })
      ]
    })
  ]
});
