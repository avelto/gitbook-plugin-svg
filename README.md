# GitBook SVG Plugin

> First class citizen SVG for gitbooks

## Source documentation

- [gulpfile.coffee](gulpfile.html)
- [index.js](index.html)

## Online demo

## Installation
In your book.json add the plugin:
```json
{
    "plugins": [
        "svg"
    ]
}
```

If you're building your book locally, download and prepare plugins by simply running ```gitbook install```.

## Configuration

## Developments

### Serve and watch documentation while developing 

    $ gulp serve

### While working on the gulpfile

Not to have to reload the `gulp serve-docs` at every change

    $ nodemon /usr/local/bin/gulp serve-docs -w gulpfile.coffee

### Dependencies installation

```bash
$ npm install --save-dev coffee-script gulp gulp-watch gulp-connect gulp-livereload gulp-docco gulp-markdown

$ npm install --save-dev async
```
