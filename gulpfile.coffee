## Gulpfile
# Last modified: jpa 04/05/2016 15:42

# General purpose gulpfile with a focus on generating live documentation
# - `generating`
# - `serving`
# - `watching`
# - `livereloading`


# Main module documentation, see [README.html](./README.html)

## Install libraries
# Install and save required libraries to package.json.
#```bash
#$ npm install --save-dev coffee-script gulp gulp-util gulp-connect gulp-watch gulp-livereload gulp-docco gulp-markdown
#$ npm install --save-dev gulp-md-svg-docs
#```

## External libraries

# Require our external dependencies.
fs          = require 'fs'
path        = require 'path'

# Default gulp library, required.
gulp          = require 'gulp'

# Used for logging for example with `gutil.log`.
gutil         = require 'gulp-util'

# Enable us to create simple server with liverload enabled and serve files for dev purpose.
connect       = require 'gulp-connect'

# `gulp-watch` allows streams unlike default gulp.watch only focusing on tasks.
watch         = require 'gulp-watch'

# Triggers a reload of the client upon trigger for files loaded through above connect/liverload enabled dev servers.
livereload    = require 'gulp-livereload'

# Generates documentation from source code comments.
docco         = require 'gulp-docco'

# Generates basic markdown for .md files.
markdown         = require 'gulp-markdown'

# Generates advances md transformation with styling and svg inlining.
docs         = require 'gulp-md-svg-docs'

## Helpers

# Extract the package version from `package.json`
version = JSON.parse( fs.readFileSync( path.join( __dirname, 'package.json' ) ) ).version

## General

# Default phony task (not doing anything for now...).
gulp.task 'default', ->
  gutil.log "GitBook SVG Plugin (v#{ version } (from package.json))..."

## DevOps
#
# > Related tasks to manage the application livecycle

# Deploys on main git repository.
# gulp.task 'deploy', ->
#   run( 'git push heroku master' ).exec()
#   #{git.push 'heroku', 'master', ( error ) ->
#   #{  if error then throw error

## Developments/Documentation related tasks

# Parse Markdown files
# markdown() could do for bare minimum but here we use the fancy `gulp-md-svg-docs`
gulp.task 'md', ( event ) ->
  gulp.src( './README.md' )
  .pipe( docs() )
  .pipe( gulp.dest( './docs' ) )

# Parse Sources files with DOCOO
gulp.task 'docco', ( event ) ->
  gulp.src( [ './*.js', './src/*.js', './*.coffee' ] )
  .pipe( docco() )
  .pipe( gulp.dest( './docs' ) )

# Serve the documentation and refresh automatically uppon changes.
gulp.task 'serve-docs', [ 'docco', 'md' ], ( event ) ->
  connect.server
    root: './docs'
    port: 5002
    fallback: './docs/README.html'
    livereload: true

  # Watch for changes in any source and generates `docco` only for changed files
  watch [ './gulpfile.coffee', './*.js', './src/*.js' ], -> gulp.start 'docco'

  # Watch for changes in basic markdown files
  watch [ './README.md', './docs/*.svg' ], -> gulp.start 'md'

  # sets up a livereload that watches for any changes in the docs
  watch( [ './docs/*.html' ] ).pipe( connect.reload() )
