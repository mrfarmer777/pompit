# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-library" # @1.7.0
pin "date-fns" # @4.4.0
pin "date-fns/isPast", to: "https://unpkg.com/date-fns@latest/isPast.js"
pin "date-fns/formatDuration", to: "https://unpkg.com/date-fns@latest/formatDuration.js"
pin "date-fns/formatDistanceToNow", to: "https://unpkg.com/date-fns@latest/formatDistanceToNow.js"
pin "date-fns/toDate", to: "https://unpkg.com/date-fns@latest/toDate.js"
pin "date-fns/intervalToDuration", to: "https://unpkg.com/date-fns@latest/intervalToDuration.js"
pin "mitt", to: "https://unpkg.com/mitt@latest/dist/mitt.mjs"
pin "@stimulus-library/utilities", to: "https://unpkg.com/@stimulus-library/utilities@latest/dist/index.js"
pin "@stimulus-library/mixins", to: "https://unpkg.com/@stimulus-library/mixins@latest/dist/index.js"
pin "@stimulus-library/controllers", to: "https://unpkg.com/@stimulus-library/controllers@latest/dist/index.js"
pin "stimulus-library", to: "https://unpkg.com/stimulus-library@latest/dist/index.js"
pin "mitt" # @3.0.1
