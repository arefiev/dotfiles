;; Based on I don't remember what, tested on Dvorak keyboard.

(require 'quail)

(quail-define-package
 "runic-elder-futhark" "Runic (Elder Futhark)" "ᛒᚢᛏᛏᛖᚱ" nil
 "Elder Futhark — used by Germanic dialects of the 2nd to 8th centuries"
 nil t t t t nil nil nil nil nil t)

;;  1! 2" 3' 4; 5 6: 7? 8 9( 0) [{ ]} `~
;;   '  ,  .  ᛈ  ᛖ  ᚠ  ᚷ  ᚲ  ᚱ  ᛚ  /? =+
;;    ᚨ  ᛟ  ᛖ  ᚢ  ᛁ  ᛞ  ᚻ  ᛏ  ᚾ ᛋᛊ  -
;;     ;  ᛜᛝ  ᛃ  ᚲ  ᛋᛊ ᛒ  ᛗ  ᚹ  ᚦ  ᛉ

(quail-define-rules
 ("1" ?1)
 ("2" ?2)
 ("3" ?3)
 ("4" ?4)
 ("5" ?5)
 ("6" ?6)
 ("7" ?7)
 ("8" ?8)
 ("9" ?9)
 ("0" ?0)
 ("[" ?[)
 ("]" ?])
 ("`" ?`)
 ("'" ?')
 ("," ?,)
 ("." ?.)
 ("p" ?ᛈ)
 ("y" ?ᛇ)
 ("f" ?ᚠ)
 ("g" ?ᚷ)
 ("c" ?ᚲ)    ;; Redundant.
 ("r" ?ᚱ)
 ("l" ?ᛚ)
 ("/" ?/)
 ("=" ?=)
 ("a" ?ᚨ)
 ("o" ?ᛟ)
 ("e" ?ᛖ)
 ("u" ?ᚢ)
 ("i" ?ᛁ)
 ("d" ?ᛞ)
 ("h" ?ᚺ)
 ("t" ?ᛏ)
 ("n" ?ᚾ)
 ("s" ?ᛋ)
 ("-" ?-)
 ("\\" ?\\)
 (";" ?\;)
 ("q" ?ᛜ)   ;; Ingwaz, [ñ]
 ("j" ?ᛃ)
 ("k" ?ᚲ)
 ("X" ?ᛋ)   ;; Redunant.
 ("b" ?ᛒ)
 ("m" ?ᛗ)
 ("w" ?ᚹ)
 ("v" ?ᚦ)  ;; Thorn [th]
 ("z" ?ᛉ)
 
 ("!" ?!)
 ("@" ?\")
 ("#" ?')
 ("$" ?\;)
 ("%" ?%)
 ("^" ?:)
 ("&" ??)
 ("*" ?*)
 ("(" ?()
 (")" ?))
 ("{" ?{)
 ("}" ?})
 ("~" ?~)
 ("\"" ?\")
 ("<" ?<)
 (">" ?>)
 ("P" ?ᛈ)
 ("Y" ?ᛇ)
 ("F" ?ᚠ)
 ("G" ?ᚷ)
 ("C" ?ᚲ)    ;; Redundant.
 ("R" ?ᚱ)
 ("L" ?ᛚ)
 ("?" ??)
 ("+" ?+)
 ("A" ?ᚨ)
 ("O" ?ᛟ)
 ("E" ?ᛖ)
 ("U" ?ᚢ)
 ("I" ?ᛁ)
 ("D" ?ᛞ)
 ("H" ?ᚻ)
 ("T" ?ᛏ)
 ("N" ?ᚾ)
 ("S" ?ᛊ)   ;; Sieg Sigel!
 ("_" ?_)
 ("|" ?|)
 (":" ?:)
 ("Q" ?ᛝ)   ;; Ingwaz, [ñ]
 ("J" ?ᛃ)
 ("K" ?ᚲ)
 ("X" ?ᛊ)   ;; Redunant.
 ("B" ?ᛒ)
 ("M" ?ᛗ)
 ("W" ?ᚹ)
 ("V" ?ᚦ)  ;; Thorn [th]
 ("Z" ?ᛉ))


;;;;; (From Wikipedia):
;; Rune 	UCS 	Transliteration 	IPA 	Proto-Germanic name 	Meaning
;; a 	ᚨ 	a 	/a(ː)/ 	*ansuz 	"one of the Æsir (gods)"
;; b 	ᛒ 	b 	/b/ 	*berkanan 	"birch"
;; d 	ᛞ 	d 	/d/ 	*dagaz 	"day"
;; e 	ᛖ 	e 	/e(ː)/ 	*ehwaz 	"horse"
;; f 	ᚠ 	f 	/f/ 	*fehu 	"wealth, cattle"
;; g 	ᚷ 	g 	/g/ 	*gebō 	"gift"
;; h h 	ᚺ ᚻ 	h 	/h/ 	*hagalaz 	"hail" (the precipitation)
;; i 	ᛁ 	i 	/i(ː)/ 	*īsaz 	"ice"
;; j 	ᛃ 	j 	/j/ 	*jēra- 	"year, good year, harvest"
;; k 	ᚲ 	k 	/k/ 	?*kaunan 	"ulcer"? (or *kenaz "torch"?)
;; l 	ᛚ 	l 	/l/ 	*laguz 	"water, lake" (or possibly *laukaz "leek")
;; m 	ᛗ 	m 	/m/ 	*mannaz 	"Man"
;; n 	ᚾ 	n 	/n/ 	*naudiz 	"need"
;; o 	ᛟ 	o 	/o(ː)/ 	*ōþila-/*ōþala- 	"heritage, estate, possession"
;; p 	ᛈ 	p 	/p/ 	?*perþ- 	meaning unclear, perhaps "pear-tree".
;; r 	ᚱ 	r 	/r/ 	*raidō 	"ride, journey"
;; s s 	ᛊ 	s 	/s/ 	*sōwilō 	"Sun"
;; t 	ᛏ 	t 	/t/ 	*tīwaz/*teiwaz 	"the god Tiwaz"
;; th,þ 	ᚦ 	þ 	/θ/, /ð/ 	?*þurisaz 	"giant"
;; u 	ᚢ 	u 	/u(ː)/ 	?*ūruz 	"aurochs" (or *ûram "water/slag"?)
;; w 	ᚹ 	w 	/w/ 	*wunjō 	"joy"
;; z 	ᛉ 	z 	/z/ 	?*algiz 	unclear, possibly "elk".
;; ï,ei 	ᛇ       ae    	/æː/(?) 	*ī(h)waz/*ei(h)waz 	"yew-tree"
;; ŋ ŋ ŋ 	ᛜ ᛝ 	ŋ 	/ŋ/ 	*ingwaz 	"the god Ingwaz"   ← ñ, ng, singing
;;
;; http://en.wikipedia.org/wiki/Elder_Futhark
;;
