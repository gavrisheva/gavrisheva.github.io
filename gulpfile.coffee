'use strict'

gulp = require 'gulp'
pug = require 'gulp-pug'
prefix = require 'gulp-autoprefixer'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
bs = require 'browser-sync'
svgSymbols = require 'gulp-svg-symbols'
rename = require 'gulp-rename'
path = require 'path'
gulpif = require 'gulp-if'

paths =
  pages: './src/pages/*.pug'
  styles: './src/styles/styles.sass'
  images: './src/images/**/*.{png,jpg,jpeg,gif}'
  files: './src/files/**/*.{doc,docx,ppt,pptx}'
  fonts: './src/fonts/**/*.{ttf,eot,woff,woff2,svg,otf}'
  scripts: './src/scripts/**/*.coffee'
  dist:
    pages: './'
    styles: './styles/'
    images: './images/'
    files: './files/'
    fonts: './fonts/'
    scripts: './scripts/'

gulp.task 'pug', ->
  gulp.src paths.pages
    .pipe pug pretty: true
    .pipe gulp.dest paths.dist.pages
    .pipe bs.stream()

gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe sass()
    .pipe gulp.dest paths.dist.styles
    .pipe bs.stream()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe gulp.dest paths.dist.images
    .pipe bs.stream()

gulp.task 'files', ->
  gulp.src paths.files
    .pipe gulp.dest paths.dist.files
    .pipe bs.stream()

gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe gulp.dest paths.dist.fonts
    .pipe bs.stream()

gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe coffee()
    .pipe gulp.dest paths.dist.scripts
    .pipe bs.stream()

gulp.task 'build', ['pug', 'styles', 'images', 'scripts', 'fonts', 'files']

gulp.task 'watch', ->
  bs.init server: './'
  gulp.watch paths.pages, ['pug']
  gulp.watch [paths.styles, './src/styles/**/*.sass'], ['styles']
  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.images, ['images']
  gulp.watch paths.files, ['files']
  gulp.watch paths.fonts, ['fonts']

gulp.task 'default', ['watch', 'build']
