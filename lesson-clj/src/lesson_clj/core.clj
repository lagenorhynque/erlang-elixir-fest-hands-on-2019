(ns lesson-clj.core)

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(defn myfunc []
  "Hello, world!")

(defn sleep_rand [n]
  (let [sleep-time (inc (rand-int n))]
    (Thread/sleep sleep-time)
    (println (str sleep-time "ミリ秒sleepしました"))
    sleep-time))

(defn execute-sequentially [n]
  (println (str "=== 開始: " n "回rand_sleepを繰り返す ==="))
  (let [result (doall (map (fn [_] (sleep_rand 1000))
                           (range 1 (inc n))))]
    (println (str "=== 終了: " n "回rand_sleepを繰り返す ==="))
    result))

(defn execute-concurrently [n]
  (println (str "=== 開始: " n "回rand_sleepを繰り返す ==="))
  (let [result (->> (range 1 (inc n))
                    (map (fn [_] (future (sleep_rand 1000))))
                    (map deref)
                    doall)]
    (println (str "=== 終了: " n "回rand_sleepを繰り返す ==="))
    result))
