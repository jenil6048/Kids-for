-- 1. Create birds table and index

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
  constraint birds_pkey primary key (id),
  constraint birds_topic_key_key unique (topic_key),
  constraint birds_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_birds_topic_key on public.birds using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.birds DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.birds TO anon;
GRANT ALL ON public.birds TO authenticated;
GRANT ALL ON public.birds TO service_role;


-- Ensure birds category exists in categories table
INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'birds',
  '{"en": "Birds", "gu": "પક્ષીઓ", "hi": "पक्षी"}'::jsonb,
  '#4CAF50',
  false,
  'natures_world',
  15
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 2. Populate birds table with data

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'budgie', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Budgie","gu":"બજરીગર","hi":"बजरीगर"}'::jsonb, 
  '/assets/images/birds/budgie.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'penguin', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Penguin","gu":"પેંગ્વિન","hi":"पेंगुइन"}'::jsonb, 
  '/assets/images/birds/penguin.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'duck', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Duck","gu":"બતક","hi":"बत्तख"}'::jsonb, 
  '/assets/images/birds/duck.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hummingbird', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Hummingbird","gu":"હમિંગબર્ડ","hi":"हमिंगबर्ड"}'::jsonb, 
  '/assets/images/birds/hummingbird.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'owl', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Owl","gu":"ઘુવડ","hi":"उल्लू"}'::jsonb, 
  '/assets/images/birds/owl.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'oriole', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Oriole","gu":"પીલક","hi":"पीलक"}'::jsonb, 
  '/assets/images/birds/oriole.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'parrot', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Parrot","gu":"પોપટ","hi":"तोता"}'::jsonb, 
  '/assets/images/birds/parrot.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rooster', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Rooster","gu":"કૂકડો","hi":"मुर्गा"}'::jsonb, 
  '/assets/images/birds/rooster.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'woodpecker', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Woodpecker","gu":"લક્કડખોદ","hi":"कठफोड़वा"}'::jsonb, 
  '/assets/images/birds/woodpecker.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'puffin', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Puffin","gu":"પફિન","hi":"पफिन"}'::jsonb, 
  '/assets/images/birds/puffin.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'ostrich', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Ostrich","gu":"શાહમૃગ","hi":"शुतुरमुर्ग"}'::jsonb, 
  '/assets/images/birds/ostrich.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'flamingo', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Flamingo","gu":"સુરખાબ","hi":"राजहंस"}'::jsonb, 
  '/assets/images/birds/flamingo.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'heron', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Heron","gu":"બગલો","hi":"बगुला"}'::jsonb, 
  '/assets/images/birds/heron.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'toucan', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Toucan","gu":"ટુકન","hi":"टूकन"}'::jsonb, 
  '/assets/images/birds/toucan.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'goose', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Goose","gu":"જંગલી હંસ","hi":"कलहंस"}'::jsonb, 
  '/assets/images/birds/goose.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'blue_jay', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Blue Jay","gu":"બ્લુ જે","hi":"ब्लू जे"}'::jsonb, 
  '/assets/images/birds/blue_jay.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'swan', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Swan","gu":"રાજહંસ","hi":"हंस"}'::jsonb, 
  '/assets/images/birds/swan.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cardinal', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Cardinal","gu":"લાલ ચકલી","hi":"कार्डिनल"}'::jsonb, 
  '/assets/images/birds/cardinal.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'turkey', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Turkey","gu":"ટર્કી","hi":"टर्की"}'::jsonb, 
  '/assets/images/birds/turkey.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'peacock', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Peacock","gu":"મોર","hi":"मोर"}'::jsonb, 
  '/assets/images/birds/peacock.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'eagle', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Eagle","gu":"ગરુડ","hi":"गरुड़"}'::jsonb, 
  '/assets/images/birds/eagle.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.birds 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kingfisher', 
  (SELECT id FROM categories WHERE category_key = 'birds' LIMIT 1), 
  '{"en":"Kingfisher","gu":"કલકલીયો","hi":"किंगफिशर"}'::jsonb, 
  '/assets/images/birds/kingfisher.png', 
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
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;
