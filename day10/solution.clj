(require '[clojure.string :as str])

(def data (str/split (slurp "data.in") #"\n"))


(defn display [acc n] 
    (if (empty? acc)
        (println "EOF")
        (do (println (format "%d %s" n (first acc)))
            (display (rest acc) (+ n 1)))))

(defn update? [n]
    (= (mod (- n 20) 40) 0))

(defn nop [xs acc cycle reg cont]
    (if (update? cycle)
        (cont   (rest xs)
                (+ acc (* cycle reg))
                (+ cycle 1)
                reg)
        (cont   (rest xs)
                acc
                (+ cycle 1)
                reg)))

(defn addx [v xs acc cycle reg cont]
    (if (update? cycle) ; update in first cycle
        (cont   (rest xs)
                (+ acc (* cycle reg))
                (+ cycle 2)
                (+ reg v))
        (if (update? (+ cycle 1)) ; update in second cycle
            (cont   (rest xs)
                    (+ acc (* (+ cycle 1) reg))
                    (+ cycle 2)
                    (+ reg v))
            (cont   (rest xs)
                    acc
                    (+ cycle 2)
                    (+ reg v)))))

(defn id [x] x)

(defn part1 [xs acc cycle reg]
    (do (id (format "%d %d %d %s" acc cycle reg (first xs)))
    (if (empty? xs)
        acc
        (let [line (str/split (first xs) #" ")]
            (if (empty? (rest line))
                (nop xs acc cycle reg part1)
                (addx (#(Integer/parseInt %) (second line)) xs acc cycle reg part1))))))


(defn add-pixel [acc cycle reg]
    (let [cariet (mod (- cycle 1) 40)]
        (if (or (= cariet reg)
                (= (+ cariet 1) reg)
                (= (- cariet 1) reg))
            (cons "#" acc)
            (cons "." acc))))

(defn part2 [xs acc cycle reg]
    (do (println (format "%d %d %s" cycle reg (first xs)))
    (if (empty? xs)
        acc
        (let [line (str/split (first xs) #" ")]
            (if (empty? (rest line))
                (part2  (rest xs)
                        (add-pixel acc cycle reg)
                        (+ cycle 1)
                        reg)
                (part2  (rest xs)
                        (add-pixel 
                            (add-pixel acc cycle reg) 
                            (+ cycle 1) reg)
                        (+ cycle 2)
                        (+ (#(Integer/parseInt %) (second line)) reg)))))))

(println (part1 data 0 1 1))

(defn crt [acc n]
    (if (> n 39)
        (do (println " ")
            (crt acc 0))
        (if (empty? acc)
            2137
            (do (print (first acc))
                (crt (rest acc) (+ n 1))))))

(crt (reverse (part2 data '() 1 1)) 0)        


