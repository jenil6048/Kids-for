-- Database Sync SQL script
-- Auto-generated on 2026-06-26T18:52:26.656Z

BEGIN;

-- ==========================================
-- 1. Create Birds Table, Index, and Permissions
-- ==========================================

CREATE TABLE IF NOT EXISTS public.birds (
  id bigint generated always as identity not null,
  topic_key text not null,
  category_id bigint null,
  name jsonb not null default '{}'::jsonb,
  svg_path text null,
  image_path text null,
  lottie_path text null,
  narration jsonb not null default '{}'::jsonb,
  explanation jsonb not null default '{}'::jsonb,
  fact jsonb not null default '{}'::jsonb,
  game_type text null,
  is_free boolean not null default true,
  display_order integer null,

  CONSTRAINT birds_pkey PRIMARY KEY (id),
  CONSTRAINT birds_topic_key_key UNIQUE (topic_key),
  CONSTRAINT birds_category_id_fkey
    FOREIGN KEY (category_id)
    REFERENCES categories (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_birds_topic_key
ON public.birds(topic_key);

ALTER TABLE public.birds DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.birds TO anon;
GRANT ALL ON public.birds TO authenticated;
GRANT ALL ON public.birds TO service_role;

-- ==========================================
-- 2. Create Vegetables Table, Index, and Permissions
-- ==========================================

CREATE TABLE IF NOT EXISTS public.vegetables (
  id bigint generated always as identity not null,
  topic_key text not null,
  category_id bigint null,
  name jsonb not null default '{}'::jsonb,
  svg_path text null,
  image_path text null,
  lottie_path text null,
  narration jsonb not null default '{}'::jsonb,
  explanation jsonb not null default '{}'::jsonb,
  fact jsonb not null default '{}'::jsonb,
  game_type text null,
  is_free boolean not null default true,
  display_order integer null,

  CONSTRAINT vegetables_pkey PRIMARY KEY (id),
  CONSTRAINT vegetables_topic_key_key UNIQUE (topic_key),
  CONSTRAINT vegetables_category_id_fkey
    FOREIGN KEY (category_id)
    REFERENCES categories (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_vegetables_topic_key
ON public.vegetables(topic_key);

ALTER TABLE public.vegetables DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.vegetables TO anon;
GRANT ALL ON public.vegetables TO authenticated;
GRANT ALL ON public.vegetables TO service_role;

-- ==========================================
-- 3. Create Fruits Table, Index, and Permissions
-- ==========================================

CREATE TABLE IF NOT EXISTS public.fruits (
  id bigint generated always as identity not null,
  topic_key text not null,
  category_id bigint null,
  name jsonb not null default '{}'::jsonb,
  svg_path text null,
  image_path text null,
  lottie_path text null,
  narration jsonb not null default '{}'::jsonb,
  explanation jsonb not null default '{}'::jsonb,
  fact jsonb not null default '{}'::jsonb,
  game_type text null,
  is_free boolean not null default true,
  display_order integer null,

  CONSTRAINT fruits_pkey PRIMARY KEY (id),
  CONSTRAINT fruits_topic_key_key UNIQUE (topic_key),
  CONSTRAINT fruits_category_id_fkey
    FOREIGN KEY (category_id)
    REFERENCES categories (id)
    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_fruits_topic_key
ON public.fruits(topic_key);

ALTER TABLE public.fruits DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.fruits TO anon;
GRANT ALL ON public.fruits TO authenticated;
GRANT ALL ON public.fruits TO service_role;

-- ------------------------------------------
-- Seed data for birds
-- ------------------------------------------
INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'budgie',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Budgie","gu":"બજરીગર","hi":"बजरीगर"}'::jsonb,
  NULL,
  '/assets/images/birds/budgie.png',
  NULL,
  '{"en":"Budgie! Budgies are small, colorful parrots that love to chirp and sing.","gu":"બજરીગર! બજરીગર નાના અને રંગબેરંગી પોપટ છે જેમને કલરવ કરવો અને ગાવું ગમે છે.","hi":"बजरीगर! बजरीगर छोटे और रंग-बिरंगे तोते होते हैं जिन्हें चहकना और गाना बहुत पसंद होता है।"}'::jsonb,
  '{"en":"Budgies are very friendly and playful pets. They are smart and can even learn to mimic human words!","gu":"બજરીગર ખૂબ જ મૈત્રીપૂર્ણ અને રમતિયાળ પાલતુ પક્ષી છે. તેઓ હોશિયાર છે અને માણસોના શબ્દોની નકલ કરવાનું પણ શીખી શકે છે!","hi":"बजरीगर बहुत ही मिलनसार और चंचल पालतू पक्षी होते हैं। वे बुद्धिमान होते हैं और इंसानों की आवाज़ की नकल करना भी सीख सकते हैं!"}'::jsonb,
  '{"en":"Did you know? Budgies can move each eye independently, which helps them see in two directions at once!","gu":"શું તમે જાણો છો? બજરીગર પોતાની બંને આંખોને અલગ-અલગ દિશામાં ફેરવી શકે છે, જેથી તેઓ એકસાથે બંને બાજુ જોઈ શકે છે!","hi":"क्या आपको पता है? बजरीगर अपनी दोनों आँखों को अलग-अलग दिशा में घुमा सकते हैं, जिससे वे एक ही समय में दो दिशाओं में देख सकते हैं!"}'::jsonb,
  'memory',
  true,
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'penguin',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Penguin","gu":"પેંગ્વિન","hi":"पेंगुइन"}'::jsonb,
  NULL,
  '/assets/images/birds/penguin.png',
  NULL,
  '{"en":"Penguin! Penguins are cute black and white birds that love the cold ice.","gu":"પેંગ્વિન! પેંગ્વિન સુંદર કાળા અને સફેદ પક્ષીઓ છે જેમને બરફીલી ઠંડી ગમે છે.","hi":"पेंगुइन! पेंगुइन प्यारे काले और सफेद रंग के पक्षी होते हैं जिन्हें बर्फीली ठंड पसंद होती है।"}'::jsonb,
  '{"en":"Penguins cannot fly in the air, but they are amazing swimmers! They use their wings like flippers to fly through the water.","gu":"પેંગ્વિન હવામાં ઉડી શકતા નથી, પણ તેઓ અદ્ભુત તરણવીર છે! તેઓ પાણીમાં તરવા માટે પોતાની પાંખોનો ફ્લિપર્સની જેમ ઉપયોગ કરે છે.","hi":"पेंगुइन हवा में उड़ नहीं सकते, लेकिन वे बहुत अच्छे तैराक होते हैं! वे पानी में तैरने के लिए अपने पंखों का उपयोग चप्पू की तरह करते हैं।"}'::jsonb,
  '{"en":"Did you know? Penguins walk with a cute waddle, and they slide on their bellies across the snow to travel fast!","gu":"શું તમે જાણો છો? પેંગ્વિન લચકતા પગલે મજેદાર ચાલે ચાલે છે, અને ઝડપથી જવા માટે બરફ પર પેટ ઘસીને લપસે છે!","hi":"क्या आपको पता है? पेंगुइन बहुत प्यारी मटकती हुई चाल चलते हैं, और तेजी से आगे बढ़ने के लिए बर्फ पर पेट के बल फिसलते हैं!"}'::jsonb,
  'memory',
  true,
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'duck',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Duck","gu":"બતક","hi":"बत्तख"}'::jsonb,
  NULL,
  '/assets/images/birds/duck.png',
  NULL,
  '{"en":"Duck! Ducks are friendly water birds that love to make a ''quack quack'' sound.","gu":"બતક! બતક એ પાણીના પ્રેમાળ પક્ષી છે જેમને ''ક્વેક ક્વેક'' અવાજ કરવો ગમે છે.","hi":"बत्तख! बत्तख पानी में रहने वाले प्यारे पक्षी हैं जिन्हें ''क्वेक क्वेक'' की आवाज़ निकालना पसंद होता है।"}'::jsonb,
  '{"en":"Ducks have webbed feet that act like paddles to help them swim smoothly in ponds, lakes, and rivers.","gu":"બતકને જાળીદાર પગ હોય છે જે પેડલ જેવું કામ કરે છે અને તેમને તળાવ, સરોવર કે નદીમાં સરળતાથી તરવામાં મદદ કરે છે.","hi":"बत्तखों के पैर जालीदार होते हैं जो चप्पू की तरह काम करते हैं और उन्हें तालाबों और नदियों में आसानी से तैरने में मदद करते हैं।"}'::jsonb,
  '{"en":"Did you know? Duck feathers are waterproof! They have a special oil that keeps them completely dry even when swimming.","gu":"શું તમે જાણો છો? બતકના પીંછા વોટરપ્રૂફ હોય છે! તેમની પાસે એક ખાસ તેલ હોય છે જે તેમને પાણીમાં તરતી વખતે પણ સૂકા રાખે છે.","hi":"क्या आपको पता है? बत्तख के पंख वॉटरप्रूफ होते हैं! उनके पास एक विशेष तेल होता है जो उन्हें पानी में तैरते समय भी पूरी तरह सूखा रखता है।"}'::jsonb,
  'memory',
  true,
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hummingbird',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Hummingbird","gu":"હમિંગબર્ડ","hi":"हमिंगबर्ड"}'::jsonb,
  NULL,
  '/assets/images/birds/hummingbird.png',
  NULL,
  '{"en":"Hummingbird! Hummingbirds are tiny, colorful birds that hover like little helicopters.","gu":"હમિંગબર્ડ! હમિંગબર્ડ નાના અને રંગબેરંગી પક્ષી છે જે હેલિકોપ્ટરની જેમ હવામાં એક જગ્યાએ સ્થિર રહી શકે છે.","hi":"हमिंगबर्ड! हमिंगबर्ड बहुत छोटे और रंग-बिरंगे पक्षी होते हैं जो छोटे हेलीकॉप्टर की तरह हवा में मंडरा सकते हैं।"}'::jsonb,
  '{"en":"Hummingbirds fly very fast and drink sweet nectar from colorful flowers using their long, straw-like beaks.","gu":"હમિંગબર્ડ ખૂબ જ ઝડપથી ઉડે છે અને તેમની લાંબી, નળી જેવી ચાંચથી રંગબેરંગી ફૂલોમાંથી મીઠો રસ પીએ છે.","hi":"हमिंगबर्ड बहुत तेज़ी से उड़ते हैं और अपनी लंबी, नली जैसी चोंच से रंग-बिरंगे फूलों का मीठा रस पीते हैं।"}'::jsonb,
  '{"en":"Did you know? Hummingbirds are the only birds that can fly backwards and even upside down!","gu":"શું તમે જાણો છો? હમિંગબર્ડ એકમાત્ર એવા પક્ષીઓ છે જે પાછળની તરફ અને ઉંધા પણ ઉડી શકે છે!","hi":"क्या आपको पता है? हमिंगबर्ड एकमात्र ऐसे पक्षी हैं जो पीछे की तरफ और उल्टे भी उड़ सकते हैं!"}'::jsonb,
  'memory',
  true,
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'owl',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Owl","gu":"ઘુવડ","hi":"उल्लू"}'::jsonb,
  NULL,
  '/assets/images/birds/owl.png',
  NULL,
  '{"en":"Owl! Owls are wise night birds with big round eyes and soft feathers.","gu":"ઘુવડ! ઘુવડ એ મોટી ગોળ આંખો અને નરમ પીંછા ધરાવતું રાત્રિનું બુદ્ધિશાળી પક્ષી છે.","hi":"उल्लू! उल्लू बड़ी गोल आँखों और नरम पंखों वाले रात के बुद्धिमान पक्षी होते हैं।"}'::jsonb,
  '{"en":"Owls are active at night. They have amazing hearing and can fly completely silently to catch their food.","gu":"ઘુવડ રાત્રે સક્રિય હોય છે. તેમની સાંભળવાની શક્તિ અદ્ભુત હોય છે અને પોતાનો ખોરાક પકડવા માટે તેઓ બિલકુલ અવાજ કર્યા વગર ઉડી શકે છે.","hi":"उल्लू रात में सक्रिय होते हैं। उनके सुनने की क्षमता बहुत कमाल की होती है और वे अपना शिकार पकड़ने के लिए बिल्कुल शांति से उड़ सकते हैं।"}'::jsonb,
  '{"en":"Did you know? Owls cannot roll their eyes, but they can turn their heads almost all the way around!","gu":"શું તમે જાણો છો? ઘુવડ પોતાની આંખો ફેરવી શકતા નથી, પરંતુ તેઓ પોતાનું માથું આખું પાછળની તરફ ફેરવી શકે છે!","hi":"क्या आपको पता है? उल्लू अपनी आँखें घुमा नहीं सकते, लेकिन वे अपनी गर्दन को लगभग पूरा पीछे तक घुमा सकते हैं!"}'::jsonb,
  'memory',
  true,
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'oriole',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Oriole","gu":"પીલક","hi":"पीलक"}'::jsonb,
  NULL,
  '/assets/images/birds/oriole.png',
  NULL,
  '{"en":"Oriole! Orioles are beautiful songbirds with bright orange and black feathers.","gu":"પીલક! પીલક એ તેજસ્વી નારંગી અને કાળા પીંછાવાળું સુંદર ગાયક પક્ષી છે.","hi":"पीलक! पीलक चमकीले नारंगी और काले पंखों वाले सुंदर गायक पक्षी होते हैं।"}'::jsonb,
  '{"en":"Orioles love to eat sweet fruits and nectar. They build unique nests that hang down from tree branches like woven bags.","gu":"પીલકને મીઠા ફળો અને ફૂલોનો રસ પીવો ખૂબ ગમે છે. તેઓ ઝાડની ડાળીઓ પરથી લટકતા ગૂંથેલા થેલા જેવા અનોખા માળા બનાવે છે.","hi":"पीलक को मीठे फल और फूलों का रस पसंद होता है। वे पेड़ों की डालियों से लटकते हुए थैले जैसे अनोखे घोंसले बुनते हैं।"}'::jsonb,
  '{"en":"Did you know? Orioles are very fond of oranges! People often hang orange slices in gardens to welcome them.","gu":"શું તમે જાણો છો? પીલકને નારંગી બહુ ભાવે છે! લોકો ઘણીવાર બગીચામાં નારંગીના ટુકડા લટકાવે છે જેથી તેઓ ત્યાં આવે.","hi":"क्या आपको पता है? पीलक को संतरे बहुत पसंद होते हैं! लोग अक्सर उन्हें बगीचे में बुलाने के लिए संतरे के टुकड़े लटकाते हैं।"}'::jsonb,
  'memory',
  true,
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'parrot',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Parrot","gu":"પોપટ","hi":"तोता"}'::jsonb,
  NULL,
  '/assets/images/birds/parrot.png',
  NULL,
  '{"en":"Parrot! Parrots are smart, colorful birds that live in warm rainforests.","gu":"પોપટ! પોપટ એ ગરમ વર્ષા જંગલોમાં રહેતા બુદ્ધિશાળી અને રંગબેરંગી પક્ષીઓ છે.","hi":"तोता! तोते गर्म वर्षावनों में रहने वाले बुद्धिमान और रंग-बिरंगे पक्षी होते हैं।"}'::jsonb,
  '{"en":"Parrots have strong curved beaks to crack open tough nuts and seeds. They use their feet like hands to hold their food.","gu":"પોપટ પાસે કઠણ બદામ અને બીજ તોડવા માટે મજબૂત વળાંકવાળી ચાંચ હોય છે. તેઓ ખોરાક પકડવા માટે પોતાના પગનો હાથની જેમ ઉપયોગ કરે છે.","hi":"तोतों के पास सख्त अखरोट और बीज तोड़ने के लिए मजबूत मुड़ी हुई चोंच होती है। वे भोजन पकड़ने के लिए अपने पैरों का उपयोग हाथों की तरह करते हैं।"}'::jsonb,
  '{"en":"Did you know? Parrots are famous for mimicking sounds and can learn to talk just like humans!","gu":"શું તમે જાણો છો? પોપટ અવાજની નકલ કરવા માટે પ્રખ્યાત છે અને તેઓ માણસોની જેમ બોલતા શીખી શકે છે!","hi":"क्या आपको पता है? तोते आवाज़ों की नकल करने के लिए प्रसिद्ध हैं और वे इंसानों की तरह बात करना सीख सकते हैं!"}'::jsonb,
  'memory',
  true,
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rooster',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Rooster","gu":"કૂકડો","hi":"मुर्गा"}'::jsonb,
  NULL,
  '/assets/images/birds/rooster.png',
  NULL,
  '{"en":"Rooster! Roosters are proud farm birds with a bright red crown on their head.","gu":"કૂકડો! કૂકડો એ માથા પર લાલ કલગી ધરાવતું ખેતરનું ગર્વથી ચાલતું પક્ષી છે.","hi":"मुर्गा! मुर्गे सिर पर लाल कलगी वाले खेत के गर्व से चलने वाले पक्षी होते हैं।"}'::jsonb,
  '{"en":"Roosters are male chickens. They help protect their family of hens and chicks and search for tasty grains and bugs.","gu":"કૂકડા નર ચિકન હોય છે. તેઓ મરઘીઓ અને બચ્ચાઓના પોતાના પરિવારનું રક્ષણ કરે છે અને ખાવા માટે અનાજ અને જીવજંતુઓ શોધે છે.","hi":"मुर्गे नर चिकन होते हैं। वे मुर्गियों और बच्चों के अपने परिवार की रक्षा करते हैं और खाने के लिए अनाज और कीड़े खोजते हैं।"}'::jsonb,
  '{"en":"Did you know? Roosters crow loudly in the morning to tell everyone that a new day has started!","gu":"શું તમે જાણો છો? કૂકડો સવારે મોટેથી બાંગ પોકારે છે (કૂકડે-કૂક કરે છે) જેથી બધાને ખબર પડે કે નવો દિવસ શરૂ થઈ ગયો છે!","hi":"क्या आपको पता है? मुर्गे सुबह-सुबह ज़ोर से बांग देते हैं ताकि सबको पता चल सके कि नया दिन शुरू हो गया है!"}'::jsonb,
  'memory',
  true,
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'woodpecker',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Woodpecker","gu":"લક્કડખોદ","hi":"कठफोड़वा"}'::jsonb,
  NULL,
  '/assets/images/birds/woodpecker.png',
  NULL,
  '{"en":"Woodpecker! Woodpeckers are busy birds that tap-tap-tap on tree trunks.","gu":"લક્કડખોદ! લક્કડખોદ એ ઝાડના થડ પર ટક-ટક-ટક કરતું એક વ્યસ્ત પક્ષી છે.","hi":"कठफोड़वा! कठफोड़वा पेड़ों के तनों पर टक-टक-टक करने वाले व्यस्त पक्षी होते हैं।"}'::jsonb,
  '{"en":"Woodpeckers peck at tree bark with their sharp, strong beaks to find tasty bugs to eat and make cozy nest holes.","gu":"લક્કડખોદ પોતાની તીક્ષ્ણ અને મજબૂત ચાંચથી ઝાડની છાલમાં કાણાં પાડે છે જેથી અંદર છુપાયેલા જીવજંતુઓ ખાઈ શકે અને રહેવા માટે માળો બનાવી શકે.","hi":"कठफोड़वा खाने के लिए कीड़े खोजने और रहने के लिए घोंसला बनाने के लिए अपनी तेज़ चोंच से पेड़ के तने में छेद करते हैं।"}'::jsonb,
  '{"en":"Did you know? Woodpeckers have a super long, sticky tongue that helps them reach bugs deep inside tree holes!","gu":"શું તમે જાણો છો? લક્કડખોદ પાસે લાંબી અને ચીકણી જીભ હોય છે જે ઝાડના કાણાંમાંથી જીવજંતુઓ ખેંચી લાવવામાં મદદ કરે છે!","hi":"क्या आपको पता है? कठफोड़वा के पास एक बहुत लंबी और चिपचिपी जीभ होती है जो पेड़ के छेदों से कीड़े बाहर निकालने में मदद करती है!"}'::jsonb,
  'memory',
  true,
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'puffin',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Puffin","gu":"પફિન","hi":"पफिन"}'::jsonb,
  NULL,
  '/assets/images/birds/puffin.png',
  NULL,
  '{"en":"Puffin! Puffins are cute sea birds with colorful, parrot-like beaks.","gu":"પફિન! પફિન એ રંગબેરંગી અને પોપટ જેવી ચાંચ ધરાવતું સુંદર સમુદ્રી પક્ષી છે.","hi":"पफिन! पफिन रंग-बिरंगी और तोते जैसी चोंच वाले प्यारे समुद्री पक्षी होते हैं।"}'::jsonb,
  '{"en":"Puffins live on rocky sea cliffs and spend most of their lives in the water. They are excellent swimmers and divers.","gu":"પફિન પથ્થરવાળા દરિયા કિનારે રહે છે અને પોતાનું મોટાભાગનું જીવન પાણીમાં વિતાવે છે. તેઓ ઉત્તમ તરણવીર અને ડાઇવર્સ છે.","hi":"पफिन चट्टानी समुद्री तटों पर रहते हैं और अपना अधिकांश जीवन पानी में बिताते हैं। वे उत्कृष्ट तैराक और गोताखोर होते हैं।"}'::jsonb,
  '{"en":"Did you know? Puffins can carry up to 10 or more small fish in their beak at the same time to feed their babies!","gu":"શું તમે જાણો છો? પફિન પોતાના બચ્ચાઓને ખવડાવવા માટે પોતાની ચાંચમાં એકસાથે ૧૦ કે તેથી વધુ નાની માછલીઓ પકડી શકે છે!","hi":"क्या आपको पता है? पफिन अपने बच्चों को खिलाने के लिए अपनी चोंच में एक साथ 10 या उससे अधिक छोटी मछलियाँ पकड़ सकते हैं!"}'::jsonb,
  'memory',
  true,
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ostrich',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Ostrich","gu":"શાહમૃગ","hi":"शुतुरमुर्ग"}'::jsonb,
  NULL,
  '/assets/images/birds/ostrich.png',
  NULL,
  '{"en":"Ostrich! The ostrich is the biggest and heaviest bird in the world.","gu":"શાહમૃગ! શાહમૃગ એ દેશનું સૌથી મોટું અને સૌથી ભારે પક્ષી છે.","hi":"शुतुरमुर्ग! शुतुरमुर्ग दुनिया का सबसे बड़ा और सबसे भारी पक्षी है।"}'::jsonb,
  '{"en":"Ostriches cannot fly because they are too heavy, but they have super strong legs and can run faster than any other bird!","gu":"શાહમૃગ ખૂબ ભારે હોવાથી ઉડી શકતા નથી, પરંતુ તેમની પાસે અત્યંત મજબૂત પગ હોય છે અને તેઓ અન્ય તમામ પક્ષીઓ કરતાં વધુ ઝડપથી દોડી શકે છે!","hi":"शुतुरमुर्ग भारी होने के कारण उड़ नहीं सकते, लेकिन उनके पैर बहुत मजबूत होते हैं और वे किसी भी अन्य पक्षी से तेज़ दौड़ सकते हैं!"}'::jsonb,
  '{"en":"Did you know? An ostrich has the biggest eyes of any land animal—their eyes are even bigger than their brain!","gu":"શું તમે જાણો છો? શાહમૃગની આંખો જમીન પરના કોઈપણ પ્રાણી કરતાં સૌથી મોટી હોય છે - તેમની આંખો તેમના મગજ કરતાં પણ મોટી હોય છે!","hi":"क्या आपको पता है? शुतुरमुर्ग की आँखें ज़मीन पर रहने वाले किसी भी जीव से बड़ी होती हैं—उनकी आँखें उनके दिमाग से भी बड़ी होती हैं!"}'::jsonb,
  'memory',
  true,
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'flamingo',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Flamingo","gu":"સુરખાબ","hi":"राजहंस"}'::jsonb,
  NULL,
  '/assets/images/birds/flamingo.png',
  NULL,
  '{"en":"Flamingo! Flamingos are beautiful pink birds with long, slender legs and necks.","gu":"સુરખાબ! સુરખાબ (ફ્લેમિંગો) લાંબી ગરદન અને પાતળા પગ ધરાવતા સુંદર ગુલાબી પક્ષીઓ છે.","hi":"राजहंस! राजहंस लंबी गर्दन और पतले पैरों वाले सुंदर गुलाबी रंग के पक्षी होते हैं।"}'::jsonb,
  '{"en":"Flamingos live near shallow water. They get their bright pink color from the tiny shrimp and algae they eat!","gu":"સુરખાબ છીછરા પાણીની નજીક રહે છે. તેઓ જે નાના ઝીંગા અને શેવાળ ખાય છે તેના લીધે તેમનો રંગ તેજસ્વી ગુલાબી બને છે!","hi":"राजहंस उथले पानी के पास रहते हैं। वे जो छोटे झींगे और शैवाल खाते हैं, उसी से उनका रंग चमकीला गुलाबी हो जाता है!"}'::jsonb,
  '{"en":"Did you know? Flamingos often sleep or rest standing on just one leg to stay warm and save energy!","gu":"શું તમે જાણો છો? સુરખાબ ગરમી બચાવવા અને ઉર્જા બચાવવા માટે ઘણીવાર માત્ર એક પગ પર ઊભા રહીને આરામ કરે છે કે સૂઈ જાય છે!","hi":"क्या आपको पता है? राजहंस गर्मी और ऊर्जा बचाने के लिए अक्सर केवल एक पैर पर खड़े होकर सोते या आराम करते हैं!"}'::jsonb,
  'memory',
  true,
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'heron',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Heron","gu":"બગલો","hi":"बगुला"}'::jsonb,
  NULL,
  '/assets/images/birds/heron.png',
  NULL,
  '{"en":"Heron! Herons are patient wading birds with long legs and sharp beaks.","gu":"બગલો! બગલો એ લાંબા પગ અને તીક્ષ્ણ ચાંચ ધરાવતું ધીરજવાન પાણીનું પક્ષી છે.","hi":"बगुला! बगुला लंबे पैरों और नुकीली चोंच वाले धैर्यवान पानी के पक्षी होते हैं।"}'::jsonb,
  '{"en":"Herons stand very still in shallow water, waiting patiently for a fish to swim by before quickly catching it with their beak.","gu":"બગલા છીછરા પાણીમાં એકદમ શાંત ઊભા રહે છે, અને માછલી નજીક આવે તેની ધીરજપૂર્વક રાહ જોયા પછી ઝડપથી ચાંચથી પકડી લે છે.","hi":"बगुले उथले पानी में बिल्कुल शांत खड़े रहते हैं, और मछली के पास आने का इंतज़ार करते हैं और फिर तेज़ी से अपनी चोंच से पकड़ लेते हैं।"}'::jsonb,
  '{"en":"Did you know? When flying, herons pull their necks back into an ''S'' shape, unlike cranes who keep them straight!","gu":"શું તમે જાણો છો? ઉડતી વખતે બગલા પોતાની ગરદન પાછળ ખેંચીને ''S'' આકાર બનાવે છે, જ્યારે ક્રેન પોતાની ગરદન સીધી રાખે છે!","hi":"क्या आपको पता है? उड़ते समय बगुले अपनी गर्दन को पीछे खींचकर ''S'' आकार बना लेते हैं, जबकि सारस इसे सीधा रखते हैं।"}'::jsonb,
  'memory',
  true,
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'toucan',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Toucan","gu":"ટુકન","hi":"टूकन"}'::jsonb,
  NULL,
  '/assets/images/birds/toucan.png',
  NULL,
  '{"en":"Toucan! Toucans are exotic rainforest birds with huge, colorful beaks.","gu":"ટુકન! ટુકન એ વિશાળ અને રંગબેરંગી ચાંચ ધરાવતું વર્ષા જંગલોનું એક અનોખું પક્ષી છે.","hi":"टूकन! टूकन विशाल और रंग-बिरंगी चोंच वाले वर्षावनों के अनोखे पक्षी होते हैं।"}'::jsonb,
  '{"en":"Toucans use their big beaks to reach tasty fruits on high tree branches that are too weak to support their weight.","gu":"ટુકન પોતાની મોટી ચાંચનો ઉપયોગ ઊંચા ઝાડની નબળી ડાળીઓ પર ફળો તોડવા માટે કરે છે જે ડાળીઓ તેમનું વજન સહન કરી શકતી નથી.","hi":"टूकन अपनी बड़ी चोंच का उपयोग ऊंचे पेड़ों की कमज़ोर डालियों पर लगे फल खाने के लिए करते हैं जो उनका वजन नहीं उठा सकतीं।"}'::jsonb,
  '{"en":"Did you know? Despite being so large, a toucan''s beak is actually very lightweight because it is hollow like a sponge!","gu":"શું તમે જાણો છો? ટુકનની ચાંચ આટલી મોટી હોવા છતાં વાસ્તવમાં ઘણી હલકી હોય છે, કારણ કે તે અંદરથી સ્પોન્જ જેવી પોચી અને ખાલી હોય છે!","hi":"क्या आपको पता है? इतनी बड़ी होने के बावजूद, टूकन की चोंच वास्तव में बहुत हल्की होती है क्योंकि यह अंदर से स्पंज जैसी होती है!"}'::jsonb,
  'memory',
  true,
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'goose',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Goose","gu":"જંગલી હંસ","hi":"कलहंस"}'::jsonb,
  NULL,
  '/assets/images/birds/goose.png',
  NULL,
  '{"en":"Goose! Geese are large water birds that love to honk loudly.","gu":"હંસ! હંસ મોટા પાણીના પક્ષીઓ છે જેમને મોટેથી અવાજ (હોંક) કરવો ગમે છે.","hi":"कलहंस! कलहंस पानी में रहने वाले बड़े पक्षी होते हैं जो ज़ोर से आवाज़ करते हैं।"}'::jsonb,
  '{"en":"Geese spend time on land and water, eating grass and grains. They travel together in big groups called flocks.","gu":"હંસ જમીન અને પાણી બંને જગ્યાએ સમય વિતાવે છે, ઘાસ અને અનાજ ખાય છે. તેઓ ટોળામાં સાથે પ્રવાસ કરે છે.","hi":"कलहंस ज़मीन और पानी दोनों जगह समय बिताते हैं, घास और अनाज खाते हैं। वे बड़े झुंडों में एक साथ यात्रा करते हैं।"}'::jsonb,
  '{"en":"Did you know? Geese fly in a perfect ''V'' shape in the sky, which helps them save energy by riding the wind!","gu":"શું તમે જાણો છો? હંસ આકાશમાં અંગ્રેજી ''V'' આકારમાં ઉડે છે, જેથી તેઓ પવનના પ્રવાહની મદદથી પોતાની ઉર્જા બચાવી શકે છે!","hi":"क्या आपको पता है? कलहंस आकाश में अंग्रेजी ''V'' आकार में उड़ते हैं, जिससे वे हवा के सहारे अपनी ऊर्जा बचा पाते हैं!"}'::jsonb,
  'memory',
  true,
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'blue_jay',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Blue Jay","gu":"બ્લુ જે","hi":"ब्लू जे"}'::jsonb,
  NULL,
  '/assets/images/birds/blue_jay.png',
  NULL,
  '{"en":"Blue Jay! Blue Jays are beautiful, noisy birds with bright blue and white feathers.","gu":"બ્લુ જે! બ્લુ જે એ તેજસ્વી વાદળી અને સફેદ પીંછા ધરાવતું સુંદર અને કલરવ કરતું પક્ષી છે.","hi":"ब्लू जे! ब्लू जे चमकीले नीले और सफेद पंखों वाले सुंदर और चहकने वाले पक्षी होते हैं।"}'::jsonb,
  '{"en":"Blue Jays are very smart and energetic. They live in forests and gardens, eating seeds, nuts, and acorns.","gu":"બ્લુ જે ખૂબ જ બુદ્ધિશાળી અને ઉત્સાહી હોય છે. તેઓ જંગલો અને બગીચાઓમાં રહે છે, અને બીજ, બદામ તથા એકોર્ન ખાય છે.","hi":"ब्लू जे बहुत बुद्धिमान और फुर्तीले होते हैं। वे जंगलों और बगीचों में रहते हैं और बीज, अखरोट तथा फल खाते हैं।"}'::jsonb,
  '{"en":"Did you know? Blue Jays are excellent mimic artists! They can imitate the calls of hawks to warn other birds of danger.","gu":"શું તમે જાણો છો? બ્લુ જે નકલ કરવામાં હોશિયાર હોય છે! તેઓ બીજા પક્ષીઓને ચેતવવા માટે બાજ પક્ષીના અવાજની નકલ કરી શકે છે!","hi":"क्या आपको पता है? ब्लू जे नकल करने में बहुत माहिर होते हैं! वे अन्य पक्षियों को सचेत करने के लिए बाज की आवाज़ निकाल सकते हैं।"}'::jsonb,
  'memory',
  true,
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'swan',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Swan","gu":"રાજહંસ","hi":"हंस"}'::jsonb,
  NULL,
  '/assets/images/birds/swan.png',
  NULL,
  '{"en":"Swan! Swans are graceful white water birds with long, elegant necks.","gu":"રાજહંસ! રાજહંસ લાંબી અને સુંદર ગરદન ધરાવતા અત્યંત નમ્ર સફેદ જળપક્ષી છે.","hi":"हंस! हंस लंबी और सुंदर गर्दन वाले बहुत ही शांत और सुंदर सफेद जलपक्षी होते हैं।"}'::jsonb,
  '{"en":"Swans glide smoothly across lakes and ponds. They are very loyal and choose a partner for their whole life.","gu":"રાજહંસ તળાવ અને સરોવરોમાં ખૂબ જ સરળતાથી તરે છે. તેઓ વફાદાર હોય છે અને જીવનભર એક જ સાથી સાથે રહે છે.","hi":"हंस झीलों और तालाबों में बहुत ही शांति से तैरते हैं। वे बहुत वफादार होते हैं और जीवन भर एक ही साथी के साथ रहते हैं।"}'::jsonb,
  '{"en":"Did you know? Baby swans are called cygnets and are born with soft grey feathers before turning white!","gu":"શું તમે જાણો છો? રાજહંસના બચ્ચાં શરૂઆતમાં નરમ રાખોડી પીંછાવાળા હોય છે, જે પછીથી મોટા થતાં સફેદ રંગના બને છે!","hi":"क्या आपको पता है? हंस के बच्चों को ''सिगनेट'' कहा जाता है और वे जन्म के समय मटमैले रंग के होते हैं, जो बाद में सफेद हो जाते हैं!"}'::jsonb,
  'memory',
  true,
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cardinal',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Cardinal","gu":"લાલ ચકલી","hi":"कार्डिनल"}'::jsonb,
  NULL,
  '/assets/images/birds/cardinal.png',
  NULL,
  '{"en":"Cardinal! Cardinals are eye-catching birds with bright red feathers and a pointy crest.","gu":"કાર્ડિનલ! કાર્ડિનલ એ તેજસ્વી લાલ પીંછા અને માથા પર અણીદાર કલગી ધરાવતું આકર્ષક પક્ષી છે.","hi":"कार्डिनल! कार्डिनल चमकीले लाल पंखों और सिर पर नुकीली कलगी वाले आकर्षक पक्षी होते हैं।"}'::jsonb,
  '{"en":"Cardinals love to sing cheer-up songs. They do not migrate in winter, so their bright red color stands out beautifully against white snow.","gu":"કાર્ડિનલને મધુર ગીતો ગાવા ગમે છે. તેઓ શિયાળામાં અન્યત્ર જતા નથી, તેથી સફેદ બરફ વચ્ચે તેમનો લાલ રંગ ખૂબ સુંદર દેખાય છે.","hi":"कार्डिनल को मधुर गीत गाना बहुत पसंद होता है। वे सर्दियों में कहीं बाहर नहीं जाते, इसलिए सफेद बर्फ के बीच उनका लाल रंग बहुत सुंदर लगता है।"}'::jsonb,
  '{"en":"Did you know? Only the male cardinals are bright red; female cardinals are a beautiful light brown color with red highlights!","gu":"શું તમે જાણો છો? માત્ર નર કાર્ડિનલ જ તેજસ્વી લાલ રંગના હોય છે; માદા કાર્ડિનલ લાલ છાંટવાળા આછા ભૂરા રંગના હોય છે!","hi":"क्या आपको पता है? केवल नर कार्डिनल ही चमकीले लाल रंग के होते हैं; मादा कार्डिनल लाल रंग की झलक के साथ हल्के भूरे रंग की होती हैं!"}'::jsonb,
  'memory',
  true,
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'turkey',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Turkey","gu":"ટર્કી","hi":"टर्की"}'::jsonb,
  NULL,
  '/assets/images/birds/turkey.png',
  NULL,
  '{"en":"Turkey! Turkeys are large, fan-tailed birds famous for making a ''gobble-gobble'' sound.","gu":"ટર્કી! ટર્કી એ ગોળ ફેલાયેલી પૂંછડીવાળું એક મોટું પક્ષી છે જે ''ગોબલ-ગોબલ'' અવાજ કરવા માટે જાણીતું છે.","hi":"टर्की! टर्की गोल फैली हुई पूंछ वाले बड़े पक्षी होते हैं जो ''गॉबल-गॉबल'' की आवाज़ के लिए जाने जाते हैं।"}'::jsonb,
  '{"en":"Turkeys live in forests and farms. They can run fast and fly short distances to roost safely in trees at night.","gu":"ટર્કી જંગલો અને ખેતરોમાં રહે છે. તેઓ ઝડપથી દોડી શકે છે અને રાત્રે ઝાડ પર સુરક્ષિત રીતે બેસવા માટે થોડું ઉડી પણ શકે છે.","hi":"टर्की जंगलों और खेतों में रहते हैं। वे तेज़ी से दौड़ सकते हैं और रात में पेड़ों पर सुरक्षित सोने के लिए थोड़ी दूरी तक उड़ भी सकते हैं।"}'::jsonb,
  '{"en":"Did you know? A turkey''s head can change colors to red, blue, or white depending on how excited or scared they are!","gu":"શું તમે જાણો છો? ટર્કી ઉત્સાહિત કે ડરેલા હોય તે મુજબ તેમના માથાનો રંગ બદલાઈને લાલ, વાદળી કે સફેદ થઈ શકે છે!","hi":"क्या आपको पता है? टर्की का सिर उनके उत्साह या डर के अनुसार लाल, नीले या सफेद रंग में बदल सकता है!"}'::jsonb,
  'memory',
  true,
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'peacock',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Peacock","gu":"મોર","hi":"मोर"}'::jsonb,
  NULL,
  '/assets/images/birds/peacock.png',
  NULL,
  '{"en":"Peacock! The peacock is a majestic bird famous for its giant, colorful tail feathers.","gu":"મોર! મોર એ તેના લાંબા અને અત્યંત સુંદર રંગબેરંગી પીંછા માટે જાણીતું એક ભવ્ય પક્ષી છે.","hi":"मोर! मोर अपने विशाल और बेहद खूबसूरत रंग-बिरंगे पंखों के लिए प्रसिद्ध एक शानदार पक्षी है।"}'::jsonb,
  '{"en":"Peacocks spread their feathers like a giant, shimmering fan to show off. They love eating seeds, fruits, and small insects.","gu":"મોર પોતાના પીંછાને પંખાની જેમ ફેલાવીને સુંદર કળા કરે છે. તેમને બીજ, અનાજ, ફળો અને નાના જીવજંતુઓ ખાવા ગમે છે.","hi":"मोर अपने पंखों को किसी विशाल पंखे की तरह फैलाकर नाचते हैं। उन्हें अनाज, फल और छोटे कीड़े खाना पसंद होता है।"}'::jsonb,
  '{"en":"Did you know? The peacock is the national bird of India! They make loud calls especially when it is about to rain.","gu":"શું તમે જાણો છો? મોર ભારતનું રાષ્ટ્રીય પક્ષી છે! તેઓ ખાસ કરીને વરસાદ આવવાનો હોય ત્યારે મીઠા ટહુકા કરે છે.","hi":"क्या आपको पता है? मोर भारत का राष्ट्रीय पक्षी है! वे विशेष रूप से बारिश होने से पहले ज़ोर से बोलते हैं।"}'::jsonb,
  'memory',
  true,
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'eagle',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Eagle","gu":"ગરુડ","hi":"गरुड़"}'::jsonb,
  NULL,
  '/assets/images/birds/eagle.png',
  NULL,
  '{"en":"Eagle! Eagles are powerful birds of prey that fly high in the sky.","gu":"ગરુડ! ગરુડ એ આકાશમાં ઊંચે ઉડતું એક શક્તિશાળી શિકારી પક્ષી છે.","hi":"गरुड़! गरुड़ आकाश में बहुत ऊँचा उड़ने वाले बहुत ही शक्तिशाली शिकारी पक्षी होते हैं।"}'::jsonb,
  '{"en":"Eagles have huge wings to glide effortlessly on wind currents, and strong talons to catch food from land or water.","gu":"ગરુડ પાસે પવનના સહારે આસાનીથી સરકવા માટે વિશાળ પાંખો અને જમીન કે પાણીમાંથી શિકાર પકડવા મજબૂત પંજા હોય છે.","hi":"गरुड़ के पास हवा में आसानी से तैरने के लिए बड़े पंख और ज़मीन या पानी से शिकार पकड़ने के लिए मजबूत पंजे होते हैं।"}'::jsonb,
  '{"en":"Did you know? Eagles have incredible eyesight—they can spot a tiny rabbit from over two miles away!","gu":"શું તમે જાણો છો? ગરુડની નજર અત્યંત તેજ હોય છે - તેઓ બે માઈલથી પણ વધુ દૂરથી નાના સસલાને જોઈ શકે છે!","hi":"क्या आपको पता है? गरुड़ की नज़र बहुत तेज़ होती है—वे दो मील से भी अधिक दूरी से एक छोटे खरगोश को देख सकते हैं!"}'::jsonb,
  'memory',
  true,
  21
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kingfisher',
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1),
  '{"en":"Kingfisher","gu":"કલકલીયો","hi":"किंगफिशर"}'::jsonb,
  NULL,
  '/assets/images/birds/kingfisher.png',
  NULL,
  '{"en":"Kingfisher! Kingfishers are bright, colorful birds famous for catching fish.","gu":"કલકલીયો! કલકલીયો એ તેજસ્વી રંગીન પક્ષી છે જે માછલી પકડવા માટે પ્રખ્યાત છે.","hi":"किंगफिशर! किंगफिशर चमकीले और रंग-बिरंगे पक्षी होते हैं जो मछली पकड़ने के लिए प्रसिद्ध हैं।"}'::jsonb,
  '{"en":"Kingfishers sit on branches over the water and dive headfirst at high speed to catch fish with their long, dagger-like beaks.","gu":"કલકલીયો નદી કે તળાવ પરની ડાળી પર બેસે છે અને માછલી પકડવા માટે પોતાની લાંબી ચાંચ સાથે સીધી પાણીમાં ડૂબકી મારે છે.","hi":"किंगफिशर पानी के ऊपर डालियों पर बैठते हैं और अपनी लंबी चोंच से मछली पकड़ने के लिए सीधे पानी में गोता लगाते हैं।"}'::jsonb,
  '{"en":"Did you know? Kingfishers have special eyes that allow them to see clearly underwater, helping them hunt accurately!","gu":"શું તમે જાણો છો? કલકલીયાની આંખો ખાસ હોય છે જેના કારણે તેઓ પાણીની અંદર પણ સ્પષ્ટ જોઈ શકે છે, જે શિકાર કરવામાં મદદ કરે છે!","hi":"क्या आपको पता है? किंगफिशर की आँखें विशेष होती हैं जो उन्हें पानी के अंदर भी स्पष्ट देखने में मदद करती हैं!"}'::jsonb,
  'memory',
  true,
  22
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

-- ------------------------------------------
-- Seed data for vegetables
-- ------------------------------------------
INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'asparagus',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Asparagus","gu":"શતાવરી","hi":"शतावरी"}'::jsonb,
  NULL,
  '/assets/images/vegetables/asparagus.png',
  NULL,
  '{"en":"Asparagus! Asparagus spears are long, green, and look like tiny spears.","gu":"શતાવરી! શતાવરી લાંબી, લીલી અને નાની ભાલા જેવી દેખાય છે.","hi":"शतावरी! शतावरी लंबी, हरी और छोटे भाले जैसी दिखती है।"}'::jsonb,
  '{"en":"Asparagus grows straight out of the ground. It is very healthy and contains lots of vitamins to help you grow strong!","gu":"શતાવરી સીધી જમીનમાંથી બહાર ઊગે છે. તે ખૂબ જ સ્વસ્થ છે અને તેમાં તમને મજબૂત બનવા માટે ઘણા બધા વિટામિન્સ હોય છે!","hi":"शतावरी सीधे जमीन से बाहर उगती है। यह बहुत स्वास्थ्यवर्धक है और इसमें आपको मजबूत बनाने के लिए बहुत सारे विटामिन होते हैं!"}'::jsonb,
  '{"en":"Did you know? Asparagus plants can live and produce delicious spears for up to 20 years!","gu":"શું તમે જાણો છો? શતાવરીનો છોડ ૨૦ વર્ષ સુધી જીવંત રહી શકે છે અને સ્વાદિષ્ટ શતાવરી આપી શકે છે!","hi":"क्या आपको पता है? शतावरी का पौधा 20 साल तक जीवित रह सकता है और स्वादिष्ट शतावरी दे सकता है!"}'::jsonb,
  'memory',
  true,
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bell_pepper',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Bell Pepper","gu":"કેપ્સિકમ","hi":"शिमला मिर्च"}'::jsonb,
  NULL,
  '/assets/images/vegetables/bell_pepper.png',
  NULL,
  '{"en":"Bell Pepper! Bell peppers are crunchy and come in bright colors like red, yellow, and green.","gu":"કેપ્સિકમ! કેપ્સિકમ ક્રન્ચી હોય છે અને તે લાલ, પીળા અને લીલા જેવા તેજસ્વી રંગોમાં આવે છે.","hi":"शिमला मिर्च! शिमला मिर्च कुरकुरी होती है और यह लाल, पीले और हरे जैसे चमकीले रंगों में आती है।"}'::jsonb,
  '{"en":"Bell peppers are sweet, not spicy! They are filled with vitamin C and make salads and pizzas colorful and tasty.","gu":"કેપ્સિકમ મીઠા હોય છે, તીખા નહીં! તેઓ વિટામિન C થી ભરપૂર હોય છે અને સલાડ તથા પિઝાને રંગીન અને સ્વાદિષ્ટ બનાવે છે.","hi":"शिमला मिर्च मीठी होती है, तीखी नहीं! वे विटामिन सी से भरपूर होती हैं और सलाद व पिज्जा को रंगीन और स्वादिष्ट बनाती हैं।"}'::jsonb,
  '{"en":"Did you know? Green bell peppers are just unripe red ones! As they stay on the plant, they turn yellow and then red.","gu":"શું તમે જાણો છો? લીલા કેપ્સિકમ એ કાચા લાલ કેપ્સિકમ જ છે! જેમ જેમ તેઓ છોડ પર રહે છે તેમ તેમ તેઓ પીળા અને પછી લાલ થાય છે.","hi":"क्या आपको पता है? हरी शिमला मिर्च असल में कच्ची लाल मिर्च ही होती है! जैसे-जैसे वे पौधे पर रहती हैं, वे पीली और फिर लाल हो जाती हैं।"}'::jsonb,
  'memory',
  true,
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'broccoli',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Broccoli","gu":"બ્રોકોલી","hi":"ब्रोकोली"}'::jsonb,
  NULL,
  '/assets/images/vegetables/broccoli.png',
  NULL,
  '{"en":"Broccoli! Broccoli looks like a bundle of cute, green miniature trees.","gu":"બ્રોકોલી! બ્રોકોલી નાના, લીલા રંગના લઘુચિત્ર વૃક્ષોના જૂથ જેવી દેખાય છે.","hi":"ब्रोकोली! ब्रोकोली छोटे, हरे रंग के नन्हे पेड़ों के गुच्छे जैसी दिखती है।"}'::jsonb,
  '{"en":"Broccoli is a superfood! It is packed with nutrients that protect our bodies and keep our tummies happy.","gu":"બ્રોકોલી એક સુપરફૂડ છે! તે એવા પોષક તત્ત્વોથી ભરપૂર છે જે આપણા શરીરનું રક્ષણ કરે છે અને પેટને ખુશ રાખે છે.","hi":"ब्रोकोली एक सुपरफूड है! यह ऐसे पोषक तत्वों से भरपूर है जो हमारे शरीर की रक्षा करते हैं और पेट को स्वस्थ रखते हैं।"}'::jsonb,
  '{"en":"Did you know? The part of the broccoli we eat is actually a cluster of hundreds of tiny, unopened flower buds!","gu":"શું તમે જાણો છો? બ્રોકોલીનો જે ભાગ આપણે ખાઈએ છીએ તે વાસ્તવમાં સેંકડો નાના, ન ખીલેલા ફૂલોની કળીઓનો સમૂહ છે!","hi":"क्या आपको पता है? ब्रोकोली का जो हिस्सा हम खाते हैं वह वास्तव में सैकड़ों छोटे, बिना खिले फूलों की कलियों का समूह होता है!"}'::jsonb,
  'memory',
  true,
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'carrot',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Carrot","gu":"ગાજર","hi":"गाजर"}'::jsonb,
  NULL,
  '/assets/images/vegetables/carrot.png',
  NULL,
  '{"en":"Carrot! Carrots are sweet, crunchy orange roots that grow underground.","gu":"ગાજર! ગાજર એ જમીનની અંદર ઉગતા મીઠા, કડક અને નારંગી રંગના મૂળ છે.","hi":"गाजर! गाजर जमीन के नीचे उगने वाली मीठी, कुरकुरी और नारंगी रंग की जड़ें होती हैं।"}'::jsonb,
  '{"en":"Carrots are super healthy veggies. They are full of Vitamin A which is amazing for keeping your eyes healthy and strong!","gu":"ગાજર ખૂબ જ સ્વસ્થ શાકભાજી છે. તેઓ વિટામિન A થી ભરપૂર છે જે તમારી આંખોને સ્વસ્થ અને મજબૂત રાખવા માટે અદ્ભુત છે!","hi":"गाजर बहुत ही स्वास्थ्यवर्धक सब्ज़ी है। वे विटामिन ए से भरपूर होती हैं जो आपकी आँखों को स्वस्थ और तेज़ रखने के लिए बहुत अच्छा है!"}'::jsonb,
  '{"en":"Did you know? The first carrots grown long ago were actually purple and yellow, not orange!","gu":"શું તમે જાણો છો? વર્ષો પહેલા ઉગાડવામાં આવેલા સૌપ્રથમ ગાજર વાસ્તવમાં જાંબલી અને પીળા હતા, નારંગી નહીં!","hi":"क्या आपको पता है? बहुत पहले उगाए गए सबसे पहले गाजर वास्तव में बैंगनी और पीले थे, नारंगी नहीं!"}'::jsonb,
  'memory',
  true,
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cauliflower',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Cauliflower","gu":"ફુલાવર","hi":"फूलगोभी"}'::jsonb,
  NULL,
  '/assets/images/vegetables/cauliflower.png',
  NULL,
  '{"en":"Cauliflower! Cauliflower looks like a fluffy white cloud wrapped in green leaves.","gu":"ફુલાવર! ફુલાવર લીલા પાંદડાઓમાં વીંટળાયેલા સફેદ વાદળ જેવું લાગે છે.","hi":"फूलगोभी! फूलगोभी हरे पत्तों में लिपटे एक सफेद बादल जैसी दिखती है।"}'::jsonb,
  '{"en":"Cauliflower is a cousin of broccoli. Its white head is called the curd, and it can be used to make yummy curries and even pizza crusts!","gu":"ફુલાવર એ બ્રોકોલીનું પિતરાઈ ભાઈ છે. તેના સફેદ ભાગને કરડ કહેવાય છે અને તેનો ઉપયોગ સ્વાદિષ્ટ શાકભાજી બનાવવા માટે થાય છે!","hi":"फूलगोभी ब्रोकोली की ही प्रजाति है। इसके सफेद हिस्से को खाया जाता है और इससे स्वादिष्ट सब्जियां बनाई जाती हैं!"}'::jsonb,
  '{"en":"Did you know? Cauliflower comes in other colors too, including purple, orange, and green!","gu":"શું તમે જાણો છો? ફુલાવર અન્ય રંગોમાં પણ આવે છે, જેમાં જાંબલી, નારંગી અને લીલો સમાવેશ થાય છે!","hi":"क्या आपको पता है? फूलगोभी अन्य रंगों में भी आती है, जिसमें बैंगनी, नारंगी और हरा शामिल है!"}'::jsonb,
  'memory',
  true,
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'celery',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Celery","gu":"સેલરી","hi":"अजमोद"}'::jsonb,
  NULL,
  '/assets/images/vegetables/celery.png',
  NULL,
  '{"en":"Celery! Celery has long, crisp green stalks that make a loud crunch when you bite them.","gu":"સેલરી! સેલરીની લાંબી, કડક લીલી ડાળીઓ હોય છે જેને ખાતી વખતે મોટો અવાજ (ક્રંચ) થાય છે.","hi":"अजमोद! अजमोद की लंबी, कुरकुरी हरी डंडियाँ होती हैं जिन्हें खाते समय कड़क आवाज़ आती है।"}'::jsonb,
  '{"en":"Celery is mostly made of water and is very refreshing. It is great for dipping in peanut butter or hummus for a healthy snack.","gu":"સેલરી મોટાભાગે પાણીથી બનેલી હોય છે અને ખૂબ જ તાજગી આપનારી છે. તે તંદુરસ્ત નાસ્તા તરીકે ખાવા માટે ઉત્તમ છે.","hi":"अजमोद में ज्यादातर पानी होता है और यह बहुत ताज़गी देता है। इसे स्वस्थ नाश्ते के रूप में खाया जाता है।"}'::jsonb,
  '{"en":"Did you know? In ancient times, celery was used as a medicine and to make crowns for winners of athletic games!","gu":"શું તમે જાણો છો? પ્રાચીન સમયમાં, સેલરીનો ઉપયોગ દવા તરીકે અને રમતગમતના વિજેતાઓ માટે તાજ બનાવવા માટે થતો હતો!","hi":"क्या आपको पता है? प्राचीन काल में, अजमोद का उपयोग दवा के रूप में और खेल विजेताओं के मुकुट बनाने के लिए किया जाता था!"}'::jsonb,
  'memory',
  true,
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'corn',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Corn","gu":"મકાઈ","hi":"मक्का"}'::jsonb,
  NULL,
  '/assets/images/vegetables/corn.png',
  NULL,
  '{"en":"Corn! Corn has sweet, juicy yellow kernels lined up on a cob.","gu":"મકાઈ! મકાઈના દાણા મીઠા અને રસદાર હોય છે જે લાઈનમાં ગોઠવાયેલા હોય છે.","hi":"मक्का! मक्के के दाने मीठे और रसदार होते हैं जो एक भुट्टे पर कतार में लगे होते हैं।"}'::jsonb,
  '{"en":"Corn can be popped into popcorn, boiled on the cob, or made into sweet corn soup. It gives us energy to run and play all day!","gu":"મકાઈમાંથી પોપકોર્ન બનાવી શકાય છે, બાફી શકાય છે અથવા સ્વીટ કોર્ન સૂપ બનાવી શકાય છે. તે આપણને આખો દિવસ રમવાની શક્તિ આપે છે!","hi":"मक्के से पॉपकॉर्न बनाया जा सकता है, उबाला जा सकता है या स्वीट कॉर्न सूप बनाया जा सकता है। यह हमें दिन भर खेलने की ऊर्जा देता है!"}'::jsonb,
  '{"en":"Did you know? An average ear of corn has about 800 kernels, and they are always arranged in an even number of rows!","gu":"શું તમે જાણો છો? મકાઈના એક ડોડામાં લગભગ ૮૦૦ દાણા હોય છે અને તેઓ હંમેશા બેકી સંખ્યાની હરોળમાં ગોઠવાયેલા હોય છે!","hi":"क्या आपको पता है? मक्के के एक भुट्टे पर लगभग 800 दाने होते हैं, और वे हमेशा सम संख्या (even number) की पंक्तियों में व्यवस्थित होते हैं!"}'::jsonb,
  'memory',
  true,
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cucumber',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Cucumber","gu":"કાકડી","hi":"खीरा"}'::jsonb,
  NULL,
  '/assets/images/vegetables/cucumber.png',
  NULL,
  '{"en":"Cucumber! Cucumbers are cool, crisp, and perfect for a hot summer day.","gu":"કાકડી! કાકડી ઠંડી, કડક અને ઉનાળાના ગરમ દિવસ માટે એકદમ યોગ્ય છે.","hi":"खीरा! खीरा ठंडा, कुरकुरा और गर्मी के दिनों के लिए बिल्कुल सही होता है।"}'::jsonb,
  '{"en":"Cucumbers have a smooth green skin and juicy flesh. Eating cucumbers helps keep our bodies hydrated and cool.","gu":"કાકડીની ચામડી લીલી અને સુંવાળી હોય છે. કાકડી ખાવાથી આપણું શરીર હાઇડ્રેટેડ રહે છે અને ઠંડક મળે છે.","hi":"खीरे की त्वचा हरी और चिकनी होती है। खीरा खाने से हमारा शरीर हाइड्रेटेड रहता है और ठंडक मिलती है।"}'::jsonb,
  '{"en":"Did you know? Cucumbers are actually 95% water! They belong to the same family as watermelons and pumpkins.","gu":"શું તમે જાણો છો? કાકડીમાં ૯૫% પાણી હોય છે! તે તરબૂચ અને કોળાના જ પરિવારમાંથી આવે છે.","hi":"क्या आपको पता है? खीरे में 95% पानी होता है! वे तरबूज और कद्दू के ही परिवार से संबंधित हैं।"}'::jsonb,
  'memory',
  true,
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'eggplant',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Eggplant","gu":"રીંગણ","hi":"बैंगन"}'::jsonb,
  NULL,
  '/assets/images/vegetables/eggplant.png',
  NULL,
  '{"en":"Eggplant! Eggplants are glossy, deep purple veggies with a green cap.","gu":"રીંગણ! રીંગણ એ માથા પર લીલી ટોપી જેવું ડીંટડું ધરાવતું ચળકતું, ઘેરા જાંબલી રંગનું શાકભાજી છે.","hi":"बैंगन! बैंगन सिर पर हरी टोपी जैसी डंडी वाले चमकदार, गहरे बैंगनी रंग की सब्ज़ी होते हैं।"}'::jsonb,
  '{"en":"Eggplants have a soft, spongy inside that absorbs yummy flavors when cooked. They are delicious when roasted or baked!","gu":"રીંગણની અંદરનો ભાગ નરમ અને સ્પોન્જી હોય છે જે રાંધતી વખતે સ્વાદ શોષી લે છે. તે શેકેલા ખૂબ જ સ્વાદિષ્ટ લાગે છે!","hi":"बैंगन का अंदरूनी हिस्सा नरम और स्पंजी होता है जो पकने पर स्वाद सोख लेता है। यह भुना हुआ बहुत स्वादिष्ट लगता है!"}'::jsonb,
  '{"en":"Did you know? Eggplants got their English name because some varieties are small, white, and look exactly like chicken eggs!","gu":"શું તમે જાણો છો? રીંગણને અંગ્રેજીમાં ''એગપ્લાન્ટ'' કહેવાય છે કારણ કે તેની અમુક જાતો નાની, સફેદ અને મરઘીના ઇંડા જેવી દેખાય છે!","hi":"क्या आपको पता है? बैंगन को अंग्रेजी में ''एगप्लांट'' कहा जाता है क्योंकि इसकी कुछ किस्में छोटी, सफेद और बिल्कुल अंडे जैसी दिखती हैं!"}'::jsonb,
  'memory',
  true,
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lettuce',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Lettuce","gu":"લેટીસ","hi":"सलाद पत्ता"}'::jsonb,
  NULL,
  '/assets/images/vegetables/lettuce.png',
  NULL,
  '{"en":"Lettuce! Lettuce has crisp green leaves that make salads fresh and crunchy.","gu":"લેટીસ! લેટીસ એ કડક લીલા પાંદડા છે જે સલાડને તાજું અને ક્રન્ચી બનાવે છે.","hi":"सलाद पत्ता! सलाद पत्ता कुरकुरे हरे पत्ते होते हैं जो सलाद को ताज़ा बनाते हैं।"}'::jsonb,
  '{"en":"Lettuce is the star ingredient of sandwiches, burgers, and salads. It is packed with water and vitamins to keep us active!","gu":"લેટીસ એ સેન્ડવીચ, બર્ગર અને સલાડની મુખ્ય સામગ્રી છે. તે આપણને સક્રિય રાખવા માટે પાણી અને વિટામિન્સથી ભરપૂર છે!","hi":"सलाद पत्ता सैंडविच, बर्गर और सलाद की मुख्य सामग्री है। यह हमें सक्रिय रखने के लिए पानी और विटामिन से भरपूर होता है!"}'::jsonb,
  '{"en":"Did you know? Ancient Egyptians first cultivated lettuce not for its leaves, but to produce oil from its seeds!","gu":"શું તમે જાણો છો? પ્રાચીન ઇજિપ્તવાસીઓએ સૌપ્રથમ લેટીસ પાંદડા માટે નહીં, પરંતુ તેના બીજમાંથી તેલ મેળવવા માટે ઉગાડ્યું હતું!","hi":"क्या आपको पता है? प्राचीन मिस्रवासियों ने सबसे पहले सलाद पत्ते को पत्तों के लिए नहीं, बल्कि उसके बीजों से तेल निकालने के लिए उगाया था!"}'::jsonb,
  'memory',
  true,
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mushroom',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Mushroom","gu":"મશરૂમ","hi":"मशरूम"}'::jsonb,
  NULL,
  '/assets/images/vegetables/mushroom.png',
  NULL,
  '{"en":"Mushroom! Mushrooms are unique, umbrella-shaped veggies that grow in forests.","gu":"મશરૂમ! મશરૂમ એ જંગલોમાં ઉગતી છત્ર જેવી અનોખી શાકભાજી છે.","hi":"मशरूम! मशरूम छाते जैसी अनोखी सब्ज़ी होते हैं जो जंगलों में उगते हैं।"}'::jsonb,
  '{"en":"Mushrooms are fungi, not plants! They have a soft texture and add a savory, earthy flavor to soups and pizzas.","gu":"મશરૂમ ફૂગ છે, છોડ નથી! તેઓ નરમ હોય છે અને સૂપ તથા પિઝામાં માટીની સોડમ જેવો સ્વાદિષ્ટ સ્વાદ ઉમેરે છે.","hi":"मशरूम कवक (fungi) होते हैं, पौधे नहीं! वे नरम होते हैं और सूप व पिज्जा में एक स्वादिष्ट स्वाद जोड़ते हैं।"}'::jsonb,
  '{"en":"Did you know? Some mushrooms can glow in the dark! There are more than 70 species of bioluminescent mushrooms.","gu":"શું તમે જાણો છો? કેટલાક મશરૂમ અંધારામાં ચમકી શકે છે! બાયોલ્યુમિનેસન્ટ મશરૂમ્સની ૭૦ થી વધુ પ્રજાતિઓ છે.","hi":"क्या आपको पता है? कुछ मशरूम अंधेरे में चमक सकते हैं! अंधेरे में चमकने वाले मशरूम की 70 से अधिक प्रजातियाँ हैं।"}'::jsonb,
  'memory',
  true,
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pea',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Pea","gu":"વટાણા","hi":"मटर"}'::jsonb,
  NULL,
  '/assets/images/vegetables/pea.png',
  NULL,
  '{"en":"Pea! Peas are tiny, sweet green balls that live inside a cozy pod.","gu":"વટાણા! વટાણા એ નાની, મીઠી લીલી ગોળીઓ છે જે સીંગ (પોડ) ની અંદર રહે છે.","hi":"मटर! मटर छोटे, मीठे हरे दाने होते हैं जो एक फली के अंदर रहते हैं।"}'::jsonb,
  '{"en":"We pop open the green pod to find the sweet peas. They are delicious to eat raw, boiled, or mixed in rice!","gu":"આપણે વટાણા મેળવવા માટે લીલી સીંગ ખોલીએ છીએ. તેઓ કાચા, બાફેલા કે ભાતમાં મિક્સ કરીને ખાવામાં સ્વાદિષ્ટ લાગે છે!","hi":"हम मटर के दाने पाने के लिए हरी फली को खोलते हैं। वे कच्चे, उबले हुए या चावल में मिलाकर खाने में स्वादिष्ट लगते हैं!"}'::jsonb,
  '{"en":"Did you know? The oldest pea ever found was about 10,000 years old, discovered in an ancient cave!","gu":"શું તમે જાણો છો? અત્યાર સુધીનો સૌથી જૂનો વટાણા લગભગ ૧૦,૦0૦ વર્ષ જૂનો હતો, જે એક પ્રાચીન ગુફામાંથી મળી આવ્યો હતો!","hi":"क्या आपको पता है? अब तक का सबसे पुराना मटर लगभग 10,000 साल पुराना था, जो एक प्राचीन गुफा में मिला था!"}'::jsonb,
  'memory',
  true,
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'potato',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Potato","gu":"બટાકા","hi":"आलू"}'::jsonb,
  NULL,
  '/assets/images/vegetables/potato.png',
  NULL,
  '{"en":"Potato! Potatoes are popular brown tubers that grow underground.","gu":"બટાકા! બટાકા એ જમીનની અંદર ઉગતા લોકપ્રિય ભૂરા રંગના કંદ છે.","hi":"आलू! आलू जमीन के नीचे उगने वाले लोकप्रिय भूरे रंग के कंद होते हैं।"}'::jsonb,
  '{"en":"Potatoes can be mashed, baked, or cut into crispy French fries! They are full of energy-giving carbohydrates.","gu":"બટાકાને મેશ કરી શકાય છે, બેક કરી શકાય છે અથવા ક્રિસ્પી ફ્રેન્ચ ફ્રાઈસ બનાવી શકાય છે! તેઓ કાર્બોહાઇડ્રેટ્સથી ભરપૂર હોય છે.","hi":"आलू को मैश किया जा सकता है, बेक किया जा सकता है या क्रिस्पी फ्रेंच फ्राइज़ बनाया जा सकता है! वे कार्बोहाइड्रेट से भरपूर होते हैं।"}'::jsonb,
  '{"en":"Did you know? Potatoes were the very first vegetable to be grown in outer space, aboard the Space Shuttle Columbia in 1995!","gu":"શું તમે જાણો છો? ૧૯૯૫ માં સ્પેસ શટલ કોલંબિયા પર, અંતરિક્ષમાં ઉગાડવામાં આવેલી પ્રથમ શાકભાજી બટાકા હતી!","hi":"क्या आपको पता है? 1995 में अंतरिक्ष यान कोलंबिया पर अंतरिक्ष में उगाई जाने वाली सबसे पहली सब्ज़ी आलू थी!"}'::jsonb,
  'memory',
  true,
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pumpkin',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Pumpkin","gu":"કોળું","hi":"कद्दू"}'::jsonb,
  NULL,
  '/assets/images/vegetables/pumpkin.png',
  NULL,
  '{"en":"Pumpkin! Pumpkins are giant, round orange squash that grow on vines.","gu":"કોળું! કોળું એ વેલા પર ઉગતું એક વિશાળ, ગોળ અને નારંગી રંગનું શાકભાજી છે.","hi":"कद्दू! कद्दू बेल पर उगने वाली एक विशाल, गोल और नारंगी रंग की सब्ज़ी होती है।"}'::jsonb,
  '{"en":"Pumpkins have a thick shell, and inside they have seeds and sweet pulp. They are famous for pumpkin pies and Halloween carving!","gu":"કોળાની છાલ જાડી હોય છે અને તેની અંદર બીજ અને મીઠો ગર્ભ હોય છે. તે પાઈ બનાવવા માટે અને હેલોવીન માટે પ્રખ્યાત છે!","hi":"कद्दू का छिलका मोटा होता है और इसके अंदर बीज और मीठा गूदा होता है। यह कद्दू की पाई और हैलोवीन के लिए प्रसिद्ध है!"}'::jsonb,
  '{"en":"Did you know? The word ''pumpkin'' comes from the Greek word ''pepon'', which means ''large melon''!","gu":"શું તમે જાણો છો? ''પમ્પકિન'' શબ્દ ગ્રીક શબ્દ ''પેપોન'' પરથી આવ્યો છે, જેનો અર્થ ''મોટું તળબૂચ'' થાય છે!","hi":"क्या आपको पता है? ''पम्पकिन'' शब्द ग्रीक शब्द ''पेपोन'' से आया है, जिसका अर्थ ''बड़ा तरबूज'' होता है!"}'::jsonb,
  'memory',
  true,
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tomato',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Tomato","gu":"ટામેટાં","hi":"टमाटर"}'::jsonb,
  NULL,
  '/assets/images/vegetables/tomato.png',
  NULL,
  '{"en":"Tomato! Tomatoes are red, juicy, and have tiny edible seeds inside.","gu":"ટામેટાં! ટામેટાં લાલ, રસદાર હોય છે અને તેની અંદર નાના ખાઈ શકાય તેવા બીજ હોય છે.","hi":"टमाटर! टमाटर लाल, रसदार होते हैं और उनके अंदर छोटे खाने योग्य बीज होते हैं।"}'::jsonb,
  '{"en":"Tomatoes are used in salads, ketchup, and pizza sauce. Scientifically, they are fruits, but we cook them as veggies!","gu":"ટામેટાંનો ઉપયોગ સલાડ, કેચઅપ અને પિઝા સોસમાં થાય છે. વૈજ્ઞાનિક રીતે તે ફળ છે, પણ આપણે તેને શાકભાજી તરીકે રાંધીએ છીએ!","hi":"टमाटर का उपयोग सलाद, केचअप और पिज्जा सॉस में किया जाता है। वैज्ञानिक रूप से वे फल हैं, लेकिन हम उन्हें सब्ज़ी की तरह पकाते हैं!"}'::jsonb,
  '{"en":"Did you know? There are thousands of varieties of tomatoes, and they can be yellow, pink, purple, and even black!","gu":"શું તમે જાણો છો? ટામેટાંની હજારો જાતો છે અને તે પીળા, ગુલાબી, જાંબલી અને કાળા પણ હોઈ શકે છે!","hi":"क्या आपको पता है? टमाटर की हज़ारों किस्में हैं, और वे पीले, गुलाबी, बैंगनी और काले भी हो सकते हैं!"}'::jsonb,
  'memory',
  true,
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ginger',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Ginger","gu":"આદુ","hi":"अदरक"}'::jsonb,
  NULL,
  '/assets/images/vegetables/ginger.png',
  NULL,
  '{"en":"Ginger! Ginger is a spicy, knobby root that grows underground.","gu":"આદુ! આદુ એ જમીનની અંદર ઉગતું એક તીખું અને ગાંઠદાર મૂળ છે.","hi":"अदरक! अदरक जमीन के नीचे उगने वाली एक तीखी और गांठदार जड़ होती है।"}'::jsonb,
  '{"en":"Ginger adds a warm, spicy kick to foods and tea. It is also a wonderful medicine for soothing upset tummies and sore throats.","gu":"આદુ ખોરાક અને ચામાં સ્વાદિષ્ટ તીખાશ ઉમેરે છે. પેટમાં દુખાવો અને ગળાના દુખાવાને મટાડવા માટે તે એક અદ્ભુત દવા પણ છે.","hi":"अदरक भोजन और चाय में एक तीखा स्वाद जोड़ता है। यह पेट दर्द और गले की खराश को ठीक करने के लिए एक बेहतरीन दवा भी है।"}'::jsonb,
  '{"en":"Did you know? Ginger is a close relative of turmeric and cardamom, which are also healthy spices!","gu":"શું તમે જાણો છો? આદુ એ હળદર અને એલચીનું નજીકનું સગાં છે, જે તંદુરસ્ત મસાલા છે!","hi":"क्या आपको पता है? अदरक हल्दी और इलायची का करीबी रिश्तेदार है, जो स्वास्थ्यवर्धक मसाले हैं!"}'::jsonb,
  'memory',
  true,
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'onion',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Onion","gu":"ડુંગળી","hi":"प्याज"}'::jsonb,
  NULL,
  '/assets/images/vegetables/onion.png',
  NULL,
  '{"en":"Onion! Onions are round, layered veggies that add amazing flavor to food.","gu":"ડુંગળી! ડુંગળી એ ગોળ, સ્તરોવાળી શાકભાજી છે જે ખોરાકમાં અદ્ભુત સ્વાદ ઉમેરે છે.","hi":"प्याज! प्याज गोल, परतों वाली सब्ज़ी होती है जो भोजन में बेहतरीन स्वाद जोड़ती है।"}'::jsonb,
  '{"en":"Onions have a papery outer skin and many layers inside. When we chop them, they release a vapor that can make us tear up!","gu":"ડુંગળીની બહાર પાતળી છાલ હોય છે અને અંદર ઘણા સ્તરો હોય છે. તેને સુધારતી વખતે તેમાંથી નીકળતી વરાળ આપણી આંખોમાં આંસુ લાવી શકે છે!","hi":"प्याज़ के बाहर पतला छिलका और अंदर कई परतें होती हैं। जब हम उन्हें काटते हैं, तो वे एक गैस छोड़ते हैं जिससे आँखों में आँसू आ सकते हैं!"}'::jsonb,
  '{"en":"Did you know? Onions have been used for centuries to help heal wounds and keep colds away!","gu":"શું તમે જાણો છો? ડુંગળીનો ઉપયોગ સદીઓથી ઘા રૂઝાવવા અને શરદી દૂર રાખવા માટે કરવામાં આવે છે!","hi":"क्या आपको पता है? प्याज का उपयोग सदियों से घावों को ठीक करने और सर्दी-जुकाम को दूर रखने के लिए किया जाता रहा है!"}'::jsonb,
  'memory',
  true,
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'spinach',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Spinach","gu":"પાલક","hi":"पालक"}'::jsonb,
  NULL,
  '/assets/images/vegetables/spinach.png',
  NULL,
  '{"en":"Spinach! Spinach is a leafy green veggie that makes our muscles strong.","gu":"પાલક! પાલક એ લીલા પાંદડાવાળી શાકભાજી છે જે આપણા સ્નાયુઓને મજબૂત બનાવે છે.","hi":"पालक! पालक हरी पत्तेदार सब्ज़ी होती है जो हमारी मांसपेशियों को मजबूत बनाती है।"}'::jsonb,
  '{"en":"Spinach is packed with iron and vitamins. Eating spinach helps our body produce energy and keeps us healthy.","gu":"પાલક આયર્ન અને વિટામિન્સથી ભરપૂર હોય છે. પાલક ખાવાથી આપણું શરીર ઉર્જા મેળવે છે અને આપણને સ્વસ્થ રાખે છે.","hi":"पालक आयरन और विटामिन से भरपूर होता है। पालक खाने से हमारे शरीर को ऊर्जा मिलती है और हम स्वस्थ रहते हैं।"}'::jsonb,
  '{"en":"Did you know? Spinach is famous for giving the cartoon character Popeye his super strength!","gu":"શું તમે જાણો છો? પાલક કાર્ટૂન કેરેક્ટર પોપાયને તેની સુપર તાકાત આપવા માટે પ્રખ્યાત છે!","hi":"क्या आपको पता है? पालक कार्टून चरित्र पोपेय (Popeye) को उसकी सुपर ताकत देने के लिए प्रसिद्ध है!"}'::jsonb,
  'memory',
  true,
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'leek',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Leek","gu":"લીલી ડુંગળી","hi":"हरी प्याज"}'::jsonb,
  NULL,
  '/assets/images/vegetables/leek.png',
  NULL,
  '{"en":"Leek! Leeks look like giant green onions with a mild, sweet flavor.","gu":"લીક! લીક એ હળવા, મીઠા સ્વાદવાળી વિશાળ લીલી ડુંગળી જેવી દેખાય છે.","hi":"लीक! लीक हल्के, मीठे स्वाद वाली विशाल हरी प्याज जैसी दिखती है।"}'::jsonb,
  '{"en":"Leeks are part of the onion family. They are chopped up and cooked in soups and stews to make them extra delicious.","gu":"લીક એ ડુંગળી પરિવારનો એક ભાગ છે. તેને સમારીને સૂપ અને શાકમાં ઉમેરવામાં આવે છે જેથી તે વધુ સ્વાદિષ્ટ બને.","hi":"लीक प्याज परिवार का हिस्सा हैं। इन्हें काटकर सूप और स्ट्यू में पकाया जाता है ताकि वे स्वादिष्ट बन सकें।"}'::jsonb,
  '{"en":"Did you know? The leek is the national symbol of Wales, and people wear them on St. David''s Day!","gu":"શું તમે જાણો છો? લીક એ વેલ્સનું રાષ્ટ્રીય પ્રતીક છે અને લોકો સેન્ટ ડેવિડ ડે પર તેને પહેરે છે!","hi":"क्या आपको पता है? लीक वेल्स का राष्ट्रीय प्रतीक है, और लोग सेंट डेविड डे पर इन्हें पहनते हैं!"}'::jsonb,
  'memory',
  true,
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'garlic',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Garlic","gu":"લસણ","hi":"लहसुन"}'::jsonb,
  NULL,
  '/assets/images/vegetables/garlic.png',
  NULL,
  '{"en":"Garlic! Garlic bulb has small white cloves with a strong, spicy scent.","gu":"લસણ! લસણના પિંડમાં તીવ્ર સુગંધ ધરાવતી નાની સફેદ કળીઓ હોય છે.","hi":"लहसुन! लहसुन में तीखी खुशबू वाली छोटी सफेद कलियाँ होती हैं।"}'::jsonb,
  '{"en":"Garlic is a superpower ingredient used in cooking all over the world. It makes food smell and taste amazing and keeps us healthy.","gu":"લસણ એ રસોઈમાં વપરાતી એક ઉત્તમ સામગ્રી છે. તે ખોરાકને સ્વાદિષ્ટ સુગંધ આપે છે અને આપણને સ્વસ્થ રાખે છે.","hi":"लहसुन खाना पकाने में इस्तेमाल होने वाली एक बेहतरीन सामग्री है। यह भोजन को स्वादिष्ट खुशबू देता है और हमें स्वस्थ रखता है।"}'::jsonb,
  '{"en":"Did you know? In old stories, garlic was believed to protect people from vampires and monsters!","gu":"શું તમે જાણો છો? જૂની વાર્તાઓમાં એવું માનવામાં આવતું હતું કે લસણ લોકોને વેમ્પાયર અને રાક્ષસોથી બચાવે છે!","hi":"क्या आपको पता है? पुरानी कहानियों में माना जाता था कि लहसुन लोगों को पिशाचों (vampires) से बचाता है!"}'::jsonb,
  'memory',
  true,
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'zucchini',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Zucchini","gu":"ઝુચીની","hi":"जुकिनी"}'::jsonb,
  NULL,
  '/assets/images/vegetables/zucchini.png',
  NULL,
  '{"en":"Zucchini! Zucchinis are long green squash that look like cucumbers.","gu":"ઝુચીની! ઝુચીની એ કાકડી જેવી દેખાતી લાંબી અને લીલી શાકભાજી છે.","hi":"जुकिनी! जुकिनी खीरे जैसी दिखने वाली लंबी और हरी सब्ज़ी होती है।"}'::jsonb,
  '{"en":"Zucchinis have a soft skin and mild taste. They can be sliced, roasted, or even grated into noodles called ''zoodles''!","gu":"ઝુચીનીની ત્વચા નરમ અને સ્વાદ હળવો હોય છે. તેને કાપીને, શેકીને અથવા તેના નૂડલ્સ બનાવીને ખાઈ શકાય છે!","hi":"जुकिनी का छिलकानराम और स्वाद हल्का होता है। इसे काटकर, भूनकर या नूडल्स बनाकर खाया जा सकता है!"}'::jsonb,
  '{"en":"Did you know? Zucchini flowers are also edible! People stuff them with cheese and fry them for a delicious treat.","gu":"શું તમે જાણો છો? ઝુચીનીના ફૂલો પણ ખાઈ શકાય છે! લોકો તેમાં ચીઝ ભરીને તળીને ખાય છે.","hi":"क्या आपको पता है? जुकिनी के फूल भी खाए जा सकते हैं! लोग उनमें पनीर भरकर तलते हैं।"}'::jsonb,
  'memory',
  true,
  21
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sweet_potato',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Sweet Potato","gu":"શક્કરિયાં","hi":"शकरकंद"}'::jsonb,
  NULL,
  '/assets/images/vegetables/sweet_potato.png',
  NULL,
  '{"en":"Sweet Potato! Sweet potatoes are sweet, orange tubers that grow underground.","gu":"શક્કરિયાં! શક્કરિયાં એ જમીનની અંદર ઉગતા મીઠા અને નારંગી રંગના કંદ છે.","hi":"शकरकंद! शकरकंद जमीन के नीचे उगने वाले मीठे और नारंगी रंग के कंद होते हैं।"}'::jsonb,
  '{"en":"Sweet potatoes are sweeter and have more nutrients than regular potatoes. They are delicious when baked or mashed into a sweet treat!","gu":"શક્કરિયાં સામાન્ય બટાકા કરતાં વધુ મીઠા અને પોષક તત્વો ધરાવે છે. તેઓ બાફેલા ખૂબ જ ટેસ્ટી લાગે છે!","hi":"शकरकंद सामान्य आलू से अधिक मीठे और पोषक तत्वों से भरपूर होते हैं। वे उबले हुए बहुत स्वादिष्ट लगते हैं!"}'::jsonb,
  '{"en":"Did you know? Despite the name, sweet potatoes are not actually potatoes; they belong to the morning glory family!","gu":"શું તમે જાણો છો? નામ હોવા છતાં, શક્કરિયાં વાસ્તવમાં બટાકા નથી; તે મોર્નિંગ ગ્લોરી પરિવારમાંથી આવે છે!","hi":"क्या आपको पता है? नाम के बावजूद, शकरकंद वास्तव में आलू नहीं हैं; वे एक अलग फूलदार पौधे के परिवार से हैं!"}'::jsonb,
  'memory',
  true,
  22
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'chili',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Chili","gu":"મરચું","hi":"मिर्च"}'::jsonb,
  NULL,
  '/assets/images/vegetables/chili.png',
  NULL,
  '{"en":"Chili! Chili peppers are small, shiny, and can be very hot and spicy!","gu":"મરચું! મરચાં નાના, ચળકતા હોય છે અને તે ખૂબ જ તીખા અને મસાલેદાર હોઈ શકે છે!","hi":"मिर्च! मिर्च छोटी, चमकदार होती है और यह बहुत तीखी व मसालेदार हो सकती है!"}'::jsonb,
  '{"en":"Chilis come in red, green, and yellow. They contain a substance that makes them taste spicy, which adds heat to our food.","gu":"મરચાં લાલ, લીલા અને પીળા રંગમાં આવે છે. તેમાં એવું તત્વ હોય છે જે તેમને તીખો સ્વાદ આપે છે, જે આપણા રસોઈમાં તીખાશ ઉમેરે છે.","hi":"मिर्च लाल, हरी और पीली होती है। इनमें एक ऐसा तत्व होता है जो इन्हें तीखा बनाता है, जिससे हमारे भोजन में तीखापन आता है।"}'::jsonb,
  '{"en":"Did you know? Birds cannot feel the spiciness of chili peppers at all, so they love to eat them and spread the seeds!","gu":"શું તમે જાણો છો? પક્ષીઓને મરચાની તીખાશ બિલકુલ લાગતી નથી, તેથી તેઓ તેને ખાવાનું અને બીજ ફેલાવવાનું પસંદ કરે છે!","hi":"क्या आपको पता है? पक्षियों को मिर्च का तीखापन बिल्कुल महसूस नहीं होता, इसलिए वे इन्हें खाकर इनके बीज फैलाते हैं!"}'::jsonb,
  'memory',
  true,
  23
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cabbage',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Cabbage","gu":"કોબીજ","hi":"पत्तागोभी"}'::jsonb,
  NULL,
  '/assets/images/vegetables/cabbage.png',
  NULL,
  '{"en":"Cabbage! Cabbages are round veggies with tightly wrapped green or purple leaves.","gu":"કોબીજ! કોબીજ એ ચુસ્તપણે વીંટળાયેલા લીલા કે જાંબલી પાંદડાવાળી ગોળ શાકભાજી છે.","hi":"पत्तागोभी! पत्तागोभी कसकर लिपटे हरे या बैंगनी पत्तों वाली गोल सब्ज़ी होती है।"}'::jsonb,
  '{"en":"Cabbage is full of fiber and water. It is crunchy and is used to make salads, stir-fries, and soups.","gu":"કોબીજ ફાઈબર અને પાણીથી ભરપૂર હોય છે. તે કડક હોય છે અને સલાડ, શાકભાજી અને સૂપ બનાવવા માટે વપરાય છે.","hi":"पत्तागोभी फाइबर और पानी से भरपूर होती है। यह कुरकुरी होती है और सलाद, सब्ज़ी व सूप बनाने के काम आती है।"}'::jsonb,
  '{"en":"Did you know? Cabbage is one of the oldest vegetables in the world, cultivated for more than 4,000 years!","gu":"શું તમે જાણો છો? કોબીજ એ દુનિયાની સૌથી જૂની શાકભાજીમાંની એક છે, જે ૪,૦૦૦ વર્ષથી વધુ સમયથી ઉગાડવામાં આવે છે!","hi":"क्या आपको पता है? पत्तागोभी दुनिया की सबसे पुरानी सब्जियों में से एक है, जिसे 4,000 से अधिक वर्षों से उगाया जा रहा है!"}'::jsonb,
  'memory',
  true,
  24
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'avocado',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Avocado","gu":"એવોકાડો","hi":"एवोकैडो"}'::jsonb,
  NULL,
  '/assets/images/vegetables/avocado.png',
  NULL,
  '{"en":"Avocado! Avocados are pear-shaped green fruits with a large seed inside.","gu":"એવોકાડો! એવોકાડો એ નાસપતી જેવા આકારનું લીલું ફળ છે જેની અંદર મોટું બીજ હોય છે.","hi":"एवोकैडो! एवोकैडो नाशपाती के आकार का हरा फल होता है जिसके अंदर एक बड़ा बीज होता है।"}'::jsonb,
  '{"en":"Avocados have a creamy, buttery flesh. They are full of healthy fats that are great for our brain and heart!","gu":"એવોકાડોનો ગર્ભ ક્રીમી અને માખણ જેવો નરમ હોય છે. તે આપણા મગજ અને હૃદય માટે ઉત્તમ એવા તંદુરસ્ત ફેટથી ભરપૂર છે!","hi":"एवोकैडो का गूदा मलाईदार और मक्खन जैसा होता है। यह हमारे दिमाग और दिल के लिए बहुत फायदेमंद होता है!"}'::jsonb,
  '{"en":"Did you know? Avocados are sometimes called ''alligator pears'' because of their bumpy green skin!","gu":"શું તમે જાણો છો? એવોકાડોને તેની લીલી અને ખરબચડી ત્વચાને કારણે કેટલીકવાર ''એલિગેટર પિઅર'' પણ કહેવામાં આવે છે!","hi":"क्या आपको पता है? एवोकैडो को उसकी हरी और खुरदरी त्वचा के कारण कभी-कभी ''मगरमच्छ नाशपाती'' (alligator pear) भी कहा जाता है!"}'::jsonb,
  'memory',
  true,
  25
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'beetroot',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Beetroot","gu":"બીટ","hi":"चुकंदर"}'::jsonb,
  NULL,
  '/assets/images/vegetables/beetroot.png',
  NULL,
  '{"en":"Beetroot! Beetroots are round, deep red roots that grow underground.","gu":"બીટ! બીટ એ જમીનની અંદર ઉગતું ગોળ અને ઘેરા લાલ રંગનું મૂળ છે.","hi":"चुकंदर! चुकंदर जमीन के नीचे उगने वाली गोल और गहरे लाल रंग की जड़ होती है।"}'::jsonb,
  '{"en":"Beetroots are sweet and have a vibrant color. Eating beetroots gives us energy and helps make our blood healthy!","gu":"બીટ મીઠા હોય છે અને તેનો રંગ ખૂબ જ આકર્ષક હોય છે. બીટ ખાવાથી આપણને એનર્જી મળે છે અને લોહી શુદ્ધ બને છે!","hi":"चुकंदर मीठा होता है और इसका रंग बहुत गहरा होता है। चुकंदर खाने से हमें ऊर्जा मिलती है और खून बढ़ता है!"}'::jsonb,
  '{"en":"Did you know? In old times, people used the dark red juice of beetroots as a natural dye for clothes and hair!","gu":"શું તમે જાણો છો? જૂના જમાનામાં લોકો કપડાં અને વાળ રંગવા માટે કુદરતી રંગ તરીકે બીટના લાલ રસનો ઉપયોગ કરતા હતા!","hi":"क्या आपको पता है? पुराने समय में लोग कपड़े और बाल रंगने के लिए प्राकृतिक रंग के रूप में चुकंदर के लाल रस का उपयोग करते थे!"}'::jsonb,
  'memory',
  true,
  26
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'brussels_sprout',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Brussels Sprout","gu":"બ્રસેલ્સ સ્પ્રાઉટ","hi":"ब्रसेल्स स्प्राउट"}'::jsonb,
  NULL,
  '/assets/images/vegetables/brussels_sprout.png',
  NULL,
  '{"en":"Brussels Sprout! Brussels sprouts look like tiny, cute baby cabbages.","gu":"બ્રસેલ્સ સ્પ્રાઉટ! બ્રસેલ્સ સ્પ્રાઉટ નાની, ક્યુટ બેબી કોબીજ જેવી દેખાય છે.","hi":"ब्रसेल्स स्प्राउट! ब्रसेल्स स्प्राउट छोटी, नन्ही पत्तागोभी जैसी दिखती है।"}'::jsonb,
  '{"en":"Brussels sprouts grow in clusters along a thick stem. They are roasted or steamed to make a delicious and healthy side dish.","gu":"બ્રસેલ્સ સ્પ્રાઉટ એક જાડા થડ પર જૂથમાં ઊગે છે. તેને શેકીને કે બાફીને ખાવામાં આવે છે જે સ્વાસ્થ્ય માટે ખૂબ સારી છે.","hi":"ब्रसेल्स स्प्राउट एक मोटे तने पर गुच्छे में उगती हैं। इन्हें भूनकर या भाप में पकाकर खाया जाता है जो स्वास्थ्य के लिए बहुत अच्छी हैं।"}'::jsonb,
  '{"en":"Did you know? Brussels sprouts are named after the city of Brussels in Belgium, where they became very popular!","gu":"શું તમે જાણો છો? બ્રસેલ્સ સ્પ્રાઉટ્સનું નામ બેલ્જિયમના બ્રસેલ્સ શહેર પરથી રાખવામાં આવ્યું છે, જ્યાં તે ખૂબ લોકપ્રિય બની હતી!","hi":"क्या आपको पता है? ब्रसेल्स स्प्राउट्स का नाम बेल्जियम के ब्रसेल्स शहर के नाम पर रखा गया है, जहाँ वे बहुत लोकप्रिय हुई थीं!"}'::jsonb,
  'memory',
  true,
  27
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'radish',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Radish","gu":"મૂળો","hi":"मूली"}'::jsonb,
  NULL,
  '/assets/images/vegetables/radish.png',
  NULL,
  '{"en":"Radish! Radishes are crunchy, peppery roots that grow underground.","gu":"મૂળો! મૂળો એ જમીનની અંદર ઉગતો એક ક્રન્ચી અને તીખો મૂળ છે.","hi":"मूली! मूली जमीन के नीचे उगने वाली एक कुरकुरी और तीखी जड़ होती है।"}'::jsonb,
  '{"en":"Radishes can be white, red, or purple. They are sliced into salads to add a spicy crunch and are full of water and vitamins.","gu":"મૂળો સફેદ, લાલ કે જાંબલી હોઈ શકે છે. તેને સલાડમાં ઉમેરવામાં આવે છે જેથી તેમાં ક્રન્ચી તીખાશ આવે, તે વિટામિન્સથી ભરપૂર છે.","hi":"मूली सफेद, लाल या बैंगनी हो सकती है। इसे सलाद में मिलाकर खाया जाता है जिससे उसमें कुरकुरा तीखापन आता है।"}'::jsonb,
  '{"en":"Did you know? In Mexico, there is a famous festival called the ''Night of the Radishes'' where people carve radishes into beautiful sculptures!","gu":"શું તમે જાણો છો? મેક્સિકોમાં ''નાઈટ ઓફ ધ રેડિશ'' નામનો પ્રખ્યાત તહેવાર ઉજવાય છે જ્યાં લોકો મૂળામાંથી સુંદર શિલ્પો બનાવે છે!","hi":"क्या आपको पता है? मैक्सिको में ''नाईट ऑफ द रेडिशेस'' नाम का एक प्रसिद्ध त्योहार मनाया जाता है जहाँ लोग मूली को तराशकर सुंदर मूर्तियाँ बनाते हैं!"}'::jsonb,
  'memory',
  true,
  28
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.vegetables 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'artichoke',
  (SELECT id FROM categories WHERE category_key = 'vegetables' LIMIT 1),
  '{"en":"Artichoke","gu":"હાથીચક","hi":"हाथीचक"}'::jsonb,
  NULL,
  '/assets/images/vegetables/artichoke.png',
  NULL,
  '{"en":"Artichoke! Artichokes look like giant green pinecones made of leaves.","gu":"હાથીચક! હાથીચક પાંદડાઓથી બનેલા એક મોટા લીલા પાઈનકોન જેવું લાગે છે.","hi":"हाथीचक! हाथीचक पत्तों से बने एक बड़े हरे पाइन कोन जैसा दिखता है।"}'::jsonb,
  '{"en":"The edible part of the artichoke is the heart at the center and the soft base of the leaves. They are delicious when steamed or grilled!","gu":"હાથીચકનો ખાવાલાયક ભાગ તેની મધ્યમાં આવેલું હૃદય અને પાંદડાઓનો નીચેનો નરમ ભાગ છે. તે ગ્રીલ કરેલા ખૂબ ટેસ્ટી લાગે છે!","hi":"हाथीचक का खाने योग्य हिस्सा इसके बीच का भाग और पत्तों का निचला नरम हिस्सा होता है। यह ग्रिल किया हुआ बहुत स्वादिष्ट लगता है!"}'::jsonb,
  '{"en":"Did you know? An artichoke is actually a large flower bud that belongs to the sunflower family!","gu":"શું તમે જાણો છો? હાથીચક વાસ્તવમાં સૂર્યમુખી પરિવારની એક મોટી ફૂલની કળી છે!","hi":"क्या आपको पता है? हाथीचक वास्तव में सूरजमुखी परिवार की एक बड़ी फूल की कली होती है!"}'::jsonb,
  'memory',
  true,
  29
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

-- ------------------------------------------
-- Seed data for fruits
-- ------------------------------------------
INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'apple',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Apple","gu":"સફરજન","hi":"सेब"}'::jsonb,
  NULL,
  '/assets/images/fruits/apple.png',
  NULL,
  '{"en":"Apple! Apples are crunchy, sweet, and very healthy fruits.","gu":"સફરજન! સફરજન મીઠા, કડક અને ખૂબ જ પૌષ્ટિક ફળ છે.","hi":"सेब! सेब मीठे, कुरकुरे और बहुत ही सेहतमंद फल होते हैं।"}'::jsonb,
  '{"en":"Apples can be red, green, or yellow. Eating them keeps us healthy and gives us energy to play.","gu":"સફરજન લાલ, લીલા કે પીળા રંગના હોય છે. તે ખાવાથી આપણે સ્વસ્થ રહીએ છીએ અને રમવાની શક્તિ મળે છે.","hi":"सेब लाल, हरे या पीले रंग के होते हैं। इन्हें खाने से हम स्वस्थ रहते हैं और हमें खेलने की ऊर्जा मिलती है।"}'::jsonb,
  '{"en":"Did you know? Apples float in water because they are made of 25 percent air!","gu":"શું તમે જાણો છો? સફરજન પાણીમાં તરે છે કારણ કે તેમાં ૨૫ ટકા હવા હોય છે!","hi":"क्या आपको पता है? सेब पानी में तैरते हैं क्योंकि वे 25 प्रतिशत हवा से बने होते हैं!"}'::jsonb,
  'memory',
  true,
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'avocado',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Avocado","gu":"એવોકાડો","hi":"एवोकाडो"}'::jsonb,
  NULL,
  '/assets/images/fruits/avocado.png',
  NULL,
  '{"en":"Avocado! Avocados are creamy, green fruits with a big seed in the middle.","gu":"એવોકાડો! એવોકાડો એ વચ્ચે એક મોટું બીજ ધરાવતું ક્રીમી અને લીલું ફળ છે.","hi":"एवोकाडो! एवोकाडो बीच में एक बड़े बीज वाले मलाईदार और हरे फल होते हैं।"}'::jsonb,
  '{"en":"Avocados are super soft and healthy. They are great for making delicious guacamole and spreads!","gu":"એવોકાડો ખૂબ જ નરમ અને પૌષ્ટિક હોય છે. તે સ્વાદિષ્ટ ગુઆકામોલ અને સ્પ્રેડ બનાવવા માટે ઉત્તમ છે!","hi":"एवोकाडो बहुत ही नरम और सेहतमंद होते हैं। इनसे स्वादिष्ट गुआकामोल और चटनी बनाई जाती है!"}'::jsonb,
  '{"en":"Did you know? Avocados are also called ''alligator pears'' because of their bumpy green skin!","gu":"શું તમે જાણો છો? એવોકાડોને તેની લીલી અને ખરબચડી સપાટીને કારણે ''એલિગેટર પિઅર'' પણ કહેવામાં આવે છે!","hi":"क्या आपको पता है? एवोकाडो को उनकी खुरदरी हरी त्वचा के कारण ''मगरमच्छ नाशपाती'' भी कहा जाता है!"}'::jsonb,
  'memory',
  true,
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'banana',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Banana","gu":"કેળું","hi":"केला"}'::jsonb,
  NULL,
  '/assets/images/fruits/banana.png',
  NULL,
  '{"en":"Banana! Bananas are sweet, yellow fruits that are easy to peel.","gu":"કેળું! કેળાં એ મીઠા અને પીળા ફળ છે જેમને છોલવા ખૂબ જ સરળ છે.","hi":"केला! केले मीठे और पीले फल होते हैं जिन्हें छीलना बहुत आसान होता है।"}'::jsonb,
  '{"en":"Bananas grow in big bunches on tall plants. They give us quick energy and are perfect for a healthy snack.","gu":"કેળા ઊંચા છોડ પર મોટા ઝૂમખામાં ઉગે છે. તે આપણને ઝડપી શક્તિ આપે છે અને તંદુરસ્ત નાસ્તા માટે ઉત્તમ છે.","hi":"केले ऊंचे पौधों पर बड़े गुच्छों में उगते हैं। ये हमें तुरंत ऊर्जा देते हैं और स्वस्थ नाश्ते के लिए बहुत अच्छे हैं।"}'::jsonb,
  '{"en":"Did you know? Bananas are curved because they grow towards the sun against gravity!","gu":"શું તમે જાણો છો? કેળાં વળેલા હોય છે કારણ કે તેઓ ગુરુત્વાકર્ષણની વિરુદ્ધ સૂર્ય તરફ ઊગે છે!","hi":"क्या आपको पता है? केले घुमावदार होते हैं क्योंकि वे गुरुत्वाकर्षण के विपरीत सूर्य की ओर उगते हैं!"}'::jsonb,
  'memory',
  true,
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'blueberry',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Blueberry","gu":"બ્લુબેરી","hi":"ब्लूबेरी"}'::jsonb,
  NULL,
  '/assets/images/fruits/blueberry.png',
  NULL,
  '{"en":"Blueberry! Blueberries are tiny, round, sweet blue berries.","gu":"બ્લુબેરી! બ્લુબેરી એ નાના, ગોળ અને મીઠા વાદળી રંગના બોર (બેરી) છે.","hi":"ब्लूबेरी! ब्लूबेरी छोटे, गोल और मीठे नीले रंग के बेर होते हैं।"}'::jsonb,
  '{"en":"Blueberries are packed with vitamins that protect our bodies. They are delicious in muffins, pancakes, and yogurt!","gu":"બ્લુબેરી વિટામિન્સથી ભરપૂર હોય છે જે આપણા શરીરનું રક્ષણ કરે છે. તે મફિન્સ, પેનકેક અને દહીંમાં ખૂબ જ સ્વાદિષ્ટ લાગે છે!","hi":"ब्लूबेरी विटामिन से भरपूर होती हैं जो हमारे शरीर की रक्षा करती हैं। ये मफिन, पैनकेक और दही में बहुत स्वादिष्ट लगती हैं!"}'::jsonb,
  '{"en":"Did you know? Blueberries are one of the only natural foods that are truly blue in color!","gu":"શું તમે જાણો છો? બ્લુબેરી એવા જૂજ કુદરતી ખોરાકોમાંનું એક છે જેનો રંગ ખરેખર વાદળી હોય છે!","hi":"क्या आपको पता है? ब्लूबेरी उन कुछ प्राकृतिक खाद्य पदार्थों में से एक है जिनका रंग वास्तव में नीला होता है!"}'::jsonb,
  'memory',
  true,
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cherry',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Cherry","gu":"ચેરી","hi":"चेरी"}'::jsonb,
  NULL,
  '/assets/images/fruits/cherry.png',
  NULL,
  '{"en":"Cherry! Cherries are small, round, bright red fruits with a long stem.","gu":"ચેરી! ચેરી એ લાંબી દાંડી ધરાવતા નાના, ગોળ અને તેજસ્વી લાલ રંગના ફળ છે.","hi":"चेरी! चेरी लंबी डंडी वाले छोटे, गोल और चमकीले लाल रंग के फल होते हैं।"}'::jsonb,
  '{"en":"Cherries are sweet and juicy. They have a hard seed inside that we throw away, and they look beautiful on top of cakes!","gu":"ચેરી મીઠી અને રસદાર હોય છે. તેની અંદર એક સખત બીજ હોય છે જેને આપણે ફેંકી દઈએ છીએ. તે કેકની ઉપર ખૂબ જ સુંદર લાગે છે!","hi":"चेरी मीठी और रसदार होती हैं। इनके अंदर एक सख्त बीज होता है जिसे हम फेंक देते हैं। ये केक के ऊपर बहुत सुंदर लगती हैं!"}'::jsonb,
  '{"en":"Did you know? Cherry trees belong to the rose family, and they grow beautiful pink blossoms in spring!","gu":"શું તમે જાણો છો? ચેરીના ઝાડ ગુલાબના પરિવારના છે અને વસંતઋતુમાં તેમાં સુંદર ગુલાબી ફૂલો ખીલે છે!","hi":"क्या आपको पता है? चेरी के पेड़ गुलाब के परिवार के होते हैं और वसंत ऋतु में उन पर सुंदर गुलाबी फूल खिलते हैं!"}'::jsonb,
  'memory',
  true,
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'grape',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Grape","gu":"દ્રાક્ષ","hi":"अंगूर"}'::jsonb,
  NULL,
  '/assets/images/fruits/grape.png',
  NULL,
  '{"en":"Grape! Grapes are sweet, juicy berries that grow in lovely bunches.","gu":"દ્રાક્ષ! દ્રાક્ષ એ વેલા પર ઝૂમખામાં ઉગતા મીઠા અને રસદાર ફળ છે.","hi":"अंगूर! अंगूर मीठे और रसदार फल होते हैं जो गुच्छों में उगते हैं।"}'::jsonb,
  '{"en":"Grapes can be green, red, or purple. They are great for eating fresh and can be dried to make sweet raisins!","gu":"દ્રાક્ષ લીલી, લાલ કે જાંબલી રંગની હોઈ શકે છે. તે તાજી ખાવા માટે ઉત્તમ છે અને તેને સૂકવીને મીઠી કિસમિસ બનાવવામાં આવે છે!","hi":"अंगूर हरे, लाल या बैंगनी हो सकते हैं। ये ताज़ा खाने में बहुत अच्छे होते हैं और इन्हें सुखाकर मीठी किशमिश बनाई जाती है!"}'::jsonb,
  '{"en":"Did you know? Grapes are actually botanically berries, and they have been grown for over 8,000 years!","gu":"શું તમે જાણો છો? વનસ્પતિશાસ્ત્ર મુજબ દ્રાક્ષ વાસ્તવમાં બેરી છે અને તે ૮,૦૦૦ થી વધુ વર્ષોથી ઉગાડવામાં આવે છે!","hi":"क्या आपको पता है? अंगूर वास्तव में एक प्रकार के बेर (berry) हैं और इन्हें 8,000 से अधिक वर्षों से उगाया जा रहा है!"}'::jsonb,
  'memory',
  true,
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kiwi',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Kiwi","gu":"કીવી","hi":"कीवी"}'::jsonb,
  NULL,
  '/assets/images/fruits/kiwi.png',
  NULL,
  '{"en":"Kiwi! Kiwis are brown and fuzzy on the outside, and bright green on the inside.","gu":"કીવી! કીવી બહારથી ભૂરા અને રૂંવાટીવાળા અને અંદરથી તેજસ્વી લીલા રંગના હોય છે.","hi":"कीवी! कीवी बाहर से भूरे व रोएँदार और अंदर से चमकीले हरे रंग के होते हैं।"}'::jsonb,
  '{"en":"Kiwis have tiny, black seeds inside that we can eat. They taste sweet and tangy, and have lots of Vitamin C!","gu":"કીવીની અંદર નાના, કાળા બીજ હોય છે જેને આપણે ખાઈ શકીએ છીએ. તેનો સ્વાદ મીઠો અને ખાટો હોય છે અને તેમાં ઘણું વિટામિન C હોય છે!","hi":"कीवी के अंदर छोटे, काले बीज होते हैं जिन्हें हम खा सकते हैं। इनका स्वाद खट्टा-मीठा होता है और इनमें भरपूर विटामिन सी होता है!"}'::jsonb,
  '{"en":"Did you know? Kiwis are named after the kiwi bird of New Zealand because they are both small, brown, and fuzzy!","gu":"શું તમે જાણો છો? કીવીનું નામ ન્યુઝીલેન્ડના કીવી પક્ષી પરથી પડ્યું છે કારણ કે બંને નાના, ભૂરા અને રૂંવાટીવાળા છે!","hi":"क्या आपको पता है? कीवी का नाम न्यूजीलैंड के कीवी पक्षी के नाम पर रखा गया है क्योंकि दोनों ही छोटे, भूरे और रोएँदार होते हैं!"}'::jsonb,
  'memory',
  true,
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lemon',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Lemon","gu":"લીંબુ","hi":"नींबू"}'::jsonb,
  NULL,
  '/assets/images/fruits/lemon.png',
  NULL,
  '{"en":"Lemon! Lemons are bright yellow, oval-shaped, and very sour fruits.","gu":"લીંબુ! લીંબુ તેજસ્વી પીળા, અંડાકાર અને ખૂબ જ ખાટા ફળ છે.","hi":"नींबू! नींबू चमकीले पीले, अंडाकार और बहुत खट्टे फल होते हैं।"}'::jsonb,
  '{"en":"Lemons are full of vitamin C. We squeeze them to make refreshing lemonade and to add a tangy kick to our meals!","gu":"લીંબુ વિટામિન C થી ભરપૂર હોય છે. આપણે તેમાંથી તાજગી આપતું લીંબુ શરબત બનાવીએ છીએ અને રસોઈમાં ખાટો સ્વાદ ઉમેરીએ છીએ!","hi":"नींबू विटामिन सी से भरपूर होते हैं। हम इनसे ताज़ा शिकंजी बनाते हैं और भोजन में खट्टा स्वाद लाते हैं!"}'::jsonb,
  '{"en":"Did you know? Just a splash of lemon juice can keep sliced apples from turning brown!","gu":"શું તમે જાણો છો? લીંબુના રસના થોડા ટીપાં સફરજનના ટુકડાને કાળા પડતા અટકાવી શકે છે!","hi":"क्या आपको पता है? नींबू के रस की कुछ बूंदें कटे हुए सेब को काला पड़ने से बचा सकती हैं!"}'::jsonb,
  'memory',
  true,
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mango',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Mango","gu":"કેરી","hi":"आम"}'::jsonb,
  NULL,
  '/assets/images/fruits/mango.png',
  NULL,
  '{"en":"Mango! The mango is the sweet, juicy ''King of Fruits''.","gu":"કેરી! કેરી એ મીઠું, રસદાર અને ''ફળોનો રાજા'' છે.","hi":"आम! आम मीठा, रसदार और ''फलों का राजा'' होता है।"}'::jsonb,
  '{"en":"Mangoes grow in warm summer. They have a big seed inside and are loved for making shakes, juices, and slices.","gu":"કેરી ગરમીની ઋતુમાં ઉગે છે. તેની અંદર એક મોટું ગોટલું હોય છે અને લોકો તેને રસ, શેક અને ટુકડા તરીકે ખાવાનું પસંદ કરે છે.","hi":"आम गर्मियों के मौसम में उगते हैं। इनके अंदर एक बड़ी गुठली होती है और लोग इनका शेक, जूस या स्लाइस खाना पसंद करते हैं।"}'::jsonb,
  '{"en":"Did you know? The mango is the national fruit of India, Pakistan, and the Philippines!","gu":"શું તમે જાણો છો? કેરી ભારત, પાકિસ્તાન અને ફિલિપાઇન્સનું રાષ્ટ્રીય ફળ છે!","hi":"क्या आपको पता है? आम भारत, पाकिस्तान और फिलीपींस का राष्ट्रीय फल है!"}'::jsonb,
  'memory',
  true,
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'orange',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Orange","gu":"નારંગી","hi":"संतरा"}'::jsonb,
  NULL,
  '/assets/images/fruits/orange.png',
  NULL,
  '{"en":"Orange! Oranges are round, juicy citrus fruits that share their name with a color.","gu":"નારંગી! નારંગી એ ગોળ અને રસદાર ખાટાં ફળ છે જે એક રંગ સાથે પોતાનું નામ શેર કરે છે.","hi":"संतरा! संतरे गोल और रसदार फल होते हैं जिनका नाम एक रंग के नाम पर ही है।"}'::jsonb,
  '{"en":"Oranges have a bright peel that protect their sweet segments. They give us lots of Vitamin C to keep us healthy and strong.","gu":"નારંગીની બહાર એક જાડી છાલ હોય છે જે અંદરની મીઠી પેશીઓનું રક્ષણ કરે છે. તે આપણને સ્વસ્થ અને મજબૂત રાખવા માટે ઘણું વિટામિન C આપે છે.","hi":"संतरे के बाहर एक छिलका होता है जो अंदर की मीठी फांकों की रक्षा करता है। ये हमें स्वस्थ रखने के लिए बहुत सारा विटामिन सी देते हैं।"}'::jsonb,
  '{"en":"Did you know? Oranges are actually hybrid fruits, created long ago by crossing mandarins and pomelos!","gu":"શું તમે જાણો છો? નારંગી વાસ્તવમાં હાઇબ્રિડ ફળ છે, જે ઘણા સમય પહેલા મેન્ડરિન અને પોમેલોના મિશ્રણથી બનાવવામાં આવ્યા હતા!","hi":"क्या आपको पता है? संतरे वास्तव में हाइब्रिड फल हैं, जिन्हें बहुत पहले मेंडारिन और पोमेलो के मेल से बनाया गया था!"}'::jsonb,
  'memory',
  true,
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'papaya',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Papaya","gu":"પપૈયું","hi":"पपीता"}'::jsonb,
  NULL,
  '/assets/images/fruits/papaya.png',
  NULL,
  '{"en":"Papaya! Papayas are sweet, orange-fleshed fruits shaped like large pears.","gu":"પપૈયું! પપૈયું એ મોટી નાસપતી જેવા આકારનું અને અંદરથી કેસરી રંગનું મીઠું ફળ છે.","hi":"पपीता! पपीता बड़े नाशपाती के आकार का और अंदर से नारंगी रंग का मीठा फल होता है।"}'::jsonb,
  '{"en":"Papayas have soft orange flesh with lots of tiny black seeds in the center. They are great for healthy digestion!","gu":"પપૈયામાં નરમ અને મીઠો ગર્ભ હોય છે અને વચ્ચે ઘણા બધા નાના કાળા બીજ હોય છે. તે પાચન માટે ઉત્તમ છે!","hi":"पपीते में गूदा और बीच में बहुत सारे छोटे काले बीज होते हैं। यह पाचन क्रिया के लिए बहुत अच्छा होता है!"}'::jsonb,
  '{"en":"Did you know? Papaya trees grow very fast and can have ripe fruits within just one year of planting!","gu":"શું તમે જાણો છો? પપૈયાના ઝાડ ખૂબ જ ઝડપથી વધે છે અને વાવ્યા પછી માત્ર એક જ વર્ષમાં તેના પર પાકાં ફળ આવી શકે છે!","hi":"क्या आपको पता है? पपीते के पेड़ बहुत तेज़ी से बढ़ते हैं और रोपे जाने के सिर्फ एक साल के भीतर ही फल देने लगते हैं!"}'::jsonb,
  'memory',
  true,
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'peach',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Peach","gu":"પીચ","hi":"आड़ू"}'::jsonb,
  NULL,
  '/assets/images/fruits/peach.png',
  NULL,
  '{"en":"Peach! Peaches are sweet, juicy fruits with fuzzy pinkish-orange skin.","gu":"પીચ! પીચ એ ગુલાબી-કેસરી રંગની રૂંવાટીવાળી છાલ ધરાવતું મીઠું અને રસદાર ફળ છે.","hi":"आड़ू! आड़ू गुलाबी-नारंगी रंग की मखमली त्वचा वाले मीठे और रसदार फल होते हैं।"}'::jsonb,
  '{"en":"Peaches have a sweet smell and a single hard pit inside. They are delicious when eaten fresh or baked in sweet pies.","gu":"પીચની સુગંધ ખૂબ જ મીઠી હોય છે અને તેની અંદર એક સખત ઠળીયો હોય છે. તે તાજા ખાવામાં કે પાઈ બનાવવામાં ખૂબ ટેસ્ટી લાગે છે.","hi":"आड़ू की खुशबू बहुत मीठी होती है और इनके अंदर एक सख्त गुठली होती है। ये ताज़ा खाने में या पाई बनाने में बहुत स्वादिष्ट लगते हैं।"}'::jsonb,
  '{"en":"Did you know? Peaches have been grown for thousands of years and were first cultivated in ancient China!","gu":"શું તમે જાણો છો? પીચ હજારો વર્ષોથી ઉગાડવામાં આવે છે અને તેની ખેતી સૌપ્રથમ પ્રાચીન ચીનમાં શરૂ થઈ હતી!","hi":"क्या आपको पता है? आड़ू हज़ारों सालों से उगाए जा रहे हैं और सबसे पहले इनकी खेती प्राचीन चीन में की गई थी!"}'::jsonb,
  'memory',
  true,
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pear',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Pear","gu":"નાસપતી","hi":"नाशपाती"}'::jsonb,
  NULL,
  '/assets/images/fruits/pear.png',
  NULL,
  '{"en":"Pear! Pears are sweet, bell-shaped fruits that are soft and juicy.","gu":"નાસપતી! નાસપતી એ ઘંટડી જેવા આકારનું મીઠું, નરમ અને રસદાર ફળ છે.","hi":"नाशपाती! नाशपाती घंटी के आकार के मीठे, नरम और रसदार फल होते हैं।"}'::jsonb,
  '{"en":"Pears have a green or yellow skin and a grainy, sweet texture. They are packed with fiber which is great for our bellies!","gu":"નાસપતીની છાલ લીલી કે પીળી હોય છે અને તેનો ગર્ભ મીઠો અને દાણાદાર હોય છે. તેમાં પુષ્કળ ફાઈબર હોય છે જે પેટ માટે સારું છે!","hi":"नाशपाती की त्वचा हरी या पीली होती है और इसका गूदा मीठा व दानेदार होता है। इसमें भरपूर फाइबर होता है जो पेट के लिए अच्छा है!"}'::jsonb,
  '{"en":"Did you know? Unlike most fruits, pears ripen better off the tree after they are harvested!","gu":"શું તમે જાણો છો? અન્ય ફળોથી વિપરીત, નાસપતી ઝાડ પરથી ઉતાર્યા પછી વધુ સારી રીતે પાકે છે!","hi":"क्या आपको पता है? अन्य फलों के विपरीत, नाशपाती पेड़ से तोड़े जाने के बाद ज्यादा अच्छी तरह पकती है!"}'::jsonb,
  'memory',
  true,
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pineapple',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Pineapple","gu":"અનાનસ","hi":"अनानास"}'::jsonb,
  NULL,
  '/assets/images/fruits/pineapple.png',
  NULL,
  '{"en":"Pineapple! Pineapples are tropical fruits with spiky skin and a leafy crown.","gu":"અનાનસ! અનાનસ એ કાંટાવાળી સપાટી અને માથા પર પાંદડાનો મુગટ ધરાવતું સ્વાદિષ્ટ ફળ છે.","hi":"अनानास! अनानास कटीली त्वचा और सिर पर पत्तों का मुकुट वाले स्वादिष्ट फल होते हैं।"}'::jsonb,
  '{"en":"Pineapples are sweet and tangy inside. We peel away the tough outer skin to eat the golden, juicy fruit.","gu":"અનાનસ અંદરથી મીઠા અને ખાટા હોય છે. સોનેરી અને રસદાર ફળ ખાવા માટે આપણે તેની કઠણ બહારની છાલ કાઢી નાખીએ છીએ.","hi":"अनानास अंदर से खट्टे-मीठे होते हैं। सुनहरा और रसदार फल खाने के लिए हम इसका सख्त बाहरी छिलका उतार देते हैं।"}'::jsonb,
  '{"en":"Did you know? A pineapple is not a single fruit, but a large cluster of many individual berries fused together!","gu":"શું તમે જાણો છો? અનાનસ એક ફળ નથી, પરંતુ એકબીજા સાથે જોડાયેલી ઘણી બધી નાની બેરીઓનો સમૂહ છે!","hi":"क्या आपको पता है? अनानास एक अकेला फल नहीं है, बल्कि आपस में जुड़े कई छोटे-छोटे बेरों का एक समूह होता है!"}'::jsonb,
  'memory',
  true,
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pomegranate',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Pomegranate","gu":"દાડમ","hi":"अनार"}'::jsonb,
  NULL,
  '/assets/images/fruits/pomegranate.png',
  NULL,
  '{"en":"Pomegranate! Pomegranates are round, red fruits filled with hundreds of juicy seeds.","gu":"દાડમ! દાડમ એ લાલ રંગનું ગોળ ફળ છે જેની અંદર સેંકડો લાલ અને રસદાર દાણા હોય છે.","hi":"अनार! अनार लाल रंग के गोल फल होते हैं जिनके अंदर सैकड़ों लाल व रसदार दाने होते हैं।"}'::jsonb,
  '{"en":"We open the tough red shell to eat the sweet, ruby-like seeds called arils. They are super healthy and sweet!","gu":"લાલ અને મીઠા દાણા ખાવા માટે આપણે તેની જાડી છાલ ખોલીએ છીએ. આ સોનેરી લાલ દાણા ખાવામાં ખૂબ જ સ્વાદિષ્ટ હોય છે!","hi":"लाल और मीठे दाने खाने के लिए हम इसका सख्त छिलका खोलते हैं। ये दाने रूबी जैसे दिखते हैं और सेहत के लिए बहुत अच्छे हैं!"}'::jsonb,
  '{"en":"Did you know? A single pomegranate can contain anywhere from 200 to over 1,000 seeds!","gu":"શું તમે જાણો છો? એક જ દાડમમાં ૨૦૦ થી લઈને ૧,૦૦૦ થી વધુ દાણા હોઈ શકે છે!","hi":"क्या आपको पता है? एक ही अनार के अंदर 200 से लेकर 1,000 से भी अधिक दाने हो सकते हैं!"}'::jsonb,
  'memory',
  true,
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'strawberry',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Strawberry","gu":"સ્ટ્રોબેરી","hi":"स्ट्रॉबेरी"}'::jsonb,
  NULL,
  '/assets/images/fruits/strawberry.png',
  NULL,
  '{"en":"Strawberry! Strawberries are sweet, heart-shaped red berries.","gu":"સ્ટ્રોબેરી! સ્ટ્રોબેરી એ દિલના આકારવાળા મીઠા અને લાલ રંગના ફળ છે.","hi":"स्ट्रॉबेरी! स्ट्रॉबेरी दिल के आकार की मीठी और लाल रंग की बेरी होती हैं।"}'::jsonb,
  '{"en":"Strawberries are soft and delicious. They are loved in milkshakes, ice creams, and jams!","gu":"સ્ટ્રોબેરી નરમ અને સ્વાદિષ્ટ હોય છે. લોકોને તે મિલ્કશેક, આઈસ્ક્રીમ અને જેમમાં ખૂબ જ ગમે છે!","hi":"स्ट्रॉबेरी नरम और स्वादिष्ट होती हैं। लोग इन्हें शेक, आइसक्रीम और जैम में खाना बहुत पसंद करते हैं!"}'::jsonb,
  '{"en":"Did you know? Strawberries are the only fruit that wear their seeds on the outside—about 200 of them on each berry!","gu":"શું તમે જાણો છો? સ્ટ્રોબેરી એકમાત્ર એવું ફળ છે જેના બીજ બહારની સપાટી પર હોય છે - દરેક સ્ટ્રોબેરી પર લગભગ ૨૦૦ બીજ હોય છે!","hi":"क्या आपको पता है? स्ट्रॉबेरी एकमात्र ऐसा फल है जिसके बीज बाहर की तरफ होते हैं—हर स्ट्रॉबेरी पर लगभग 200 बीज होते हैं!"}'::jsonb,
  'memory',
  true,
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.fruits 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'watermelon',
  (SELECT id FROM categories WHERE category_key = 'fruits' LIMIT 1),
  '{"en":"Watermelon","gu":"તરબૂચ","hi":"तरबूज"}'::jsonb,
  NULL,
  '/assets/images/fruits/watermelon.png',
  NULL,
  '{"en":"Watermelon! Watermelons are giant, green summer fruits that are red and juicy inside.","gu":"તરબૂચ! તરબૂચ ઉનાળાનું મોટું લીલું ફળ છે જે અંદરથી લાલ અને ખૂબ જ રસદાર હોય છે.","hi":"तरबूज! तरबूज गर्मियों का एक बड़ा हरा फल होता है जो अंदर से लाल और बहुत ही रसदार होता है।"}'::jsonb,
  '{"en":"Watermelons are sweet and perfect for cooling down on a hot day. They are full of sweet juice that keeps us hydrated.","gu":"તરબૂચ મીઠા હોય છે અને ગરમીના દિવસોમાં ઠંડક આપવા માટે ઉત્તમ છે. તે આપણને હાઇડ્રેટેડ રાખવા માટે પાણીથી ભરપૂર હોય છે.","hi":"तरबूज मीठे होते हैं और गर्मियों में शरीर को ठंडक देने के लिए बहुत अच्छे हैं। इसमें बहुत सारा पानी होता है जो हमें हाइड्रेटेड रखता है।"}'::jsonb,
  '{"en":"Did you know? Watermelons are 92 percent water, which is why they are so juicy and refreshing!","gu":"શું તમે જાણો છો? તરબૂચમાં ૯૨ ટકા પાણી હોય છે, તેથી જ તે આટલા cartoons રસદાર અને તાજગી આપનારા હોય છે!","hi":"क्या आपको पता है? तरबूज में 92 प्रतिशत पानी होता है, इसलिए यह बहुत रसदार और ताज़गी देने वाला होता है!"}'::jsonb,
  'memory',
  true,
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

-- ------------------------------------------
-- Seed data for space
-- ------------------------------------------
INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'asteroid',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Asteroid","gu":"લઘુગ્રહ","hi":"क्षुद्रग्रह"}'::jsonb,
  NULL,
  '/assets/images/space/asteroid.png',
  NULL,
  '{"en":"Asteroid! Asteroids are giant rocky space boulders floating in space.","gu":"લઘુગ્રહ! લઘુગ્રહ (એસ્ટરોઇડ) એ અવકાશમાં તરતા મોટા ખડકો છે.","hi":"क्षुद्रग्रह! क्षुद्रग्रह (एस्टेरॉयड) अंतरिक्ष में तैरते हुए विशाल चट्टानी टुकड़े होते हैं।"}'::jsonb,
  '{"en":"Asteroids are leftovers from when our solar system was made. Most of them orbit the sun between Mars and Jupiter.","gu":"લઘુગ્રહો આપણા સૌરમંડળના નિર્માણ સમયના બચેલા ભાગ છે. તેમાંથી મોટાભાગના મંગળ અને ગુરુ વચ્ચે સૂર્યની આસપાસ ફરે છે.","hi":"क्षुद्रग्रह हमारे सौरमंडल के निर्माण के समय के बचे हुए हिस्से हैं। इनमें से अधिकांश मंगल और बृहस्पति के बीच सूर्य की परिक्रमा करते हैं।"}'::jsonb,
  '{"en":"Did you know? Asteroids look like giant space potatoes because they don''t have enough gravity to become round!","gu":"શું તમે જાણો છો? લઘુગ્રહો ગોળ થવા જેટલું ગુરુત્વાકર્ષણ ધરાવતા ન હોવાથી તે મોટા બટાકા જેવા દેખાય છે!","hi":"क्या आपको पता है? क्षुद्रग्रह आलू के आकार जैसे दिखते हैं क्योंकि उनके पास गोल होने के लिए पर्याप्त गुरुत्वाकर्षण नहीं होता है!"}'::jsonb,
  'memory',
  true,
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'black_hole',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Black Hole","gu":"બ્લેક હોલ","hi":"ब्लैक होल"}'::jsonb,
  NULL,
  '/assets/images/space/black_hole.png',
  NULL,
  '{"en":"Black Hole! A black hole is a super strong space vacuum cleaner.","gu":"બ્લેક હોલ! બ્લેક હોલ એ અંતરિક્ષનું એક અત્યંત શક્તિશાળી શૂન્યાવકાશ (વેક્યૂમ ક્લીનર) છે.","hi":"ब्लैक होल! ब्लैक होल अंतरिक्ष का एक बेहद शक्तिशाली खिंचाव वाला स्थान (वैक्यूम क्लीनर) होता है।"}'::jsonb,
  '{"en":"Black holes have so much gravity that they pull everything nearby inside, and nothing—not even light—can escape them!","gu":"બ્લેક હોલનું ગુરુત્વાકર્ષણ એટલું બધું હોય છે કે તે આસપાસની બધી જ વસ્તુઓને પોતાની તરફ ખેંચી લે છે અને પ્રકાશ પણ તેમાંથી બહાર નીકળી શકતો નથી!","hi":"ब्लैक होल का गुरुत्वाकर्षण इतना अधिक होता है कि यह आसपास की हर चीज़ को अंदर खींच लेता है और प्रकाश भी इससे बाहर नहीं निकल पाता है।"}'::jsonb,
  '{"en":"Did you know? Black holes are completely invisible! We can only find them by seeing how stars behave around them.","gu":"શું તમે જાણો છો? બ્લેક હોલ સંપૂર્ણપણે અદ્રશ્ય હોય છે! આપણે તેની આસપાસના તારાના હલનચલન પરથી જ તેની શોધ કરી શકીએ છીએ.","hi":"क्या आपको पता है? ब्लैक होल पूरी तरह से अदृश्य होते हैं! हम केवल उनके आसपास के तारों की हरकतों को देखकर उनका पता लगा सकते हैं।"}'::jsonb,
  'memory',
  true,
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'comet',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Comet","gu":"ધૂમકેતુ","hi":"धूमकेतु"}'::jsonb,
  NULL,
  '/assets/images/space/comet.png',
  NULL,
  '{"en":"Comet! Comets are icy dirtballs with beautiful glowing tails.","gu":"ધૂમકેતુ! ધૂમકેતુ એ સુંદર અને ચમકતી પૂંછડી ધરાવતા બરફીલા ખડકો છે.","hi":"धूमकेतु! धूमकेतु सुंदर और चमकती पूंछ वाले बर्फीले चट्टानी टुकड़े होते हैं।"}'::jsonb,
  '{"en":"Comets are made of ice, dust, and rock. As they get close to the hot sun, they melt and create a glowing tail of gas and dust.","gu":"ધૂમકેતુ બરફ, ધૂળ અને પથ્થરના બનેલા હોય છે. જેમ જેમ તેઓ સૂર્યની નજીક જાય છે તેમ પીગળે છે અને વાયુ તથા ધૂળની ચમકતી પૂંછડી બનાવે છે.","hi":"धूमकेतु बर्फ, धूल और चट्टान से बने होते हैं। जैसे ही वे सूर्य के करीब आते हैं, वे पिघलते हैं और गैस व धूल की एक सुंदर चमकती पूंछ बनाते हैं।"}'::jsonb,
  '{"en":"Did you know? Comets are often called ''dirty snowballs'' because they are mostly made of frozen water, dust, and gases!","gu":"શું તમે જાણો છો? ધૂમકેતુઓને ઘણીવાર ''ગંદા બરફના ગોળા'' પણ કહેવામાં આવે છે કારણ કે તેઓ મોટેભાગે થીજી ગયેલા પાણી અને ધૂળના બનેલા છે!","hi":"क्या आपको पता है? धूमकेतुओं को अक्सर ''गंदे बर्फ के गोले'' भी कहा जाता है क्योंकि वे ज्यादातर जमे हुए पानी और धूल से बने होते हैं!"}'::jsonb,
  'memory',
  true,
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'earth',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Earth","gu":"પૃથ્વી","hi":"पृथ्वी"}'::jsonb,
  NULL,
  '/assets/images/space/earth.png',
  NULL,
  '{"en":"Earth! Earth is our beautiful blue home planet.","gu":"પૃથ્વી! પૃથ્વી એ આપણું સુંદર વાદળી ઘર ગ્રહ છે.","hi":"पृथ्वी! पृथ्वी हमारा सुंदर नीला घर ग्रह है।"}'::jsonb,
  '{"en":"Earth is the third planet from the sun. It has water, air, and the perfect temperature for animals, plants, and humans to live.","gu":"પૃથ્વી સૂર્યથી ત્રીજો ગ્રહ છે. તેમાં પાણી, હવા અને પ્રાણીઓ, વનસ્પતિ તથા મનુષ્યોને જીવવા માટેનું યોગ્ય તાપમાન છે.","hi":"पृथ्वी सूर्य से तीसरा ग्रह है। इसमें पानी, हवा और जानवरों, पौधों व मनुष्यों के रहने के लिए बिल्कुल सही तापमान है।"}'::jsonb,
  '{"en":"Did you know? Earth is the only place in the universe known to support life, and it is covered in 70 percent water!","gu":"શું તમે જાણો છો? બ્રહ્માંડમાં પૃથ્વી એકમાત્ર એવી જગ્યા છે જ્યાં જીવન શક્ય છે અને તે ૭૦ ટકા પાણીથી ઘેરાયેલી છે!","hi":"क्या आपको पता है? ब्रह्मांड में पृथ्वी ही एकमात्र ऐसी जगह है जहाँ जीवन है, और यह 70 प्रतिशत पानी से ढकी हुई है!"}'::jsonb,
  'memory',
  true,
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'galaxy',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Galaxy","gu":"આકાશગંગા","hi":"आकाशगंगा"}'::jsonb,
  NULL,
  '/assets/images/space/galaxy.png',
  NULL,
  '{"en":"Galaxy! A galaxy is a giant city of billions of stars, planets, and dust.","gu":"આકાશગંગા! આકાશગંગા (ગેલેક્સી) એ અબજો તારાઓ, ગ્રહો અને ધૂળનું બનેલું એક વિશાળ શહેર છે.","hi":"आकाशगंगा! आकाशगंगा (गैलेक्सी) अरबों तारों, ग्रहों और धूल से बना एक विशाल शहर है।"}'::jsonb,
  '{"en":"Our solar system belongs to a galaxy called the Milky Way. Galaxies come in different shapes, like spirals and ellipses.","gu":"આપણું સૌરમંડળ મંદાકિની (મિલ્કી વે) નામની આકાશગંગામાં આવેલું છે. આકાશગંગાના વિવિધ આકારો હોય છે જેમ કે સર્પાકાર કે અંડાકાર.","hi":"हमारा सौरमंडल मंदाकिनी (मिल्की वे) नाम की आकाशगंगा में स्थित है। आकाशगंगाएँ अलग-अलग आकारों की होती हैं, जैसे सर्पिलाकार या गोलाकार।"}'::jsonb,
  '{"en":"Did you know? There are billions of galaxies in the universe, and each contains billions of stars!","gu":"શું તમે જાણો છો? બ્રહ્માંડમાં અબજો આકાશગંગાઓ છે અને દરેક આકાશગંગામાં અબજો તારાઓ આવેલા છે!","hi":"क्या आपको पता है? ब्रह्मांड में अरबों आकाशगंगाएँ हैं, और प्रत्येक आकाशगंगा में अरबों तारे हैं!"}'::jsonb,
  'memory',
  true,
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'jupiter',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Jupiter","gu":"ગુરુ","hi":"बृहस्पति"}'::jsonb,
  NULL,
  '/assets/images/space/jupiter.png',
  NULL,
  '{"en":"Jupiter! Jupiter is the biggest planet in our solar system.","gu":"ગુરુ! ગુરુ એ આપણા સૌરમંડળનો સૌથી મોટો ગ્રહ છે.","hi":"बृहस्पति! बृहस्पति हमारे सौरमंडल का सबसे बड़ा ग्रह है।"}'::jsonb,
  '{"en":"Jupiter is a giant ball of gas. It is so big that all the other planets in our solar system could fit inside it!","gu":"ગુરુ એ વાયુનો બનેલો એક વિશાળ ગોળો છે. તે એટલો મોટો છે કે સૌરમંડળના અન્ય તમામ ગ્રહો તેની અંદર સમાઈ શકે છે!","hi":"बृहस्पति गैस का एक विशाल गोला है। यह इतना बड़ा है कि हमारे सौरमंडल के अन्य सभी ग्रह इसके अंदर समा सकते हैं!"}'::jsonb,
  '{"en":"Did you know? Jupiter has a giant red spot which is actually a storm that has been spinning for hundreds of years!","gu":"શું તમે જાણો છો? ગુરુ પર એક મોટો લાલ ડાઘ છે જે વાસ્તવમાં સેંકડો વર્ષોથી ચાલતું એક ચક્રવાતી તોફાન છે!","hi":"क्या आपको पता है? बृहस्पति पर एक बड़ा लाल धब्बा है जो वास्तव में सैकड़ों वर्षों से चल रहा एक विशाल तूफान है!"}'::jsonb,
  'memory',
  true,
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mars',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Mars","gu":"મંગળ","hi":"मंगल"}'::jsonb,
  NULL,
  '/assets/images/space/mars.png',
  NULL,
  '{"en":"Mars! Mars is known as the ''Red Planet'' because of its rusty soil.","gu":"મંગળ! મંગળ તેની લાલ માટીના કારણે ''લાલ ગ્રહ'' તરીકે જાણીતો છે.","hi":"मंगल! मंगल अपनी लाल मिट्टी के कारण ''लाल ग्रह'' के रूप में जाना जाता है।"}'::jsonb,
  '{"en":"Mars is a cold, rocky planet next to Earth. Scientists send robotic rovers to Mars to explore its mountains and valleys.","gu":"મંગળ એ પૃથ્વીની બાજુમાં આવેલો એક ઠંડો અને પથ્થરવાળો ગ્રહ છે. વૈજ્ઞાનિકો તેના પર્વતોની શોધ માટે રોબોટ મોકલે છે.","hi":"मंगल पृथ्वी के बगल में स्थित एक ठंडा और चट्टानी ग्रह है। वैज्ञानिक इसकी खोज के लिए रोबोटिक रोवर भेजते हैं।"}'::jsonb,
  '{"en":"Did you know? Mars is home to Olympus Mons, the tallest volcano in the entire solar system—it is three times taller than Mount Everest!","gu":"શું તમે જાણો છો? મંગળ પર ઓલિમ્પસ મોન્સ આવેલો છે, જે સૌરમંડળનો સૌથી ઊંચો જ્વાળામુખી છે અને માઉન્ટ એવરેસ્ટ કરતાં ત્રણ ગણો મોટો છે!","hi":"क्या आपको पता है? मंगल पर ओलंपस मॉन्स स्थित है, जो पूरे सौरमंडल का सबसे ऊँचा ज्वालामुखी है—यह माउंट एवरेस्ट से तीन गुना ऊँचा है!"}'::jsonb,
  'memory',
  true,
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mercury',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Mercury","gu":"બુધ","hi":"बुध"}'::jsonb,
  NULL,
  '/assets/images/space/mercury.png',
  NULL,
  '{"en":"Mercury! Mercury is the smallest planet and the closest one to the sun.","gu":"બુધ! બુધ એ સૂર્યની સૌથી નજીક આવેલો અને સૌરમંડળનો સૌથી નાનો ગ્રહ છે.","hi":"बुध! बुध सूर्य के सबसे निकट और सौरमंडल का सबसे छोटा ग्रह है।"}'::jsonb,
  '{"en":"Because it is so close to the sun, Mercury gets very hot during the day but freezes cold at night because it has no air to trap heat.","gu":"સૂર્યની ખૂબ નજીક હોવાથી બુધ દિવસ દરમિયાન અતિશય ગરમ થઈ જાય છે, પરંતુ રાત્રે થીજી જાય છે કારણ કે ત્યાં હવા નથી.","hi":"सूर्य के बहुत करीब होने के कारण, बुध दिन में बहुत गर्म हो जाता है लेकिन रात में जम जाता है क्योंकि वहाँ हवा नहीं है।"}'::jsonb,
  '{"en":"Did you know? A year on Mercury is very short! It takes just 88 Earth days to travel all the way around the sun!","gu":"શું તમે જાણો છો? બુધ પરનું એક વર્ષ ખૂબ જ ટૂંકું હોય છે! તેને સૂર્યની પ્રદક્ષિણા પૂરી કરવામાં માત્ર ૮૮ દિવસ લાગે છે!","hi":"क्या आपको पता है? बुध पर एक साल बहुत छोटा होता है! इसे सूर्य की परिक्रमा पूरी करने में केवल 88 दिन लगते हैं!"}'::jsonb,
  'memory',
  true,
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'meteor',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Meteor","gu":"ઉલ્કા","hi":"उल्का"}'::jsonb,
  NULL,
  '/assets/images/space/meteor.png',
  NULL,
  '{"en":"Meteor! Meteors are bright streaks of light in the night sky, often called ''shooting stars''.","gu":"ઉલ્કા! ઉલ્કા એ રાત્રિના આકાશમાં દેખાતો પ્રકાશનો એક ચમકારો છે, જેને લોકો ''ખરતો તારો'' પણ કહે છે.","hi":"उल्का! उल्का रात के आकाश में दिखाई देने वाली रोशनी की एक लकीर होती है, जिसे अक्सर ''टूटता तारा'' भी कहा जाता है।"}'::jsonb,
  '{"en":"A meteor happens when a tiny space rock enters Earth''s air at high speed and burns up, creating a beautiful flash of light.","gu":"જ્યારે અવકાશનો કોઈ નાનો પથ્થર પૃથ્વીના વાતાવરણમાં ખૂબ જ ઝડપથી પ્રવેશ કરે છે અને બળી જાય છે, ત્યારે પ્રકાશનો ચમકારો ઉલ્કા સર્જે છે.","hi":"जब अंतरिक्ष का एक छोटा पत्थर पृथ्वी के वायुमंडल में बहुत तेज़ी से प्रवेश करता है और जल जाता है, तो रोशनी की एक लकीर बनती है जिसे उल्का कहते हैं।"}'::jsonb,
  '{"en":"Did you know? Most meteors are very tiny, about the size of a grain of sand, and they burn up completely before reaching the ground!","gu":"શું તમે જાણો છો? મોટાભાગની ઉલ્કાઓ ખૂબ જ નાની રેતીના દાણા જેવી હોય છે અને જમીન પર પહોંચતા પહેલા જ બળીને ખાખ થઈ જાય છે!","hi":"क्या आपको पता है? अधिकांश उल्काएं बहुत छोटी होती हैं, लगभग रेत के दाने जितनी, और वे जमीन पर पहुँचने से पहले ही पूरी तरह जल जाती हैं!"}'::jsonb,
  'memory',
  true,
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'meteorite',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Meteorite","gu":"ઉલ્કાપિંડ","hi":"उल्कापिंड"}'::jsonb,
  NULL,
  '/assets/images/space/meteorite.png',
  NULL,
  '{"en":"Meteorite! A meteorite is a space rock that survived its journey and landed on Earth.","gu":"ઉલ્કાપિંડ! ઉલ્કાપિંડ એ અવકાશનો એવો પથ્થર છે જે પૃથ્વીના વાતાવરણમાં બળ્યા વગર બચીને જમીન પર પડે છે.","hi":"उल्कापिंड! उल्कापिंड अंतरिक्ष का वह पत्थर होता है जो पृथ्वी के वायुमंडल में पूरी तरह जले बिना जमीन पर गिरता है।"}'::jsonb,
  '{"en":"Meteors burn up in the air, but sometimes a larger rock survives the heat and crashes onto the ground. Scientists study them to learn about space!","gu":"ઉલ્કા હવામાં બળી જાય છે, પરંતુ ક્યારેક મોટા ખડકો બચીને જમીન પર પટકાય છે. વૈજ્ઞાનિકો અવકાશને સમજવા માટે તેનો અભ્યાસ કરે છે!","hi":"उल्काएं हवा में जल जाती हैं, लेकिन कभी-कभी बड़ा पत्थर बचकर जमीन से टकराता है। वैज्ञानिक अंतरिक्ष को समझने के लिए इनका अध्ययन करते हैं!"}'::jsonb,
  '{"en":"Did you know? When a very large meteorite hits the ground, it can create a giant bowl-shaped hole called a crater!","gu":"શું તમે જાણો છો? જ્યારે કોઈ મોટો ઉલ્કાપિંડ જમીન પર પડે છે, ત્યારે તે એક મોટો ખાડો બનાવે છે જેને ક્રેટર કહેવાય છે!","hi":"क्या आपको पता है? जब कोई बहुत बड़ा उल्कापिंड जमीन से टकराता है, तो वह एक बड़ा कटोरे जैसा गड्ढा बनाता है जिसे क्रेटर कहते हैं!"}'::jsonb,
  'memory',
  true,
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'moon',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Moon","gu":"ચંદ્ર","hi":"चंद्रमा"}'::jsonb,
  NULL,
  '/assets/images/space/moon.png',
  NULL,
  '{"en":"Moon! The moon is Earth''s loyal neighbor that shines in the night sky.","gu":"ચંદ્ર! ચંદ્ર એ આપણો પાડોશી ઉપગ્રહ છે જે રાત્રિના આકાશમાં સુંદર રીતે ચમકે છે.","hi":"चंद्रमा! चंद्रमा हमारी पृथ्वी का वफादार साथी है जो रात के आकाश में चमकता है।"}'::jsonb,
  '{"en":"The moon is a rocky sphere that orbits Earth. It does not make its own light; it reflects light from the sun like a mirror!","gu":"ચંદ્ર એ પથ્થરનો ગોળો છે જે પૃથ્વીની આસપાસ ફરે છે. તેનો પોતાનો પ્રકાશ હોતો નથી; તે અરીસાની જેમ સૂર્યપ્રકાશ પરાવર્તિત કરે છે!","hi":"चंद्रमा एक चट्टानी गोला है जो पृथ्वी की परिक्रमा करता है। इसका अपना प्रकाश नहीं होता; यह शीशे की तरह सूर्य के प्रकाश को चमकाता है!"}'::jsonb,
  '{"en":"Did you know? The shape of the moon seems to change every night, but it is actually just the sun lighting up different parts of it!","gu":"શું તમે જાણો છો? ચંદ્રનો આકાર રોજ બદલાતો લાગે છે, પરંતુ વાસ્તવમાં સૂર્યપ્રકાશ તેના અલગ-અલગ ભાગ પર પડવાને કારણે એવું દેખાય છે!","hi":"क्या आपको पता है? हर रात चंद्रमा का आकार बदलता हुआ लगता है, लेकिन वास्तव में सूरज की रोशनी इसके अलग-अलग हिस्सों को चमकाती है!"}'::jsonb,
  'memory',
  true,
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'nebula',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Nebula","gu":"તેજોમેઘ","hi":"निहारिका"}'::jsonb,
  NULL,
  '/assets/images/space/nebula.png',
  NULL,
  '{"en":"Nebula! Nebulae are giant, colorful clouds of dust and gas in space.","gu":"તેજોમેઘ! તેજોમેઘ એ અવકાશમાં ધૂળ અને વાયુના બનેલા સુંદર રંગબેરંગી વાદળો છે.","hi":"निहारिका! निहारिका अंतरिक्ष में धूल और गैस के सुंदर रंग-बिरंगे बादल होते हैं।"}'::jsonb,
  '{"en":"Nebulae are where new stars are born! Dust and gas clump together until they get hot enough to shine brightly.","gu":"તેજોમેઘ એ જગ્યા છે જ્યાં નવા તારાઓનો જન્મ થાય છે! ધૂળ અને વાયુ એકઠા થાય છે અને ગરમ થઈને તારા તરીકે ચમકવા લાગે છે.","hi":"निहारिका वह स्थान है जहाँ नए तारे पैदा होते हैं! धूल और गैस आपस में जुड़ते हैं और गर्म होकर तारों के रूप में चमकने लगते हैं।"}'::jsonb,
  '{"en":"Did you know? Nebulae come in amazing shapes and are named after things they look like, like the Butterfly Nebula!","gu":"શું તમે જાણો છો? તેજોમેઘના આકારો અદ્ભુત હોય છે અને તે જેવા દેખાય છે તેના પરથી તેનું નામ રાખવામાં આવે છે, જેમ કે પતંગિયા આકારનો તેજોમેઘ!","hi":"क्या आपको पता है? निहारिकाएं अद्भुत आकारों की होती हैं और उनका नाम उनके आकार पर रखा जाता है, जैसे तितली निहारिका!"}'::jsonb,
  'memory',
  true,
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'neptune',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Neptune","gu":"નેપ્ચ્યુન","hi":"नेपच्यून"}'::jsonb,
  NULL,
  '/assets/images/space/neptune.png',
  NULL,
  '{"en":"Neptune! Neptune is a freezing cold, dark blue planet far away.","gu":"નેપ્ચ્યુન! નેપ્ચ્યુન એ સૂર્યથી ખૂબ જ દૂર આવેલો થીજી ગયેલો ઘેરો વાદળી રંગનો ગ્રહ છે.","hi":"नेपच्यून! नेपच्यून सूर्य से बहुत दूर स्थित एक बहुत ही ठंडा और नीले रंग का ग्रह है।"}'::jsonb,
  '{"en":"Neptune is the eighth and farthest planet from the sun. It is a gas giant with the strongest, fastest winds in the solar system!","gu":"નેપ્ચ્યુન સૂર્યથી આઠમો અને સૌથી છેલ્લો ગ્રહ છે. તે એક વાયુ ગ્રહ છે જ્યાં સૌરમંડળના સૌથી વધુ તીવ્ર અને ઝડપી પવનો ફૂંકાય છે!","hi":"नेपच्यून सूर्य से आठवां और सबसे दूर का ग्रह है। यह एक गैस का गोला है जहाँ सौरमंडल में सबसे तेज़ हवाएँ चलती हैं!"}'::jsonb,
  '{"en":"Did you know? Neptune is so far away that it takes about 165 Earth years just to orbit the sun once!","gu":"શું તમે જાણો છો? નેપ્ચ્યુન સૂર્યથી એટલો દૂર છે કે તેને સૂર્યની એક પ્રદક્ષિણા પૂરી કરવામાં ૧૬૫ વર્ષ લાગે છે!","hi":"क्या आपको पता है? नेपच्यून सूर्य से इतनी दूर है कि इसे सूर्य की एक परिक्रमा पूरी करने में 165 साल लगते हैं!"}'::jsonb,
  'memory',
  true,
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pluto',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Pluto","gu":"પ્લુટો","hi":"प्लेटो"}'::jsonb,
  NULL,
  '/assets/images/space/pluto.png',
  NULL,
  '{"en":"Pluto! Pluto is a tiny, icy dwarf planet at the edge of our solar system.","gu":"પ્લુટો! પ્લુટો એ સૌરમંડળની ધાર પર આવેલો એક નાનો અને બરફીલો વામન ગ્રહ છે.","hi":"प्लेटो! प्लेटो हमारे सौरमंडल के छोर पर स्थित एक छोटा और बर्फीला बौना ग्रह है।"}'::jsonb,
  '{"en":"Pluto used to be the ninth planet, but scientists renamed it a ''dwarf planet'' because it is smaller than our moon and very icy.","gu":"પ્લુટો પહેલા નવમો ગ્રહ ગણાતો હતો, પણ વૈજ્ઞાનિકોએ તેને ''વામન ગ્રહ'' (ડ્વાર્ફ પ્લેનેટ) તરીકે ઓળખાવ્યો કારણ કે તે ચંદ્રથી પણ નાનો છે.","hi":"प्लेटो पहले नौवां ग्रह माना जाता था, लेकिन वैज्ञानिकों ने इसे ''बौना ग्रह'' घोषित किया क्योंकि यह हमारे चंद्रमा से भी छोटा और बर्फीला है।"}'::jsonb,
  '{"en":"Did you know? Pluto has a giant glacier on its surface shaped like a beautiful heart!","gu":"શું તમે જાણો છો? પ્લુટોની સપાટી પર બરફનો એક મોટો હિસ્સો છે જે સુંદર દિલ (હાર્ટ) ના આકાર જેવો દેખાય છે!","hi":"क्या आपको पता है? प्लेटो की सतह पर बर्फ का एक विशाल हिस्सा है जो देखने में एक सुंदर दिल के आकार जैसा लगता है!"}'::jsonb,
  'memory',
  true,
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rocket',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Rocket","gu":"રોકેટ","hi":"रॉकेट"}'::jsonb,
  NULL,
  '/assets/images/space/rocket.png',
  NULL,
  '{"en":"Rocket! Rockets are super fast vehicles that carry astronauts into space.","gu":"રોકેટ! રોકેટ એ અવકાશયાત્રીઓને અંતરિક્ષમાં લઈ જતું એક અતિ ઝડપી વાહન છે.","hi":"रॉकेट! रॉकेट बहुत तेज़ वाहन होते हैं जो अंतरिक्ष यात्रियों को अंतरिक्ष में ले जाते हैं।"}'::jsonb,
  '{"en":"Rockets burn fuel to create a giant flame, pushing them up into the sky with enough power to escape Earth''s gravity.","gu":"રોકેટ બળતણ સળગાવીને પાછળથી અગ્નિ છોડે છે, જેનાથી પૃથ્વીના ગુરુત્વાકર્ષણમાંથી બહાર નીકળવા માટે તેને પુષ્કળ બળ મળે છે.","hi":"रॉकेट ईंधन जलाकर पीछे से आग की लपटें छोड़ते हैं, जिससे उन्हें पृथ्वी के गुरुत्वाकर्षण से बाहर निकलने की शक्ति मिलती है।"}'::jsonb,
  '{"en":"Did you know? Rockets must travel at over 17,500 miles per hour to successfully launch into space!","gu":"શું તમે જાણો છો? અંતરિક્ષમાં સફળતાપૂર્વક જવા માટે રોકેટની ઝડપ કલાકના ૨૮,૦૦૦ કિલોમીટરથી વધુ હોવી જોઈએ!","hi":"क्या आपको पता है? अंतरिक्ष में जाने के लिए रॉकेट को 28,000 किलोमीटर प्रति घंटे से भी अधिक की गति से यात्रा करनी होती है!"}'::jsonb,
  'memory',
  true,
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'satellite',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Satellite","gu":"કૃત્રિમ ઉપગ્રહ","hi":"उपग्रह"}'::jsonb,
  NULL,
  '/assets/images/space/satellite.png',
  NULL,
  '{"en":"Satellite! Satellites are smart machines orbiting Earth to help us communicate.","gu":"કૃત્રિમ ઉપગ્રહ! ઉપગ્રહો પૃથ્વીની આસપાસ ફરતા હોશિયાર મશીનો છે જે વાતચીત અને માહિતી મોકલવામાં મદદ કરે છે.","hi":"उपग्रह! उपग्रह पृथ्वी की परिक्रमा करने वाली मशीनें होती हैं जो संचार और मौसम की जानकारी में मदद करती हैं।"}'::jsonb,
  '{"en":"Satellites take pictures of Earth, help with weather forecasts, and transmit TV and internet signals around the world.","gu":"કૃત્રિમ ઉપગ્રહો પૃથ્વીના ફોટા લે છે, હવામાનની આગાહી કરે છે અને ટીવી તથા ઇન્ટરનેટના સિગ્નલ આખી દુનિયામાં મોકલે છે.","hi":"उपग्रह पृथ्वी की तस्वीरें लेते हैं, मौसम का पूर्वानुमान लगाने में मदद करते हैं और टीवी व इंटरनेट के सिग्नल भेजते हैं।"}'::jsonb,
  '{"en":"Did you know? The first artificial satellite was Sputnik 1, launched into space by the Soviet Union in 1957!","gu":"શું તમે જાણો છો? દુનિયાનો સૌપ્રથમ કૃત્રિમ ઉપગ્રહ સ્પુતનિક ૧ હતો, જે ૧૯૫૭ માં રશિયા દ્વારા અંતરિક્ષમાં મોકલવામાં આવ્યો હતો!","hi":"क्या आपको पता है? पहला कृत्रिम उपग्रह स्पुतनिक 1 था, जिसे 1957 में सोवियत संघ द्वारा अंतरिक्ष में भेजा गया था!"}'::jsonb,
  'memory',
  true,
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'saturn',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Saturn","gu":"શનિ","hi":"शनि"}'::jsonb,
  NULL,
  '/assets/images/space/saturn.png',
  NULL,
  '{"en":"Saturn! Saturn is a beautiful planet famous for its bright, wide rings.","gu":"શનિ! શનિ એ તેના સુંદર તેજસ્વી વલયો (રિંગ્સ) માટે જાણીતો અદ્ભુત ગ્રહ છે.","hi":"शनि! शनि अपने सुंदर चमकीले छल्लों (रिंग्स) के लिए प्रसिद्ध एक खूबसूरत ग्रह है।"}'::jsonb,
  '{"en":"Saturn is a gas giant with rings made of billions of pieces of ice, dust, and rocks orbiting the planet.","gu":"શનિ એ વાયુનો બનેલો ગ્રહ છે, જેના વલયો સૂર્યપ્રકાશમાં ચમકતા બરફના ટુકડા અને ધૂળના બનેલા છે.","hi":"शनि गैस का एक गोला है जिसके छल्ले बर्फ के टुकड़ों और धूल से बने हैं जो ग्रह की परिक्रमा करते हैं।"}'::jsonb,
  '{"en":"Did you know? Saturn is so light because it is mostly gas; if you could find a bathtub big enough, Saturn would float in it!","gu":"શું તમે જાણો છો? શનિ વાયુનો બનેલો હોવાથી ખૂબ હલકો છે; જો પૃથ્વી જેટલું મોટું ટબ મળે તો શનિ પાણી પર તરી શકે!","hi":"क्या आपको पता है? शनि बहुत हल्का है क्योंकि यह ज्यादातर गैस से बना है; यदि कोई बहुत बड़ा टब हो, तो शनि पानी पर तैरने लगेगा!"}'::jsonb,
  'memory',
  true,
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'space_capsule',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Space Capsule","gu":"સ્પેસ કેપ્સ્યુલ","hi":"अंतरिक्ष कैप्सूल"}'::jsonb,
  NULL,
  '/assets/images/space/space_capsule.png',
  NULL,
  '{"en":"Space Capsule! A space capsule is a small cabin that carries astronauts back home.","gu":"સ્પેસ કેપ્સ્યુલ! સ્પેસ કેપ્સ્યુલ એ એક નાની કેબિન છે જે અંતરિક્ષમાંથી અવકાશયાત્રીઓને પૃથ્વી પર પાછા લાવે છે.","hi":"अंतरिक्ष कैप्सूल! अंतरिक्ष कैप्सूल एक छोटा केबिन होता है जो अंतरिक्ष यात्रियों को वापस धरती पर लाता है।"}'::jsonb,
  '{"en":"Space capsules sit on top of rockets. They protect astronauts from extreme heat as they crash back down through Earth''s atmosphere.","gu":"સ્પેસ કેપ્સ્યુલ રોકેટની ટોચ પર બેસે છે. તે પૃથ્વીના વાતાવરણમાં પાછા પ્રવેશતી વખતે થતી અતિશય ગરમી સામે અવકાશયાત્રીઓનું રક્ષણ કરે છે.","hi":"अंतरिक्ष कैप्सूल रॉकेट के शीर्ष पर स्थित होता है। यह पृथ्वी के वायुमंडल में प्रवेश करते समय अंतरिक्ष यात्रियों को अत्यधिक गर्मी से बचाता है।"}'::jsonb,
  '{"en":"Did you know? Space capsules use giant parachutes to slow down and splash safely into the ocean when landing!","gu":"શું તમે જાણો છો? સ્પેસ કેપ્સ્યુલ પૃથ્વી પર ઉતરતી વખતે ઝડપ ઘટાડવા માટે વિશાળ પેરાશૂટનો ઉપયોગ કરે છે અને દરિયામાં સુરક્ષિત રીતે ઉતરે છે!","hi":"क्या आपको पता है? अंतरिक्ष कैप्सूल उतरते समय गति धीमी करने के लिए बड़े पैराशूट का उपयोग करते हैं और समुद्र में सुरक्षित रूप से गिरते हैं!"}'::jsonb,
  'memory',
  true,
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'space_shuttle',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Space Shuttle","gu":"સ્પેસ શટલ","hi":"अंतरिक्ष शटल"}'::jsonb,
  NULL,
  '/assets/images/space/space_shuttle.png',
  NULL,
  '{"en":"Space Shuttle! The space shuttle was a reusable space plane.","gu":"સ્પેસ શટલ! સ્પેસ શટલ એ વારંવાર વાપરી શકાય તેવું એક સ્પેસ પ્લેન (અવકાશયાન) હતું.","hi":"अंतरिक्ष शटल! अंतरिक्ष शटल बार-बार उपयोग किया जाने वाला एक अंतरिक्ष विमान था।"}'::jsonb,
  '{"en":"Space shuttles launched like rockets into space, orbited Earth like a satellite, and landed back on a runway like an airplane.","gu":"સ્પેસ શટલ રોકેટની જેમ અંતરિક્ષમાં જતું, પૃથ્વીની પ્રદક્ષિણા કરતું અને પાછા ફરતી વખતે વિમાનની જેમ રનવે પર ઉતરાણ કરતું.","hi":"अंतरिक्ष शटल रॉकेट की तरह अंतरिक्ष में जाते थे, पृथ्वी की परिक्रमा करते थे और वापस आते समय विमान की तरह रनवे पर उतरते थे।"}'::jsonb,
  '{"en":"Did you know? NASA''s space shuttles flew 135 missions to carry satellites, space labs, and build the space station!","gu":"શું તમે જાણો છો? નાસાના સ્પેસ શટલોએ ઉપગ્રહો અને સ્પેસ લેબ લઈ જવા માટે તથા સ્પેસ સ્ટેશન બનાવવા માટે ૧૩૫ થી વધુ મિશન પૂર્ણ કર્યા હતા!","hi":"क्या आपको पता है? नासा के अंतरिक्ष शटल ने उपग्रहों और अंतरिक्ष प्रयोगशालाओं को ले जाने के लिए 135 मिशन उड़ाए थे!"}'::jsonb,
  'memory',
  true,
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'space_station',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Space Station","gu":"અંતરિક્ષ મથક","hi":"अंतरिक्ष स्टेशन"}'::jsonb,
  NULL,
  '/assets/images/space/space_station.png',
  NULL,
  '{"en":"Space Station! A space station is a giant floating house and science lab in space.","gu":"અંતરિક્ષ મથક! સ્પેસ સ્ટેશન એ અંતરિક્ષમાં તરતું એક મોટું ઘર અને વિજ્ઞાનની પ્રયોગશાળા છે.","hi":"अंतरिक्ष स्टेशन! अंतरिक्ष स्टेशन अंतरिक्ष में तैरता हुआ एक बड़ा घर और विज्ञान प्रयोगशाला है।"}'::jsonb,
  '{"en":"Astronauts live and work on the space station for months, doing experiments to learn how humans can live in outer space.","gu":"અવકાશયાત્રીઓ સ્પેસ સ્ટેશન પર મહિનાઓ સુધી રહે છે અને પ્રયોગો કરે છે જેથી જાણી શકાય કે માણસો અંતરિક્ષમાં કેવી રીતે રહી શકે.","hi":"अंतरिक्ष यात्री अंतरिक्ष स्टेशन पर महीनों तक रहते हैं और प्रयोग करते हैं ताकि जाना जा सके कि मनुष्य अंतरिक्ष में कैसे रह सकते हैं।"}'::jsonb,
  '{"en":"Did you know? The International Space Station is as big as a football field, and it orbits the Earth 16 times every single day!","gu":"શું તમે જાણો છો? ઇન્ટરનેશનલ સ્પેસ સ્ટેશન ફૂટબોલના મેદાન જેટલું મોટું છે અને તે દરરોજ પૃથ્વીની આસપાસ ૧૬ ચક્કર લગાવે છે!","hi":"क्या आपको पता है? अंतर्राष्ट्रीय अंतरिक्ष स्टेशन एक फुटबॉल मैदान जितना बड़ा है, और यह हर दिन पृथ्वी के 16 चक्कर लगाता है!"}'::jsonb,
  'memory',
  true,
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'star',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Star","gu":"તારો","hi":"तारा"}'::jsonb,
  NULL,
  '/assets/images/space/star.png',
  NULL,
  '{"en":"Star! Stars are giant glowing balls of hot gas in space.","gu":"તારો! તારાઓ એ અવકાશમાં ધગધગતા વાયુના બનેલા સુંદર ચમકતા ગોળાઓ છે.","hi":"तारा! तारे अंतरिक्ष में गर्म गैस के चमकते हुए विशाल गोले होते हैं।"}'::jsonb,
  '{"en":"Stars make their own light and heat. They look tiny to us because they are very, very far away.","gu":"તારા પોતાનો પ્રકાશ અને ગરમી ઉત્પન્ન કરે છે. તેઓ આપણાથી કરોડો કિલોમીટર દૂર હોવાથી આપણને ખૂબ નાના ટપકાં જેવા દેખાય છે.","hi":"तारे अपना प्रकाश और गर्मी खुद बनाते हैं। वे हमसे बहुत दूर होने के कारण छोटे टिमटिमाते बिंदुओं जैसे दिखते हैं।"}'::jsonb,
  '{"en":"Did you know? Stars come in different colors depending on their temperature; blue stars are hot, and red stars are cooler!","gu":"શું તમે જાણો છો? તારાઓના રંગ તેમના તાપમાન મુજબ અલગ-અલગ હોય છે; વાદળી તારા અતિશય ગરમ હોય છે અને લાલ તારા થોડા ઓછા ગરમ હોય છે!","hi":"क्या आपको पता है? तारों के रंग उनके तापमान पर निर्भर करते हैं; नीले तारे बहुत गर्म होते हैं, और लाल तारे थोड़े कम गर्म होते हैं!"}'::jsonb,
  'memory',
  true,
  21
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sun',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Sun","gu":"સૂર્ય","hi":"सूरज"}'::jsonb,
  NULL,
  '/assets/images/space/sun.png',
  NULL,
  '{"en":"Sun! The sun is our solar system''s own bright star.","gu":"સૂર્ય! સૂર્ય એ આપણા સૌરમંડળનો પોતાનો તેજસ્વી તારો છે.","hi":"सूरज! सूरज हमारे सौरमंडल का अपना एक बड़ा चमकीला तारा है।"}'::jsonb,
  '{"en":"The sun is at the center of our solar system. It gives Earth light and heat, which all plants and animals need to live.","gu":"સૂર્ય આપણા સૌરમંડળની વચ્ચે આવેલો છે. તે પૃથ્વીને પ્રકાશ અને ગરમી આપે છે, જે વનસ્પતિ અને પ્રાણીઓને જીવવા માટે જરૂરી છે.","hi":"सूरज हमारे सौरमंडल के केंद्र में स्थित है। यह पृथ्वी को प्रकाश और गर्मी देता है, जिसकी आवश्यकता सभी जीवों को होती है।"}'::jsonb,
  '{"en":"Did you know? The sun is huge, but it is actually just a medium-sized star compared to other stars in the galaxy!","gu":"શું તમે જાણો છો? સૂર્ય ઘણો મોટો છે, પરંતુ બ્રહ્માંડના અન્ય તારાઓની સરખામણીમાં તે મધ્યમ કદનો તારો છે!","hi":"क्या आपको पता है? सूरज बहुत बड़ा है, लेकिन ब्रह्मांड के अन्य तारों की तुलना में यह केवल एक मध्यम आकार का तारा है!"}'::jsonb,
  'memory',
  true,
  22
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'telescope',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Telescope","gu":"ટેલિસ્કોપ","hi":"दूरबीन"}'::jsonb,
  NULL,
  '/assets/images/space/telescope.png',
  NULL,
  '{"en":"Telescope! Telescopes are instruments that make distant space objects look close and clear.","gu":"ટેલિસ્કોપ! ટેલિસ્કોપ એ દૂર આવેલી અંતરિક્ષની વસ્તુઓને નજીક અને સ્પષ્ટ બતાવતું એક સાધન છે.","hi":"दूरबीन! दूरबीन (टेलीस्कोप) वह यंत्र होता है जो दूर की अंतरिक्ष वस्तुओं को पास और स्पष्ट दिखाता है।"}'::jsonb,
  '{"en":"Telescopes use lenses and mirrors to collect light. Astronomers use them to study planets, stars, and faraway galaxies.","gu":"ટેલિસ્કોપ પ્રકાશ એકઠો કરવા કાચ (લેન્સ) નો ઉપયોગ કરે છે. વૈજ્ઞાનિકો તેની મદદથી ગ્રહો, તારા અને આકાશગંગાઓનો અભ્યાસ કરે છે.","hi":"दूरबीन प्रकाश को इकट्ठा करने के लिए शीशों का उपयोग करती है। वैज्ञानिक इसके द्वारा ग्रहों, तारों और आकाशगंगाओं का अध्ययन करते हैं।"}'::jsonb,
  '{"en":"Did you know? The famous Hubble Space Telescope is actually floating in space, taking stunning photos without blurry atmosphere!","gu":"શું તમે જાણો છો? પ્રખ્યાત હબલ સ્પેસ ટેલિસ્કોપ અંતરિક્ષમાં તરી રહ્યું છે અને પૃથ્વીના વાતાવરણની દખલ વગર અદ્ભુત ફોટા મોકલે છે!","hi":"क्या आपको पता है? प्रसिद्ध हबल टेलीस्कोप वास्तव में अंतरिक्ष में तैर रहा है और धुंधले वातावरण के बिना अंतरिक्ष की अद्भुत तस्वीरें लेता है!"}'::jsonb,
  'memory',
  true,
  23
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ufo',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"UFO","gu":"યુ.એફ.ઓ.","hi":"यूएफओ"}'::jsonb,
  NULL,
  '/assets/images/space/ufo.png',
  NULL,
  '{"en":"UFO! UFO stands for Unidentified Flying Object.","gu":"યુ.એફ.ઓ.! યુ.એફ.ઓ. એટલે અજાણી ઉડતી વસ્તુ (અનઆઇડેન્ટિફાઇડ ફ્લાઇંગ ઓબ્જેક્ટ).","hi":"यूएफओ! यूएफओ का मतलब अज्ञात उड़ती वस्तु (अनाइडेंटिफाइड फ्लाइंग ऑब्जेक्ट) होता है।"}'::jsonb,
  '{"en":"A UFO is anything flying in the sky that cannot be identified. People often connect UFOs with stories of aliens and spaceships!","gu":"આકાશમાં ઉડતી કોઈપણ એવી વસ્તુ જેને ઓળખી ન શકાય તેને યુ.એફ.ઓ. કહેવાય છે. લોકો તેને ઘણીવાર બીજા ગ્રહના જીવો (એલિયન) સાથે જોડે છે!","hi":"आकाश में उड़ती कोई भी ऐसी वस्तु जिसे पहचाना न जा सके उसे यूएफओ कहते हैं। लोग अक्सर इसे दूसरे ग्रह के जीवों से जोड़कर देखते हैं!"}'::jsonb,
  '{"en":"Did you know? Most UFO sightings turn out to be weather balloons, planes, or bright stars when investigated closely!","gu":"શું તમે જાણો છો? તપાસ કરવા પર મોટાભાગના યુ.એફ.ઓ. વાસ્તવમાં હવામાન બલૂન, વિમાન કે તેજસ્વી તારા જ સાબિત થાય છે!","hi":"क्या आपको पता है? जाँच करने पर अधिकांश यूएफओ वास्तव में मौसम के गुब्बारे, विमान या चमकीले तारे ही निकलते हैं!"}'::jsonb,
  'memory',
  true,
  24
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'uranus',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Uranus","gu":"યુરેનસ","hi":"अरुण"}'::jsonb,
  NULL,
  '/assets/images/space/uranus.png',
  NULL,
  '{"en":"Uranus! Uranus is a freezing cold, light blue gas planet.","gu":"યુરેનસ! યુરેનસ એ ખૂબ જ ઠંડો અને આછા વાદળી રંગનો વાયુ ગ્રહ છે.","hi":"अरुण! अरुण (यूरेनस) बहुत ही ठंडा और हल्के नीले रंग का गैस का गोला है।"}'::jsonb,
  '{"en":"Uranus is the seventh planet from the sun. It has faint rings and is unique because it spins sideways like a rolling ball!","gu":"યુરેનસ સૂર્યથી સાતમો ગ્રહ છે. તેને પણ ઝાંખા વલયો છે અને તે સૌરમંડળનો એકમાત્ર એવો ગ્રહ છે જે આડો નમીને દડાની જેમ ફરે છે!","hi":"अरुण सूर्य से सातवां ग्रह है। इसके चारों ओर धुंधले छल्ले हैं और यह इकलौता ग्रह है जो अपनी धुरी पर गेंद की तरह लेटा हुआ घूमता है!"}'::jsonb,
  '{"en":"Did you know? Uranus is the coldest planet in the solar system, with temperatures dropping to minus 224 degrees Celsius!","gu":"શું તમે જાણો છો? યુરેનસ સૌરમંડળનો સૌથી ઠંડો ગ્રહ છે, જ્યાં તાપમાન માઈનસ ૨૨૪ ડિગ્રી સેલ્સિયસ સુધી ઘટી જાય છે!","hi":"क्या आपको पता है? अरुण सौरमंडल का सबसे ठंडा ग्रह है, जहाँ तापमान शून्य से नीचे 224 डिग्री सेल्सियस तक गिर जाता है!"}'::jsonb,
  'memory',
  true,
  25
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

INSERT INTO public.space 
(topic_key, category_id, name, svg_path, image_path, lottie_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'venus',
  (SELECT id FROM categories WHERE category_key = 'space' LIMIT 1),
  '{"en":"Venus","gu":"શુક્ર","hi":"शुक्र"}'::jsonb,
  NULL,
  '/assets/images/space/venus.png',
  NULL,
  '{"en":"Venus! Venus is the hottest and brightest planet in our night sky.","gu":"શુક્ર! શુક્ર એ આકાશમાં સૌથી ગરમ અને સૌથી તેજસ્વી દેખાતો ગ્રહ છે.","hi":"शुक्र! शुक्र सबसे गर्म और हमारे रात के आकाश में सबसे चमकीला ग्रह होता है।"}'::jsonb,
  '{"en":"Venus is covered in thick clouds that trap heat like a greenhouse. It is so hot that it can melt metal, and it shines brightly near the sun.","gu":"શુક્ર જાડા વાદળોથી ઘેરાયેલો છે જે ગરમીને પકડી રાખે છે. તે એટલો ગરમ છે કે ધાતુને પણ પીગળાવી શકે અને સૂર્ય પાસે ખૂબ ચમકે છે.","hi":"शुक्र घने बादलों से ढका है जो गर्मी को रोकते हैं। यह इतना गर्म है कि धातु को भी पिघला सकता है, और आकाश में बहुत चमकता है।"}'::jsonb,
  '{"en":"Did you know? Even though Mercury is closer to the sun, Venus is hotter because its thick atmosphere traps heat like a cozy blanket!","gu":"શું તમે જાણો છો? બુધ સૂર્યની વધુ નજીક હોવા છતાં શુક્ર વધુ ગરમ છે કારણ કે તેની હવામાં ફસાયેલી ગરમી કટોકટી જેવી બને છે!","hi":"क्या आपको पता है? हालांकि बुध सूर्य के अधिक निकट है, फिर भी शुक्र अधिक गर्म है क्योंकि इसका घना वातावरण कंबल की तरह गर्मी को रोकता है!"}'::jsonb,
  'memory',
  true,
  26
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  svg_path = EXCLUDED.svg_path,
  image_path = EXCLUDED.image_path,
  lottie_path = EXCLUDED.lottie_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  game_type = EXCLUDED.game_type,
  is_free = EXCLUDED.is_free,
  display_order = EXCLUDED.display_order;

COMMIT;
