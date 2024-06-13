# Pin npm packages by running ./bin/importmap

# pin 'application'
pin_all_from 'app/javascript'
pin 'jquery'
pin 'jquery_ujs'
pin 'cocoon'
pin 'local-time', to: 'local-time.es2017-esm.js'
pin 'bootstrap', to: 'bootstrap.min.js'
