; INSTRUCTIONS
; modify `core.js`, with any config you'd like
; place it in `src/phoenix/core.cljs` in the repo:
; `https://github.com/jakemcc/cljs-phoenix`
; run `make release` form this repo's top level
; copy the `out/main.js` into `~/.phoenix.js` and reload phoenix.
; `https://github.com/kasper/phoenix`

(ns phoenix.core
  (:require [clojure.string :as string]))

(defn bind [key modifiers callback]
  (js/Key. key (clj->js modifiers) callback))

(defn log [& xs]
  (.log js/Phoenix (string/join " " xs)))

(defn notify [^String message]
  (.notify js/Phoenix message))

(defn log-rectangle [prefix rectangle]
  (log prefix
       "x:" (.-x rectangle)
       "y:" (.-y rectangle)
       "width:" (.-width rectangle)
       "half-width:" (/ (.-width rectangle) 2.0)
       "height:" (.-height rectangle)))

(defn debug []
  (log "debug")
  (log-rectangle "Screen's visible frame" (.flippedVisibleFrame (.screen (.focused js/Window))))
  (log-rectangle "App's frame" (.frame (.focused js/Window))))

(defn dbg [x]
  (log x)
  x)

(defn alert [& xs]
  (let [modal (js/Modal.)
        main-screen-rect (.flippedVisibleFrame (.main js/Screen))]
    (set! (.-origin modal) #js {:x (/ (.-width main-screen-rect) 2)
                                :y (/ (.-height main-screen-rect) 2)})
    (set! (.-message modal) (string/join " " xs))
    (set! (.-duration modal) 2)
    (.show modal)))

(defn app-width-adjustment
  [app screen-width]
  (get-in {"iTerm" {1440 8}
           "Emacs" {1440 -4}}
          [(.name app) screen-width]
          0))

(defn half-screen-width
  [window screen-frame]
  (+ (* 0.5 (.-width screen-frame))
     (app-width-adjustment (.app window) (.-width screen-frame))))

(defn half-screen-height
  [window screen-frame]
  (+ (* 0.5 (.-height screen-frame))
     (app-width-adjustment (.app window) (.-height screen-frame))))


(defn to-left-half []
  (when-let [window (.focused js/Window)]
    (let [screen-frame (.flippedVisibleFrame (.screen window))]
      (.setFrame window #js {:x (.-x screen-frame)
                             :y (.-y screen-frame)
                             :width (half-screen-width window screen-frame)
                             :height (.-height screen-frame)}))))

(defn to-right-half []
  (when-let [window (.focused js/Window)]
    (let [screen-frame (.flippedVisibleFrame (.screen window))]
      (.setFrame window #js {:x (+ (.-x screen-frame) (* 0.5 (.-width screen-frame)))
                             :y (.-y screen-frame)
                             :width (half-screen-width window screen-frame)
                             :height (.-height screen-frame)}))))

(defn to-middle []
  (when-let [window (.focused js/Window)]
    (let [screen-frame (.flippedVisibleFrame (.screen window))]
      (.setFrame window #js {:x (+ (.-x screen-frame) (* 0.25 (.-width screen-frame)))
                             :y (+ (.-y screen-frame) (* 0.25 (.-height screen-frame)))
                             :width (half-screen-width window screen-frame)
                             :height (half-screen-height window screen-frame)}))))

(defn to-fullscreen []
  (when-let [window (.focused js/Window)]
    (.setFrame window (.flippedVisibleFrame (.screen window)))))

(def round js/Math.round)

(defn move-to-screen [window screen]
  (when (and window screen)
    (let [window-frame (.frame window)
          old-screen-rect (.flippedVisibleFrame (.screen window))
          new-screen-rect (.flippedVisibleFrame screen)
          x-ratio (/ (.-width new-screen-rect) (.-width old-screen-rect))
          y-ratio (/ (.-height new-screen-rect) (.-height old-screen-rect))]
      (.setFrame window #js {:width (round (* x-ratio (.-width window-frame)))
                             :height (round (* y-ratio (.-height window-frame)))
                             :x (+ (round (* (- (.-x window-frame) (.-x old-screen-rect))
                                             x-ratio))
                                   (.-x new-screen-rect))
                             :y (+ (round (* (- (.-y window-frame) (.-y old-screen-rect))
                                             y-ratio))
                                   (.-y new-screen-rect))}))))

(defn snap-right []
  (when-let [window (.focused js/Window)]
    (let [visible-frame (.flippedVisibleFrame (.screen window))]
      (.setTopLeft window #js {:x (- (.-width visible-frame) (.-width (.size window)))
                               :y (.-y (.topLeft window))
                               }))))

(defn snap-left []
  (when-let [window (.focused js/Window)]
    (.setTopLeft window #js {:x 0
                             :y (.-y (.topLeft window))
                             })))

(defn snap-top []
  (when-let [window (.focused js/Window)]
      (.setTopLeft window #js {:x (.-x (.topLeft window))
                               :y 0
                               })))

(defn snap-bottom []
  (when-let [window (.focused js/Window)]
    (let [visible-frame (.flippedVisibleFrame (.screen window))]
      (.setTopLeft window #js {:x (.-x (.topLeft window))
                               :y (- (.-height visible-frame) (.-height (.size window)))
                               }))))

(defn move-right []
  (when-let [window (.focused js/Window)]
    (.setTopLeft window #js {:x (+ (.-x (.topLeft window)) 30)
                             :y (.-y (.topLeft window))
                             })
    )
  )

(defn move-left []
  (when-let [window (.focused js/Window)]
    (.setTopLeft window #js {:x (- (.-x (.topLeft window)) 30)
                             :y (.-y (.topLeft window))
                             })
    )
  )

(defn move-down []
  (when-let [window (.focused js/Window)]
    (.setTopLeft window #js {:x (.-x (.topLeft window))
                             :y (+ (.-y (.topLeft window)) 30)
                             })
    )
  )

(defn move-up []
  (when-let [window (.focused js/Window)]
    (.setTopLeft window #js {:x (.-x (.topLeft window))
                             :y (- (.-y (.topLeft window)) 30)
                             })
    )
  )

(defn grow-right []
  (when-let [window (.focused js/Window)]
    (.setFrame window #js {:x (.-x (.frame window))
                           :y (.-y (.frame window))
                           :width (+ 30 (.-width (.frame window)))
                           :height (.-height (.frame window))
                           })
    )
  )

(defn shrink-left []
  (when-let [window (.focused js/Window)]
    (.setFrame window #js {:x (.-x (.frame window))
                           :y (.-y (.frame window))
                           :width (- (.-width (.frame window)) 30)
                           :height (.-height (.frame window))
                           })
    )
  )

(defn grow-down []
  (when-let [window (.focused js/Window)]
    (.setFrame window #js {:x (.-x (.frame window))
                           :y (.-y (.frame window))
                           :width (.-width (.frame window))
                           :height (+ (.-height (.frame window)) 30)
                           })
    )
  )

(defn shrink-up []
  (when-let [window (.focused js/Window)]
    (.setFrame window #js {:x (.-x (.frame window))
                           :y (.-y (.frame window))
                           :width (.-width (.frame window))
                           :height (- (.-height (.frame window)) 30)
                           })
    )
  )

(defn left-one-monitor []
  (when-let [window (.focused js/Window)]
    (when-not (= (.screen window) (.next (.screen window)))
      (move-to-screen window (.next (.screen window))))))

(defn right-one-monitor []
  (when-let [window (.focused js/Window)]
    (when-not (= (.screen window) (.previous (.screen window)))
      (move-to-screen window (.previous (.screen window))))))

(defn left-one-space []
  (when-let [window (.focused js/Window)]
    (when-let [curr-space (.active js/Space)]
      (do
        (.removeWindows curr-space #js [window])
        (.addWindows (.previous curr-space) #js [window])
        (.focus window)
        ))))

(defn right-one-space []
  (when-let [window (.focused js/Window)]
    (when-let [curr-space (.active js/Space)]
      (do
        (.removeWindows curr-space #js [window])
        (.addWindows (.next curr-space) #js [window])
        (.focus window)
        ))))

(defn move-to-space [space-num]
  (if-let [next-space (get (.all js/Space) space-num)]
    (when-let [curr-space (.active js/Space)]
      (when-let [window (.focused js/Window)]
        (do
          (.removeWindows curr-space #js [window])
          (.addWindows next-space #js [window])
          (.focus window)
          )))))

(defn focus-next []
  (when-let [window (.focused js/Window)]
    (when-let [window-list (clj->js (sort-by (fn [w] [(.-y (.frame w)), (.-x (.frame w))])
                                    (filter (fn [w] (not (= (.title w) ""))) (.all js/Window))))]
      (when-let [window-idx (.indexOf (clj->js (map (fn [w] (.isEqual w window)) window-list)) 1)]
          (if-let [next-idx (mod (+ window-idx 1) (count window-list))]
            (.focus (get window-list next-idx)))))))

(defn focus-previous []
  (when-let [window (.focused js/Window)]
    (when-let [window-list (clj->js (sort-by (fn [w] [(.-y (.frame w)), (.-x (.frame w))])
                                    (filter (fn [w] (not (= (.title w) ""))) (.all js/Window))))]
      (when-let [window-idx (.indexOf (clj->js (map (fn [w] (.isEqual w window)) window-list)) 1)]
          (if-let [next-idx (mod (- window-idx 1) (count window-list))]
            (.focus (get window-list next-idx)))))))

(def last-recently-launched-app (atom nil))

;; Idea:
;;   search visible windows first, then do minimized windows
;; Below no longer cycles through all the windows. Previous
;;   implementation focused on every window and stayed on last
;;   focused. Now it just focuses on first one returned.
(defn focus-or-start [title]
  (if-let [app (.get js/App title)]
    (do (.focus app))
    (when-let [app (.launch js/App title)]
      (reset! last-recently-launched-app title)
      (.focus app))))

(def ^:export app-did-launch
  (js/Event. "appDidLaunch" (fn [app]
                              (when (= @last-recently-launched-app (.name app))
                                (.focus app)
                                (reset! last-recently-launched-app nil)))))

; Work in progress
; (defn launch-window [title]
  ; (when-let [app (.launch js/App title)]
    ; this is wrong
    ; (reset! last-recently-launched-app title)
    ; (.focus app)))

;; Per Phoenix docs, need to capture results of
;; Phoenix.bind to GC doesn't clean them up.
(def ^:export bound-keys
  [(bind "h" ["alt" "cmd" "ctrl"] debug)

   ; TODO: make 'release.cls' minify again

   ; Resize and position window macros
   (bind "a" ["alt" "cmd"] to-left-half)
   (bind "d" ["alt" "cmd"] to-right-half)
   (bind "f" ["alt" "cmd"] to-fullscreen)
   (bind "s" ["alt" "cmd"] to-middle)

   ; Move window to <direction> by a bit
   (bind "l" ["alt" "cmd"] move-right)
   (bind "h" ["alt" "cmd"] move-left)
   (bind "j" ["alt" "cmd"] move-down)
   (bind "k" ["alt" "cmd"] move-up)

   ; Snap window to <direction> edge of screen
   (bind "L" ["alt" "cmd" "shift"] snap-right)
   (bind "H" ["alt" "cmd" "shift"] snap-left)
   (bind "J" ["alt" "cmd" "shift"] snap-bottom)
   (bind "K" ["alt" "cmd" "shift"] snap-top)
   
   ; Move window to space to the <direction>
   (bind "h" ["alt" "cmd" "ctrl"] left-one-space)
   (bind "l" ["alt" "cmd" "ctrl"] right-one-space)

   ; Move window to space
   (bind "1" ["alt" "cmd" "ctrl"] (partial move-to-space 0))
   (bind "2" ["alt" "cmd" "ctrl"] (partial move-to-space 1))
   (bind "3" ["alt" "cmd" "ctrl"] (partial move-to-space 2))
   (bind "4" ["alt" "cmd" "ctrl"] (partial move-to-space 3))
   (bind "5" ["alt" "cmd" "ctrl"] (partial move-to-space 4))
   (bind "6" ["alt" "cmd" "ctrl"] (partial move-to-space 5))
   (bind "7" ["alt" "cmd" "ctrl"] (partial move-to-space 6))
   (bind "8" ["alt" "cmd" "ctrl"] (partial move-to-space 7))
   (bind "9" ["alt" "cmd" "ctrl"] (partial move-to-space 8))

   ; TODO: add a way to create/remove spaces
   ; (bind "c" ["alt" "cmd" "ctrl"] create-space)
   ; (bind "x" ["alt" "cmd" "ctrl"] create-space)

   ; TODO: consider adding a way to rotate windows if they're tiled in an
   ; arrangement

   ; TODO: add way to cycle between focused windows (even in diff spaces).
   ; ideally ordered by location
   ; Focus next/previous window
   (bind "j" ["alt" "cmd" "ctrl"] focus-next)
   (bind "k" ["alt" "cmd" "ctrl"] focus-previous)

   ; Grow/Shrink window
   (bind "right" ["alt" "cmd"] grow-right)
   (bind "left" ["alt" "cmd"] shrink-left)
   (bind "down" ["alt" "cmd"] grow-down)
   (bind "up" ["alt" "cmd"] shrink-up)

   ; Move window to monitor in <direction>
   (bind "left" ["alt" "cmd" "ctrl"] left-one-monitor)
   (bind "right" ["alt" "cmd" "ctrl"] right-one-monitor)

   ; Switch focus to app
   (bind "c" ["alt" "cmd"] (partial focus-or-start "iTerm"))
   (bind "x" ["alt" "cmd"] (partial focus-or-start "Google Chrome"))

   ; TODO: add way to create new chrome/terminal window (auto makes it centered)
   ; Create new window of app
   ; (bind "c" ["alt" "cmd" "shift"] (partial launch-window "iTerm"))
   ; (bind "x" ["alt" "cmd" "shift"] (partial launch-window "Google Chrome"))
   ])
