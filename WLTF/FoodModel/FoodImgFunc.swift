//
//  FoodImgFunc.swift
//  WLTF
//
//  Created by iosdev on 11.4.2022.
//
// This file is for functions that choosing images and color of the specific food

import Foundation

class FoodImgFunc {
    
    class func selectImg(_ input1: String, _ input2: String ) -> String {
        
        if input1.lowercased().contains("soup") || input1.lowercased().contains("keitto") || input1.lowercased().contains("keitot") {
            return "soup"
        }
        if input1.lowercased().contains("noodle") || input1.lowercased().contains("nuudeli") {
            return "noodles"
        }
        if input1.lowercased().contains("kfc") {
            return "kfc"
        }
        if input1.lowercased().contains("cereal") || input1.lowercased().contains("viljaa") || input1.lowercased().contains("viljat") {
            return "cereal-1"
        }
        if input1.lowercased().contains("pie") || input1.lowercased().contains("piirakka") {
            return "pie-1"
        }
        else {
            if input1.lowercased() == "apple" || input1.lowercased() == "omena" {
                return "apple"
            }
            if input1.lowercased() == "apricot" || input1.lowercased() == "aprikoosi" {
                return "apricot"
            }
            if input1.lowercased() == "asparagus" || input1.lowercased() == "parsa" {
                return "asparagus"
            }
            if input1.lowercased() == "avocado" || input1.lowercased() == "avokado" {
                return "avocado"
            }
            if input1.lowercased() == "bacon" || input1.lowercased() == "pekoni" {
                return "bacon"
            }
            if input1.lowercased() == "baguette" || input1.lowercased() == "patonki" || input1.lowercased() == "patonkeja" {
                return "baguette"
            }
            if input1.lowercased() == "banana" || input1.lowercased() == "banaani" {
                return "banana"
            }
            if input1.lowercased() == "basil" || input1.lowercased() == "basilika" {
                return "basil"
            }
            if input1.lowercased() == "bean" || input1.lowercased() == "papu" {
                return "beans-1"
            }
            if input1.lowercased() == "beef" || input1.lowercased() == "naudanlihaa" || input1.lowercased() == "pihvi" {
                return "beef"
            }
            if input1.lowercased() == "beet" || input1.lowercased() == "punajuuri" || input1.lowercased() == "punajuuret" {
                return "beet"
            }
            if input1.lowercased() == "bento" {
                return "bento"
            }
            if input1.lowercased() == "biscuit" || input1.lowercased() == "keksi" || input1.lowercased() == "keksit" {
                return "biscuits"
            }
            if input1.lowercased() == "blueberry" || input1.lowercased() == "mustikka" {
                return "blueberry"
            }
            if input1.lowercased() == "bazil nut" || input1.lowercased() == "parapähkinä" || input1.lowercased() == "parapahkina" {
                return "brazilNut"
            }
            if input1.lowercased() == "brezel" {
                return "brezel"
            }
            if input1.lowercased() == "brigadeiro" {
                return "brigadeiro"
            }
            if input1.lowercased() == "broccoli" || input1.lowercased() == "parsakaali" {
                return "broccoli"
            }
            if input1.lowercased() == "burrito" {
                return "burrito"
            }
            if input1.lowercased() == "cabbage" || input1.lowercased() == "kaali" {
                return "cabbage"
            }
            if input1.lowercased() == "carrot" || input1.lowercased() == "porkkana" {
                return "carrot"
            }
            if input1.lowercased() == "cauliflower" || input1.lowercased() == "kukkakaali" {
                return "cauliflower"
            }
            if input1.lowercased() == "caviar" || input1.lowercased() == "kaviaari" {
                return "caviar"
            }
            if input1.lowercased() == "celery" || input1.lowercased() == "selleri" {
                return "celery"
            }
            if input1.lowercased() == "cereal" || input1.lowercased() == "viljaa" || input1.lowercased() == "viljat" {
                return "cereal-1"
            }
            if input1.lowercased() == "cheese" || input1.lowercased() == "juusto" {
                return "cheese"
            }
            if input1.lowercased() == "cheesecake" || input1.lowercased() == "juustokakku" {
                return "cheesecake"
            }
            if input1.lowercased() == "cherry" || input1.lowercased() == "kirsikka" {
                return "cherry"
            }
            if input1.lowercased() == "chia seed" || input1.lowercased() == "chia siemeniä" || input1.lowercased() == "chia siemenet" {
                return "chiaSeeds"
            }
            if input1.lowercased() == "chicken" || input1.lowercased() == "kana" {
                return "chicken"
            }
            if input1.lowercased() == "chili" {
                return "chili"
            }
            if input1.lowercased() == "chips" || input1.lowercased() == "sirut" || input1.lowercased() == "lastut" {
                return "chips"
            }
            if input1.lowercased() == "chocolate" || input1.lowercased() == "suklaa" {
                return "chocolate"
            }
            if input1.lowercased() == "cinnamon" || input1.lowercased() == "kaneli" || input1.lowercased() == "korvapuusti" {
                return "cinnamonRoll"
            }
            if input1.lowercased() == "citrus" || input1.lowercased() == "sitrushedelmiä" || input1.lowercased() == "sitrushedelmä" {
                return "citrus"
            }
            if input1.lowercased() == "coconut" || input1.lowercased() == "kookos" {
                return "coconut"
            }
            if input1.lowercased() == "coconut milk" || input1.lowercased() == "kookosmaito" {
                return "coconutMilk"
            }
            if input1.lowercased() == "coffee bean" || input1.lowercased() == "kahvipapu" || input1.lowercased() == "kahvipavut" {
                return "coffeeBeans"
            }
            if input1.lowercased() == "coffee capsule" || input1.lowercased() == "kahviapseli" {
                return "coffeeCapsule"
            }
            if input1.lowercased() == "cookies" || input1.lowercased() == "evästeen" || input1.lowercased() == "keksit" {
                return "cookies"
            }
            if input1.lowercased() == "corn" || input1.lowercased() == "maissi" {
                return "corn"
            }
            if input1.lowercased() == "cotton candy" || input1.lowercased() == "hattara" {
                return "cottonCandy"
            }
            if input1.lowercased() == "crab" || input1.lowercased() == "rapu" {
                return "crab"
            }
            if input1.lowercased() == "cream" || input1.lowercased() == "kerma" {
                return "cream"
            }
            if input1.lowercased() == "croissant" {
                return "croissant"
            }
            if input1.lowercased() == "cucumber" || input1.lowercased() == "kurkku" || input1.lowercased() == "kurkut" {
                return "cucumber"
            }
            if input1.lowercased() == "cupcake" || input1.lowercased() == "kuppikakku" {
                return "cupcake"
            }
            if input1.lowercased() == "dimsum" {
                return "dimsum"
            }
            if input1.lowercased() == "doritos" {
                return "doritos"
            }
            if input1.lowercased() == "doughnut" || input1.lowercased() == "donitsi" || input1.lowercased() == "munkkeja" {
                return "doughnuts"
            }
            if input1.lowercased() == "dragon fruit" || input1.lowercased() == "lohikäärmeen hedelmiä" || input1.lowercased() == "lohikaarmeen hedelmia" {
                return "dragonFruit"
            }
            if input1.lowercased() == "drumstick" || input1.lowercased() == "rumpupuikko" || input1.lowercased() == "koivet" {
                return "drumstick"
            }
            if input1.lowercased() == "dumpling" || input1.lowercased() == "kokkare" || input1.lowercased() == "nyytit" {
                return "dumplings"
            }
            if input1.lowercased() == "durian" {
                return "durian"
            }
            if input1.lowercased() == "eggplant" || input1.lowercased() == "munakoiso" {
                return "eggplant"
            }
            if input1.lowercased() == "egg" || input1.lowercased() == "muna" || input1.lowercased() == "keltuainen" {
                return "eggs-5"
            }
            if input1.lowercased() == "fastfood" || input1.lowercased() == "pikaruoka" {
                return "fastfood"
            }
            if input1.lowercased() == "fish" || input1.lowercased() == "kala" {
                return "fish"
            }
            if input1.lowercased() == "fish and chips" {
                return "fishAndChips"
            }
            if input1.lowercased() == "flaxseed" || input1.lowercased() == "pellavansiemen" {
                return "flaxSeeds"
            }
            if input1.lowercased() == "flour" || input1.lowercased() == "jauhot" {
                return "flour"
            }
            if input1.lowercased() == "fried noodles" || input1.lowercased() == "paistettu nuudeli" || input1.lowercased() == "paistettut nuudelit" {
                return "friedNoodles"
            }
            if input1.lowercased() == "fried rice" || input1.lowercased() == "paistettua riisiä" || input1.lowercased() == "paistettut riisiä" {
                return "friedRice"
            }
            if input1.lowercased() == "fries" || input1.lowercased() == "ranskanperunat" || input1.lowercased() == "ranskalaisia perunoita" {
                return "fries"
            }
            if input1.lowercased() == "gralic" || input1.lowercased() == "valkosipuli" {
                return "garlic"
            }
            if input1.lowercased() == "gingerbread" || input1.lowercased() == "ginger bread" || input1.lowercased() == "piparkakku" {
                return "gingerbreadHouse"
            }
            if input1.lowercased() == "ginger" || input1.lowercased() == "inkivääri" {
                return "ginger"
            }
            if input1.lowercased() == "grape" || input1.lowercased() == "rypäleen" || input1.lowercased() == "viinirypäleitä" {
                return "grapes"
            }
            if input1.lowercased() == "guacamole" {
                return "guacamole"
            }
            if input1.lowercased() == "hamburger" || input1.lowercased() == "hampurilainen" {
                return "hamburger"
            }
            if input1.lowercased() == "hazelnut" || input1.lowercased() == "hasselpähkin" || input1.lowercased() == "hasselpahkin" {
                return "hazelnut"
            }
            if input1.lowercased() == "honey" || input1.lowercased() == "hunaja" || input1.lowercased() == "kulta" {
                return "honey"
            }
            if input1.lowercased() == "jamon" {
                return "jamon"
            }
            if input1.lowercased() == "jam" || input1.lowercased() == "hillo" {
                return "jam"
            }
            if input1.lowercased() == "kebab" || input1.lowercased() == "kebabit" {
                return "kebab-1"
            }
            if input1.lowercased() == "ketchup" || input1.lowercased() == "ketsuppi" {
                return "ketchup"
            }
            if input1.lowercased() == "kfc" {
                return "kfc"
            }
            if input1.lowercased() == "kimchi" {
                return "kimchi"
            }
            if input1.lowercased() == "kiwi" || input1.lowercased() == "kiivi" {
                return "kiwi"
            }
            if input1.lowercased() == "kohlrabi" || input1.lowercased() == "kyssäkaali" {
                return "kohlrabi"
            }
            if input1.lowercased() == "lambchop" || input1.lowercased() == "lampaankare" || input1.lowercased() == "lampaankyljyksiä" {
                return "dumplings"
            }
            if input1.lowercased() == "lasagna" || input1.lowercased() == "lasagne" {
                return "lasagna"
            }
            if input1.lowercased() == "leek" || input1.lowercased() == "leem" {
                return "leek"
            }
            if input1.lowercased() == "lettuce" || input1.lowercased() == "lehtisalaatti" || input1.lowercased() == "salaatit" {
                return "lettuce"
            }
            if input1.lowercased() == "lime" {
                return "lime"
            }
            if input1.lowercased() == "lychee" || input1.lowercased() == "litsi" {
                return "lychee"
            }
            if input1.lowercased() == "macaron" {
                return "macaron"
            }
            if input1.lowercased() == "mangosteen" {
                return "mangosteen"
            }
            if input1.lowercased() == "mayonnaise" || input1.lowercased() == "majoneesi" {
                return "mayonnaise"
            }
            if input1.lowercased() == "watermelon" || input1.lowercased() == "vesimeloni" {
                return "watermelon"
            }
            if input1.lowercased() == "melon" || input1.lowercased() == "meloni" {
                return "melon-2"
            }
            if input1.lowercased() == "oat milk" || input1.lowercased() == "kaura maitoa" || input1.lowercased() == "kauramaito" {
                return "oatMilk"
            }
            if input1.lowercased() == "milk" || input1.lowercased() == "maito" {
                return "milk-1"
            }
            if input1.lowercased() == "mushroom" || input1.lowercased() == "sieni" {
                return "mushroom"
            }
            if input1.lowercased() == "mustard" || input1.lowercased() == "sinappi" {
                return "mustard"
            }
            if input1.lowercased() == "naan" {
                return "naan"
            }
            if input1.lowercased() == "nonyakueh" || input1.lowercased() == "nonya kueh" {
                return "nonyaKueh"
            }
            if input1.lowercased() == "noodles" || input1.lowercased() == "nuudeli" {
                return "noodles"
            }
            if input1.lowercased() == "nut" || input1.lowercased() == "mutteri" || input1.lowercased() == "pähkinät" {
                return "nut"
            }
            if input1.lowercased() == "oat" || input1.lowercased() == "kaura" {
                return "oats"
            }
            if input1.lowercased() == "octopus" || input1.lowercased() == "mustekala" {
                return "octopus"
            }
            if input1.lowercased() == "olive oil" || input1.lowercased() == "oliveoil" || input1.lowercased() == "oliiviöljy" {
                return "oliveOil"
            }
            if input1.lowercased() == "olive" || input1.lowercased() == "oliivi" {
                return "olive"
            }
            if input1.lowercased() == "omelet" || input1.lowercased() == "munakas" || input1.lowercased() == "munakka" {
                return "egg"
            }
            if input1.lowercased() == "omelet rice" || input1.lowercased() == "omelettiriisiä" || input1.lowercased() == "omeletti" {
                return "omelette"
            }
            if input1.lowercased() == "onion" || input1.lowercased() == "sipuli" {
                return "onion"
            }
            if input1.lowercased() == "orange" || input1.lowercased() == "oranssi" || input1.lowercased() == "appelsiin" {
                return "orange"
            }
            if input1.lowercased() == "paella" {
                return "paella"
            }
            if input1.lowercased() == "pancake" || input1.lowercased() == "pannukakku" || input1.lowercased() == "pannukakut" {
                return "pancake"
            }
            if input1.lowercased() == "papaya" || input1.lowercased() == "papaija" {
                return "papaya"
            }
            if input1.lowercased() == "paprika" {
                return "paprika"
            }
            if input1.lowercased() == "pasta" {
                return "pasta"
            }
            if input1.lowercased() == "peach" || input1.lowercased() == "persikka" || input1.lowercased() == "persika" {
                return "peach"
            }
            if input1.lowercased() == "peanut" || input1.lowercased() == "maapähkin" || input1.lowercased() == "maapahkin" {
                return "peanuts"
            }
            if input1.lowercased() == "pear" || input1.lowercased() == "päärynä" || input1.lowercased() == "paaryna" {
                return "pear"
            }
            if input1.lowercased() == "pea" || input1.lowercased() == "herne" {
                return "peas"
            }
            if input1.lowercased() == "pecan" || input1.lowercased() == "pekaani" || input1.lowercased() == "nyytit" {
                return "pecan"
            }
            if input1.lowercased() == "pelmen" {
                return "pelmeni"
            }
            if input1.lowercased() == "pepper" || input1.lowercased() == "pippuri" || input1.lowercased() == "paprika" {
                return "pepper"
            }
            if input1.lowercased() == "pineapple" || input1.lowercased() == "ananas" || input1.lowercased() == "ananakset" {
                return "pineapple"
            }
            if input1.lowercased() == "pizza" {
                return "pizza"
            }
            if input1.lowercased() == "plum" || input1.lowercased() == "luumu" {
                return "plum"
            }
            if input1.lowercased() == "pomegranate" || input1.lowercased() == "granaattiomena" || input1.lowercased() == "granaattiomenia" {
                return "pomegranate"
            }
            if input1.lowercased() == "popcorn" {
                return "popcorn"
            }
            if input1.lowercased() == "popsicle" || input1.lowercased() == "mehujää" || input1.lowercased() == "mehujaa" {
                return "popsicle"
            }
            if input1.lowercased() == "porridge" || input1.lowercased() == "puuroa" {
                return "porridge"
            }
            if input1.lowercased() == "potato" || input1.lowercased() == "peruna" {
                return "potato"
            }
            if input1.lowercased() == "prawn" || input1.lowercased() == "katkarapu" || input1.lowercased() == "katkaravut" {
                return "prawn"
            }
            if input1.lowercased() == "pretzel" || input1.lowercased() == "suolarinkilä" {
                return "pretzel"
            }
            if input1.lowercased() == "pumpkin" || input1.lowercased() == "kurpitsa" {
                return "pumpkin"
            }
            if input1.lowercased() == "quesadilla" {
                return "quesadilla"
            }
            if input1.lowercased() == "radish" || input1.lowercased() == "retiisi" {
                return "radish"
            }
            if input1.lowercased() == "rambutan" {
                return "rambutan"
            }
            if input1.lowercased() == "raspberry" || input1.lowercased() == "vadelma" {
                return "raspberry"
            }
            if input1.lowercased() == "rice" || input1.lowercased() == "riisi" {
                return "rice"
            }
            if input1.lowercased() == "roast" || input1.lowercased() == "paisti" || input1.lowercased() == "paahdettu" || input1.lowercased() == "paahtaminen" {
                return "roast"
            }
            if input1.lowercased() == "salad" || input1.lowercased() == "salaatti" || input1.lowercased() == "salaatte" {
                return "salad"
            }
            if input1.lowercased() == "salami" {
                return "salami"
            }
            if input1.lowercased() == "salt" || input1.lowercased() == "suola" {
                return "salt"
            }
            if input1.lowercased() == "sandwich" || input1.lowercased() == "voileipä" || input1.lowercased() == "voileipiä" || input1.lowercased() == "voileipa" {
                return "sandwich-1"
            }
            if input1.lowercased() == "sauce" || input1.lowercased() == "kastike" {
                return "sauce"
            }
            if input1.lowercased() == "sausage" || input1.lowercased() == "makkara" {
                return "sausagaes"
            }
            if input1.lowercased() == "sesame" || input1.lowercased() == "seesami" {
                return "grain-1"
            }
            if input1.lowercased() == "shell" || input1.lowercased() == "kuori" || input1.lowercased() == "kuoret" || input1.lowercased() == "äyriäisiä" {
                return "shell"
            }
            if input1.lowercased() == "skewer" || input1.lowercased() == "vartaa" {
                return "skewer"
            }
            if input1.lowercased() == "soursop" {
                return "soursop"
            }
            if input1.lowercased() == "soy sauce" || input1.lowercased() == "soysauce" || input1.lowercased() == "soijakastike" {
                return "soysauce"
            }
            if input1.lowercased() == "soy bean" || input1.lowercased() == "soybean" || input1.lowercased() == "soija" {
                return "soyBeans"
            }
            if input1.lowercased() == "chili sauce" || input1.lowercased() == "chilisauce" || input1.lowercased() == "spicy" || input1.lowercased() == "chili kastike" {
                return "spicysauce"
            }
            if input1.lowercased() == "squash" || input1.lowercased() == "kurpitsa" {
                return "squash"
            }
            if input1.lowercased() == "steak" {
                return "steak"
            }
            if input1.lowercased() == "strawberry" || input1.lowercased() == "mansikka" {
                return "strawberry"
            }
            if input1.lowercased() == "sugar cube" || input1.lowercased() == "sugarcube" || input1.lowercased() == "sokeripala" {
                return "sugarCube-1"
            }
            if input1.lowercased() == "sugar" || input1.lowercased() == "sokeri" {
                return "sugar-1"
            }
            if input1.lowercased() == "sushi" {
                return "sushi"
            }
            if input1.lowercased() == "sweetener" || input1.lowercased() == "makeutusaine" {
                return "sweetener"
            }
            if input1.lowercased() == "sweetpotato" || input1.lowercased() == "sweet potato" || input1.lowercased() == "bataatti" || input1.lowercased() == "bataatit" {
                return "sweetpotato"
            }
            if input1.lowercased() == "taco" {
                return "taco"
            }
            if input1.lowercased() == "takeaway" || input1.lowercased() == "ottaa mukaan" || input1.lowercased() == "noutoruoka" {
                return "takeaway"
            }
            if input1.lowercased() == "tangelo" {
                return "tangelo"
            }
            if input1.lowercased() == "tiffin" {
                return "tiffin"
            }
            if input1.lowercased() == "toast" || input1.lowercased() == "paahtoleipä" || input1.lowercased() == "paahtoleipa" {
                return "toast"
            }
            if input1.lowercased() == "cake" || input1.lowercased() == "kakku" || input1.lowercased() == "kakut" {
                return "cake"
            }
            if input1.lowercased() == "tomato" || input1.lowercased() == "tomaatti" || input1.lowercased() == "tomaatit" {
                return "tomato"
            }
            if input1.lowercased() == "turkey" || input1.lowercased() == "turkki" || input1.lowercased() == "kalkkuna" {
                return "turkey"
            }
            else {
                if input1.lowercased().contains("apricot") || input1.lowercased().contains("aprikoosi"){
                    return "apricot"
                }
                if input1.lowercased().contains("asparagus") || input1.lowercased().contains("parsa") {
                    return "asparagus"
                }
                if input1.lowercased().contains("avocado") || input1.lowercased().contains("avokado"){
                    return "avocado"
                }
                if input1.lowercased().contains("bacon") || input1.lowercased().contains("pekoni") {
                    return "bacon"
                }
                if input1.lowercased().contains("baguette") || input1.lowercased().contains("patonki") || input1.lowercased().contains("patonkeja") {
                    return "baguette"
                }
                if input1.lowercased().contains("banana") || input1.lowercased().contains("banaani") {
                    return "banana"
                }
                if input1.lowercased().contains("basil") || input1.lowercased().contains("basilika") {
                    return "basil"
                }
                if input1.lowercased().contains("bean") || input1.lowercased().contains("papu") {
                    return "beans-1"
                }
                if input1.lowercased().contains("beef") || input1.lowercased().contains("naudanlihaa") || input1.lowercased().contains("pihvi") {
                    return "beef"
                }
                if input1.lowercased().contains("beet") || input1.lowercased().contains("punajuuri") || input1.lowercased().contains("punajuuret") {
                    return "beet"
                }
                if input1.lowercased().contains("bento") {
                    return "bento"
                }
                if input1.lowercased().contains("biscuit") || input1.lowercased().contains("keksi") || input1.lowercased().contains("keksit") {
                    return "biscuits"
                }
                if input1.lowercased().contains("blueberry") || input1.lowercased().contains("mustikka") {
                    return "blueberry"
                }
                if input1.lowercased().contains("bazil nut") || input1.lowercased().contains("parapähkinä") || input1.lowercased().contains("parapahkina") {
                    return "brazilNut"
                }
                if input1.lowercased().contains("brezel") {
                    return "brezel"
                }
                if input1.lowercased().contains("brigadeiro") {
                    return "brigadeiro"
                }
                if input1.lowercased().contains("broccoli") || input1.lowercased().contains("parsakkali") {
                    return "broccoli"
                }
                if input1.lowercased().contains("burrito") {
                    return "burrito"
                }
                if input1.lowercased().contains("cabbage") || input1.lowercased().contains("kaali") {
                    return "cabbage"
                }
                if input1.lowercased().contains("carrot") || input1.lowercased().contains("porkkana") {
                    return "carrot"
                }
                if input1.lowercased().contains("cauliflower") || input1.lowercased().contains("kukkakaali") {
                    return "cauliflower"
                }
                if input1.lowercased().contains("caviar") || input1.lowercased().contains("kaviaari") {
                    return "caviar"
                }
                if input1.lowercased().contains("celery") || input1.lowercased().contains("selleri") {
                    return "celery"
                }
                if input1.lowercased().contains("cheesecake") || input1.lowercased().contains("juustokakku") {
                    return "cheesecake"
                }
                if input1.lowercased().contains("cherry") || input1.lowercased().contains("kirsikka") {
                    return "cherry"
                }
                if input1.lowercased().contains("chia seed") || input1.lowercased().contains("chia siemeniä") || input1.lowercased().contains("chia siemenet") {
                    return "chiaSeeds"
                }
                if input1.lowercased().contains("chips") || input1.lowercased().contains("sirut") || input1.lowercased().contains("lastut") {
                    return "chips"
                }
                if input1.lowercased().contains("chocolate") || input1.lowercased().contains("suklaa") {
                    return "chocolate"
                }
                if input1.lowercased().contains("cinnamon") || input1.lowercased().contains("kaneli") || input1.lowercased().contains("korvapuusti") {
                    return "cinnamonRoll"
                }
                if input1.lowercased().contains("citrus") || input1.lowercased().contains("sitrushedelmiä") || input1.lowercased().contains("sitrushedelmä") {
                    return "citrus"
                }
                if input1.lowercased().contains("coconut milk") || input1.lowercased().contains("kookosmaito") {
                    return "coconutMilk"
                }
                if input1.lowercased().contains("coconut") || input1.lowercased().contains("kookos") {
                    return "coconut"
                }
                if input1.lowercased().contains("coffee bean") || input1.lowercased().contains("kahvipapu") || input1.lowercased().contains("kahvipavut") {
                    return "coffeeBeans"
                }
                if input1.lowercased().contains("coffee capsule") || input1.lowercased().contains("kahviapseli") {
                    return "coffeeCapsule"
                }
                if input1.lowercased().contains("cookies") || input1.lowercased().contains("evästeen") || input1.lowercased().contains("keksit") {
                    return "cookies"
                }
                if input1.lowercased().contains("corn") || input1.lowercased().contains("maissi") {
                    return "corn"
                }
                if input1.lowercased().contains("cotton candy") || input1.lowercased().contains("hattara") {
                    return "cottonCandy"
                }
                if input1.lowercased().contains("crab") || input1.lowercased().contains("rapu") {
                    return "crab"
                }
                if input1.lowercased().contains("cream") || input1.lowercased().contains("kerma") {
                    return "cream"
                }
                if input1.lowercased().contains("croissant") {
                    return "croissant"
                }
                if input1.lowercased().contains("cucumber") || input1.lowercased().contains("kurkku") || input1.lowercased().contains("kurkut") {
                    return "cucumber"
                }
                if input1.lowercased().contains("cupcake") || input1.lowercased().contains("kuppikakku") {
                    return "cupcake"
                }
                if input1.lowercased().contains("dimsum") {
                    return "dimsum"
                }
                if input1.lowercased().contains("doritos") {
                    return "doritos"
                }
                if input1.lowercased().contains("doughnut") || input1.lowercased().contains("donitsi") || input1.lowercased().contains("munkkeja") {
                    return "doughnuts"
                }
                if input1.lowercased().contains("dragon fruit") || input1.lowercased().contains("lohikäärmeen hedelmiä") || input1.lowercased().contains("lohikaarmeen hedelmia") {
                    return "dragonFruit"
                }
                if input1.lowercased().contains("drumstick") || input1.lowercased().contains("rumpupuikko") || input1.lowercased().contains("koivet") {
                    return "drumstick"
                }
                if input1.lowercased().contains("dumpling") || input1.lowercased().contains("kokkare") || input1.lowercased().contains("nyytit") {
                    return "dumplings"
                }
                if input1.lowercased().contains("durian") {
                    return "durian"
                }
                if input1.lowercased().contains("eggplant") || input1.lowercased().contains("munakoiso") {
                    return "eggplant"
                }
                if input1.lowercased().contains("egg") || input1.lowercased().contains("muna") || input1.lowercased().contains("keltuainen") {
                    return "eggs-5"
                }
                if input1.lowercased().contains("fastfood") || input1.lowercased().contains("pikaruoka") {
                    return "fastfood"
                }
                if input1.lowercased().contains("fish") || input1.lowercased().contains("kala") {
                    return "fish"
                }
                if input1.lowercased().contains("fish and chips") {
                    return "fishAndChips"
                }
                if input1.lowercased().contains("flaxseed") || input1.lowercased().contains("pellavansiemen") {
                    return "flaxSeeds"
                }
                if input1.lowercased().contains("flour") || input1.lowercased().contains("jauhot") {
                    return "flour"
                }
                if input1.lowercased().contains("fried noodles") || input1.lowercased().contains("paistettu nuudeli") || input1.lowercased().contains("paistettut nuudelit") {
                    return "friedNoodles"
                }
                if input1.lowercased().contains("fried rice") || input1.lowercased().contains("paistettua riisiä") || input1.lowercased().contains("paistettut riisiä") {
                    return "friedRice"
                }
                if input1.lowercased().contains("fries") || input1.lowercased().contains("ranskanperunat") || input1.lowercased().contains("ranskalaisia perunoita") {
                    return "fries"
                }
                if input1.lowercased().contains("gralic") || input1.lowercased().contains("valkosipuli") {
                    return "garlic"
                }
                if input1.lowercased().contains("gingerbread") || input1.lowercased().contains("ginger bread") || input1.lowercased().contains("piparkakku") {
                    return "gingerbreadHouse"
                }
                if input1.lowercased().contains("ginger") || input1.lowercased().contains("inkivääri") {
                    return "ginger"
                }
                if input1.lowercased().contains("grape") || input1.lowercased().contains("rypäleen") || input1.lowercased().contains("viinirypäleitä") {
                    return "grapes"
                }
                if input1.lowercased().contains("guacamole") {
                    return "guacamole"
                }
                if input1.lowercased().contains("burger") || input1.lowercased().contains("hampurilainen") || input1.lowercased().contains("hampurilai") {
                    return "hamburger"
                }
                if input1.lowercased().contains("hazelnut") || input1.lowercased().contains("hasselpähkin") || input1.lowercased().contains("hasselpahkin") {
                    return "hazelnut"
                }
                if input1.lowercased().contains("honey") || input1.lowercased().contains("hunaja") || input1.lowercased().contains("kulta") {
                    return "honey"
                }
                if input1.lowercased().contains("jamon") {
                    return "jamon"
                }
                if input1.lowercased().contains("jam") || input1.lowercased().contains("hillo") {
                    return "jam"
                }
                if input1.lowercased().contains("kebab") || input1.lowercased().contains("kebabit") {
                    return "kebab-1"
                }
                if input1.lowercased().contains("ketchup") || input1.lowercased().contains("ketsuppi") {
                    return "ketchup"
                }
                if input1.lowercased().contains("kimchi") {
                    return "kimchi"
                }
                if input1.lowercased().contains("kiwi") || input1.lowercased().contains("kiivi") {
                    return "kiwi"
                }
                if input1.lowercased().contains("kohlrabi") || input1.lowercased().contains("kyssäkaali") {
                    return "kohlrabi"
                }
                if input1.lowercased().contains("lambchop") || input1.lowercased().contains("lampaankare") || input1.lowercased().contains("lampaankyljyksiä") {
                    return "dumplings"
                }
                if input1.lowercased().contains("lasagna") || input1.lowercased().contains("lasagne") {
                    return "lasagna"
                }
                if input1.lowercased().contains("leek") || input1.lowercased().contains("leem") {
                    return "leek"
                }
                if input1.lowercased().contains("lettuce") || input1.lowercased().contains("lehtisalaatti") || input1.lowercased().contains("salaatit") {
                    return "lettuce"
                }
                if input1.lowercased().contains("lime") {
                    return "lime"
                }
                if input1.lowercased().contains("lychee") || input1.lowercased().contains("litsi") {
                    return "lychee"
                }
                if input1.lowercased().contains("macaron") {
                    return "macaron"
                }
                if input1.lowercased().contains("mangosteen") {
                    return "mangosteen"
                }
                if input1.lowercased().contains("mayonnaise") || input1.lowercased().contains("majoneesi") {
                    return "mayonnaise"
                }
                if input1.lowercased().contains("watermelon") || input1.lowercased().contains("vesimeloni") {
                    return "watermelon"
                }
                if input1.lowercased().contains("melon") || input1.lowercased().contains("meloni") {
                    return "melon-2"
                }
                if input1.lowercased().contains("oat milk") || input1.lowercased().contains("kaura maitoa") || input1.lowercased().contains("kauramaito") {
                    return "oatMilk"
                }
                if input1.lowercased().contains("milk") || input1.lowercased().contains("maito") {
                    return "milk-1"
                }
                if input1.lowercased().contains("mushroom") || input1.lowercased().contains("sieni") {
                    return "mushroom"
                }
                if input1.lowercased().contains("mustard") || input1.lowercased().contains("sinappi") {
                    return "mustard"
                }
                if input1.lowercased().contains("naan") {
                    return "naan"
                }
                if input1.lowercased().contains("nonyakueh") || input1.lowercased().contains("nonya kueh") {
                    return "nonyaKueh"
                }
                if input1.lowercased().contains("noodles") || input1.lowercased().contains("nuudeli") {
                    return "noodles"
                }
                if input1.lowercased().contains("nut") || input1.lowercased().contains("mutteri") || input1.lowercased().contains("pähkinät") {
                    return "nut"
                }
                if input1.lowercased().contains("oat") || input1.lowercased().contains("kaura") {
                    return "oats"
                }
                if input1.lowercased().contains("octopus") || input1.lowercased().contains("mustekala") {
                    return "octopus"
                }
                if input1.lowercased().contains("olive oil") || input1.lowercased().contains("oliveoil") || input1.lowercased().contains("oliiviöljy") {
                    return "oliveOil"
                }
                if input1.lowercased().contains("olive") || input1.lowercased().contains("oliivi") {
                    return "olive"
                }
                if input1.lowercased().contains("omelet") || input1.lowercased().contains("munakas") || input1.lowercased().contains("munakka") {
                    return "egg"
                }
                if input1.lowercased().contains("omelet rice") || input1.lowercased().contains("omelettiriisiä") || input1.lowercased().contains("omeletti") {
                    return "omelette"
                }
                if input1.lowercased().contains("onion") || input1.lowercased().contains("sipuli") {
                    return "onion"
                }
                if input1.lowercased().contains("orange") || input1.lowercased().contains("oranssi") || input1.lowercased().contains("appelsiin") {
                    return "orange"
                }
                if input1.lowercased().contains("paella") {
                    return "paella"
                }
                if input1.lowercased().contains("pancake") || input1.lowercased().contains("pannukakku") || input1.lowercased().contains("pannukakut") {
                    return "pancake"
                }
                if input1.lowercased().contains("papaya") || input1.lowercased().contains("papaija") {
                    return "papaya"
                }
                if input1.lowercased().contains("paprika") {
                    return "paprika"
                }
                if input1.lowercased().contains("pasta") {
                    return "pasta"
                }
                if input1.lowercased().contains("peach") || input1.lowercased().contains("persikka") || input1.lowercased().contains("persika") {
                    return "peach"
                }
                if input1.lowercased().contains("peanut") || input1.lowercased().contains("maapähkin") || input1.lowercased().contains("maapahkin") {
                    return "peanuts"
                }
                if input1.lowercased().contains("pear") || input1.lowercased().contains("päärynä") || input1.lowercased().contains("paaryna") {
                    return "pear"
                }
                if input1.lowercased().contains("pea") || input1.lowercased().contains("herne") {
                    return "peas"
                }
                if input1.lowercased().contains("pecan") || input1.lowercased().contains("pekaani") || input1.lowercased().contains("nyytit") {
                    return "pecan"
                }
                if input1.lowercased().contains("pelmen") {
                    return "pelmeni"
                }
                if input1.lowercased().contains("pepper") || input1.lowercased().contains("pippuri") || input1.lowercased().contains("paprika") {
                    return "pepper"
                }
                if input1.lowercased().contains("pineapple") || input1.lowercased().contains("ananas") || input1.lowercased().contains("ananakset") {
                    return "pineapple"
                }
                if input1.lowercased().contains("apple") || input1.lowercased().contains("omena"){
                    return "apple"
                }
                if input1.lowercased().contains("pizza") {
                    return "pizza"
                }
                if input1.lowercased().contains("plum") || input1.lowercased().contains("luumu") {
                    return "plum"
                }
                if input1.lowercased().contains("pomegranate") || input1.lowercased().contains("granaattiomena") || input1.lowercased().contains("granaattiomenia") {
                    return "pomegranate"
                }
                if input1.lowercased().contains("popcorn") {
                    return "popcorn"
                }
                if input1.lowercased().contains("popsicle") || input1.lowercased().contains("mehujää") || input1.lowercased().contains("mehujaa") {
                    return "popsicle"
                }
                if input1.lowercased().contains("porridge") || input1.lowercased().contains("puuroa") {
                    return "porridge"
                }
                if input1.lowercased().contains("potato") || input1.lowercased().contains("peruna") {
                    return "potato"
                }
                if input1.lowercased().contains("prawn") || input1.lowercased().contains("katkarapu") || input1.lowercased().contains("katkaravut") {
                    return "prawn"
                }
                if input1.lowercased().contains("pretzel") || input1.lowercased().contains("suolarinkilä") {
                    return "pretzel"
                }
                if input1.lowercased().contains("pumpkin") || input1.lowercased().contains("kurpitsa") {
                    return "pumpkin"
                }
                if input1.lowercased().contains("quesadilla") {
                    return "quesadilla"
                }
                if input1.lowercased().contains("radish") || input1.lowercased().contains("retiisi") {
                    return "radish"
                }
                if input1.lowercased().contains("rambutan") {
                    return "rambutan"
                }
                if input1.lowercased().contains("raspberry") || input1.lowercased().contains("vadelma") {
                    return "raspberry"
                }
                if input1.lowercased().contains("rice") || input1.lowercased().contains("riisi") {
                    return "rice"
                }
                if input1.lowercased().contains("roast") || input1.lowercased().contains("paisti") || input1.lowercased().contains("paahdettu") || input1.lowercased().contains("paahtaminen") {
                    return "roast"
                }
                if input1.lowercased().contains("salad") || input1.lowercased().contains("salaatti") || input1.lowercased().contains("salaatte") {
                    return "salad"
                }
                if input1.lowercased().contains("salami") {
                    return "salami"
                }
                if input1.lowercased().contains("salt") || input1.lowercased().contains("suola") {
                    return "salt"
                }
                if input1.lowercased().contains("sandwich") || input1.lowercased().contains("voileipä") || input1.lowercased().contains("voileipiä") || input1.lowercased().contains("voileipa") {
                    return "sandwich-1"
                }
                if input1.lowercased().contains("sauce") || input1.lowercased().contains("kastike") {
                    return "sauce"
                }
                if input1.lowercased().contains("sausage") || input1.lowercased().contains("makkara") {
                    return "sausagaes"
                }
                if input1.lowercased().contains("sesame") || input1.lowercased().contains("seesami") {
                    return "grain-1"
                }
                if input1.lowercased().contains("shell") || input1.lowercased().contains("kuori") || input1.lowercased().contains("kuoret") || input1.lowercased().contains("äyriäisiä") {
                    return "shell"
                }
                if input1.lowercased().contains("skewer") || input1.lowercased().contains("vartaa") {
                    return "skewer"
                }
                if input1.lowercased().contains("soursop") {
                    return "soursop"
                }
                if input1.lowercased().contains("soy sauce") || input1.lowercased().contains("soysauce") || input1.lowercased().contains("soijakastike") {
                    return "soysauce"
                }
                if input1.lowercased().contains("soy bean") || input1.lowercased().contains("soybean") || input1.lowercased().contains("soija") {
                    return "soyBeans"
                }
                if input1.lowercased().contains("chili sauce") || input1.lowercased().contains("chilisauce") || input1.lowercased().contains("spicy") || input1.lowercased().contains("chili kastike") {
                    return "spicysauce"
                }
                if input1.lowercased().contains("squash") || input1.lowercased().contains("kurpitsa") {
                    return "squash"
                }
                if input1.lowercased().contains("steak") {
                    return "steak"
                }
                if input1.lowercased().contains("strawberry") || input1.lowercased().contains("mansikka") {
                    return "strawberry"
                }
                if input1.lowercased().contains("sugar cube") || input1.lowercased().contains("sugarcube") || input1.lowercased().contains("sokeripala") {
                    return "sugarCube-1"
                }
                if input1.lowercased().contains("sugar") || input1.lowercased().contains("sokeri") {
                    return "sugar-1"
                }
                if input1.lowercased().contains("sushi") {
                    return "sushi"
                }
                if input1.lowercased().contains("sweetener") || input1.lowercased().contains("makeutusaine") {
                    return "sweetener"
                }
                if input1.lowercased().contains("sweetpotato") || input1.lowercased().contains("sweet potato") || input1.lowercased().contains("bataatti") || input1.lowercased().contains("bataatit") {
                    return "sweetpotato"
                }
                if input1.lowercased().contains("taco") {
                    return "taco"
                }
                if input1.lowercased().contains("takeaway") || input1.lowercased().contains("ottaa mukaan") || input1.lowercased().contains("noutoruoka") {
                    return "takeaway"
                }
                if input1.lowercased().contains("tangelo") {
                    return "tangelo"
                }
                if input1.lowercased().contains("tiffin") {
                    return "tiffin"
                }
                if input1.lowercased().contains("toast") || input1.lowercased().contains("paahtoleipä") || input1.lowercased().contains("paahtoleipa") {
                    return "toast"
                }
                if input1.lowercased().contains("cake") || input1.lowercased().contains("kakku") || input1.lowercased().contains("kakut") {
                    return "cake"
                }
                if input1.lowercased().contains("tomato") || input1.lowercased().contains("tomaatti") || input1.lowercased().contains("tomaatit") {
                    return "tomato"
                }
                if input1.lowercased().contains("turkey") || input1.lowercased().contains("turkki") || input1.lowercased().contains("kalkkuna") {
                    return "turkey"
                }
                if input1.lowercased().contains("chicken") || input1.lowercased().contains("kana") {
                    return "chicken"
                }
                if input1.lowercased().contains("chili") {
                    return "chili"
                }
                if input1.lowercased().contains("cheese") || input1.lowercased().contains("juusto") {
                    return "cheese"
                }
                else {
                    if input2.lowercased() == "alcohol" {
                        return "foodAndWine"
                    }
                    if input2.lowercased() == "bread" {
                        return "bakery-1"
                    }
                    if input2.lowercased() == "cooked" {
                        return "dinner"
                    }
                    if input2.lowercased() == "dairy" {
                        return "dairy"
                    }
                    if input2.lowercased() == "dessert" {
                        return "dessert"
                    }
                    if input2.lowercased() == "drinks" {
                        return "softDrink"
                    }
                    if input2.lowercased() == "fruit" {
                        return "fruit"
                    }
                    if input2.lowercased() == "grain" {
                        return "grain"
                    }
                    if input2.lowercased() == "meat" {
                        return "meat"
                    }
                    if input2.lowercased() == "protein" {
                        return "beans"
                    }
                    if input2.lowercased() == "seasoning" {
                        return "seasoning"
                    }
                    if input2.lowercased() == "seafood" {
                        return "seafood-1"
                    }
                    if input2.lowercased() == "vegetables" {
                        return "veg-2"
                    }
                    if input2.lowercased() == "snacks" {
                        return "fastfood"
                    }
                    else {
                        return "others-1"
                    }
                }
            }
        }
        
    }
    
    class func selectColor(_ input: Date) -> String {
        if (calcExpiryColor(date: input) == "3days") {
            return "3daysItem"
        } else if (calcExpiryColor(date: input) == "1day") {
            return "1dayItem"
        } else if (calcExpiryColor(date: input) == "expired") {
            return "ExpiredItem"
        } else {
            return "NormalItem"
        }
    }
}
