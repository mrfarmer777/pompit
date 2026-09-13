# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-library" # @1.7.0
pin "@stimulus-library/controllers", to: "@stimulus-library--controllers.js" # @1.7.0
pin "@stimulus-library/mixins", to: "@stimulus-library--mixins.js" # @1.7.0
pin "@stimulus-library/utilities", to: "@stimulus-library--utilities.js" # @1.7.0
pin "date-fns/formatDistanceToNow", to: "date-fns--formatDistanceToNow.js" # @4.4.0
pin "date-fns/formatDuration", to: "date-fns--formatDuration.js" # @4.4.0
pin "date-fns/intervalToDuration", to: "date-fns--intervalToDuration.js" # @4.4.0
pin "date-fns/isPast", to: "date-fns--isPast.js" # @4.4.0
pin "date-fns/toDate", to: "date-fns--toDate.js" # @4.4.0
pin "mitt" # @3.0.1
