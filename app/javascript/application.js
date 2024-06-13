// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import * as bootstrap from "bootstrap"
import 'jquery';
import 'jquery_ujs';
import LocalTime from 'local-time';

$(document).on('ready', () => {
  LocalTime.start();
});
