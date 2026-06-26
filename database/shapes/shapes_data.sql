-- 1. Create shapes table and index

CREATE TABLE IF NOT EXISTS public.shapes (
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
  constraint shapes_pkey primary key (id),
  constraint shapes_topic_key_key unique (topic_key),
  constraint shapes_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_shapes_topic_key on public.shapes using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.shapes DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.shapes TO anon;
GRANT ALL ON public.shapes TO authenticated;
GRANT ALL ON public.shapes TO service_role;


-- 2. Populate shapes table with 19 shapes data (Stitch PNG images)

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'circle', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Circle", "gu": "વર્તુળ", "hi": "वृत्त"}'::jsonb, 
  'assets/images/shapes/circle.png', 
  '{"en": "Circle! A circle is round and has no corners at all.", "gu": "વર્તુળ! વર્તુળ ગોળ હોય છે અને તેને એક પણ ખૂણો નથી હોતો.", "hi": "वृत्त! एक वृत्त गोल होता है और इसका कोई कोना नहीं होता।"}'::jsonb, 
  '{"en": "Circles are perfectly round. We see them in yummy donuts, the bright sun, coins, and bicycle wheels!", "gu": "વર્તુળ સંપૂર્ણપણે ગોળ હોય છે. આપણે તેને સ્વાદિષ્ટ ડોનટ્સ, તેજસ્વી સૂર્ય, સિક્કા અને સાયકલના પૈડામાં જોઈએ છીએ!", "hi": "वृत्त पूरी तरह से गोल होते हैं। हम उन्हें स्वादिष्ट डोनट्स, चमकीले सूरज, सिक्कों और साइकिल के पहियों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? A circle is a shape that can roll easily in any direction!", "gu": "શું તમે જાણો છો? વર્તુળ એવો આકાર છે જે કોઈપણ દિશામાં સરળતાથી ગબડી શકે છે!", "hi": "क्या आपको पता है? वृत्त एक ऐसा आकार है जो किसी भी दिशा में आसानी से लुढ़क सकता है!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'square', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Square", "gu": "ચોરસ", "hi": "वर्ग"}'::jsonb, 
  'assets/images/shapes/square.png', 
  '{"en": "Square! A square has four equal sides and four corners.", "gu": "ચોરસ! ચોરસને ચાર સમાન બાજુઓ અને ચાર ખૂણા હોય છે.", "hi": "वर्ग! एक वर्ग की चार बराबर भुजाएं और चार कोने होते हैं।"}'::jsonb, 
  '{"en": "Squares are super neat! You can find them in toy blocks, chessboards, bread slices, and wrapped gifts!", "gu": "ચોરસ ખૂબ જ વ્યવસ્થિત હોય છે! તમે તેને રમકડાના બ્લોક્સ, ચેસબોર્ડ, બ્રેડની સ્લાઇસ અને ગિફ્ટ બોક્સમાં જોઈ શકો છો!", "hi": "वर्ग बहुत ही व्यवस्थित होते हैं! आप उन्हें खिलौने के ब्लॉक, शतरंज के बोर्ड, ब्रेड के स्लाइस और उपहार के बक्से में पा सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Every corner of a square is a perfect right angle, just like a letter L!", "gu": "શું તમે જાણો છો? ચોરસનો દરેક ખૂણો કાટકોણ હોય છે, જેમ કે અંગ્રેજી અક્ષર L!", "hi": "क्या आपको पता है? वर्ग का प्रत्येक कोना एक समकोण होता है, बिल्कुल अंग्रेजी के अक्षर L की तरह!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'triangle', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Triangle", "gu": "ત્રિકોણ", "hi": "त्रिभुज"}'::jsonb, 
  'assets/images/shapes/triangle.png', 
  '{"en": "Triangle! A triangle is a pointy shape with three sides and three corners.", "gu": "ત્રિકોણ! ત્રિકોણ એ ત્રણ બાજુઓ અને ત્રણ ખૂણાવાળો અણીદાર આકાર છે.", "hi": "त्रिभुज! त्रिभुज तीन भुजाओं और तीन कोनों वाला एक नुकीला आकार होता है।"}'::jsonb, 
  '{"en": "Triangles are fun! We see them in delicious pizza slices, sandwich halves, ice cream cones, and hangers!", "gu": "ત્રિકોણ ખૂબ જ મજેદાર હોય છે! આપણે તેને સ્વાદિષ્ટ પિઝાની સ્લાઇસ, સેન્ડવીચના ટુકડા, આઇસક્રીમ કોન અને હેંગરમાં જોઈએ છીએ!", "hi": "त्रिभुज बहुत मजेदार होते हैं! हम उन्हें स्वादिष्ट पिज्जा के स्लाइस, सैंडविच के टुकड़ों, आइसक्रीम कोन और हैंगर में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Triangles are the strongest shape in building bridges and roofs because they don''t bend easily!", "gu": "શું તમે જાણો છો? પુલ અને છત બનાવવામાં ત્રિકોણ સૌથી મજબૂત આકાર છે કારણ કે તે સરળતાથી વળતો નથી!", "hi": "क्या आपको पता है? पुल और छत बनाने में त्रिभुज सबसे मजबूत आकार होते हैं क्योंकि वे आसानी से मुड़ते नहीं हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rectangle', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Rectangle", "gu": "લંબચોરસ", "hi": "आयत"}'::jsonb, 
  'assets/images/shapes/rectangle.png', 
  '{"en": "Rectangle! A rectangle has four sides, with opposite sides being equal.", "gu": "લંબચોરસ! લંબચોરસને ચાર બાજુઓ હોય છે, જેમાં સામસામેની બાજુઓ સમાન હોય છે.", "hi": "आयत! एक आयत की चार भुजाएँ होती हैं, जिसमें आमने-सामने की भुजाएँ बराबर होती हैं।"}'::jsonb, 
  '{"en": "Rectangles are everywhere! Look at your room''s door, a school blackboard, books, smart phones, and chocolate bars!", "gu": "લંબચોરસ બધે જ છે! તમારા રૂમનો દરવાજો, શાળાનું બ્લેકબોર્ડ, પુસ્તકો, સ્માર્ટફોન અને ચોકલેટ બાર જુઓ!", "hi": "आयत हर जगह हैं! अपने कमरे का दरवाजा, स्कूल का ब्लैकबोर्ड, किताबें, स्मार्टफोन और चॉकलेट बार देखें!"}'::jsonb, 
  '{"en": "Did you know? A rectangle is like a square that has been stretched out longer!", "gu": "શું તમે જાણો છો? લંબચોરસ એ ચોરસ જેવો જ છે જેને થોડો વધારે લાંબો ખેંચવામાં આવ્યો હોય!", "hi": "क्या आपको पता है? एक आयत एक ऐसे वर्ग की तरह है जिसे थोड़ा लंबा खींच दिया गया हो!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'star', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Star", "gu": "તારો", "hi": "तारा"}'::jsonb, 
  'assets/images/shapes/star.png', 
  '{"en": "Star! A star is a beautiful shape that twinkles and shines.", "gu": "તારો! તારો એ એક સુંદર આકાર છે જે ટમટમે છે અને ચમકે છે.", "hi": "तारा! तारा एक सुंदर आकार है जो टिमटिमाते और चमकते हुए दिखाई देता है।"}'::jsonb, 
  '{"en": "Stars are magical! We see them in the night sky, starfish in the ocean, magic wands, and reward stickers!", "gu": "તારાઓ જાદુઈ હોય છે! આપણે તેમને રાત્રિના આકાશમાં, સમુદ્રમાં સ્ટારફિશ, જાદુઈ લાકડીઓ અને રીવોર્ડ સ્ટીકર્સમાં જોઈએ છીએ!", "hi": "तारे जादुई होते हैं! हम उन्हें रात के आसमान में, समुद्र में स्टारफिश, जादुई छड़ी और इनाम के स्टिकर में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? The most common star shape we draw has five points, but real stars in space are giant round balls of fire!", "gu": "શું તમે જાણો છો? આપણે જે તારો દોરીએ છીએ તેને પાંચ ખૂણા હોય છે, પણ અંતરિક્ષમાં વાસ્તવિક તારાઓ અગ્નિના વિશાળ ગોળા છે!", "hi": "क्या आपको पता है? जो तारा हम बनाते हैं उसके पांच कोने होते हैं, लेकिन अंतरिक्ष में वास्तविक तारे आग के विशाल गोले हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'heart', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Heart", "gu": "દિલ", "hi": "दिल"}'::jsonb, 
  'assets/images/shapes/heart.png', 
  '{"en": "Heart! A heart is the shape of love, kindness, and friendship.", "gu": "દિલ! દિલ એ પ્રેમ, દયા અને મિત્રતાનો આકાર છે.", "hi": "दिल! दिल प्यार, दया और दोस्ती का आकार है।"}'::jsonb, 
  '{"en": "Hearts make us smile! You can find this shape in sweet red strawberries, love cards, and delicious cookies!", "gu": "દિલ આપણને ખુશ કરે છે! તમે આ આકારને મીઠી લાલ સ્ટ્રોબેરી, લવ કાર્ડ્સ અને સ્વાદિષ્ટ કુકીઝમાં જોઈ શકો છો!", "hi": "दिल हमें खुश करते हैं! आप इस आकार को मीठी लाल स्ट्रॉबेरी, लव कार्ड और स्वादिष्ट कुकीज़ में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? In nature, some plant leaves and seeds are naturally shaped like perfect hearts!", "gu": "શું તમે જાણો છો? કુદરતમાં, કેટલાક છોડના પાંદડા અને બીજ કુદરતી રીતે જ સુંદર દિલ જેવા આકારના હોય છે!", "hi": "क्या आपको पता है? प्रकृति में, कुछ पौधों की पत्तियां और बीज प्राकृतिक रूप से सुंदर दिल के आकार के होते हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'oval', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Oval", "gu": "અંડાકાર", "hi": "अंडाकार"}'::jsonb, 
  'assets/images/shapes/oval.png', 
  '{"en": "Oval! An oval is shaped like an egg, smooth and stretched out.", "gu": "અંડાકાર! અંડાકાર એ ઈંડા જેવો આકાર છે, જે ગોળાકાર અને લંબગોળ હોય છે.", "hi": "अंडाकार! अंडाकार अंडे की तरह का आकार है, जो गोल और लंबा होता है।"}'::jsonb, 
  '{"en": "Ovals are lovely! We see them in eggs, watermelons, makeup mirrors, and rugby balls!", "gu": "અંડાકાર આકારો ખૂબ જ સરસ છે! આપણે તેને ઈંડા, તડબૂચ, અરીસા અને રગ્બી બોલમાં જોઈએ છીએ!", "hi": "अंडाकार आकार बहुत प्यारे होते हैं! हम उन्हें अंडे, तरबूज, आईने और रग्बी बॉल में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? The orbits of planets going around the sun are actually oval-shaped, not perfect circles!", "gu": "શું તમે જાણો છો? સૂર્યની આસપાસ ફરતા ગ્રહોની કક્ષા ખરેખર અંડાકાર હોય છે, સંપૂર્ણ વર્તુળ નહીં!", "hi": "क्या आपको पता है? सूर्य के चक्कर लगाने वाले ग्रहों की कक्षा वास्तव में अंडाकार होती है, गोल नहीं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'diamond', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Diamond", "gu": "હીરો", "hi": "हीरा"}'::jsonb, 
  'assets/images/shapes/diamond.png', 
  '{"en": "Diamond! A diamond is a sparkly shape with four slanted sides.", "gu": "હીરો! હીરો એ ચાર ત્રાંસી બાજુઓવાળો ચમકતો આકાર છે.", "hi": "हीरा! हीरा चार तिरछी भुजाओं वाला एक चमकीला आकार है।"}'::jsonb, 
  '{"en": "Diamonds are exciting! We see them flying high in the sky as kites, in playing cards, and shiny jewelry!", "gu": "હીરા આકર્ષક હોય છે! આપણે તેમને આકાશમાં ઊંચે ઉડતા પતંગોમાં, પત્તાની રમતમાં અને ચમકતા દાગીનામાં જોઈએ છીએ!", "hi": "हीरे आकर्षक होते हैं! हम उन्हें आसमान में ऊंचे उड़ते पतंगों में, ताश के पत्तों में और चमकते गहनों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Real diamond gemstone is the hardest natural substance on Earth!", "gu": "શું તમે જાણો છો? સાચો હીરો એ પૃથ્વી પરનો સૌથી સખત કુદરતી પદાર્થ છે!", "hi": "क्या आपको पता है? असली हीरा पृथ्वी पर सबसे कठोर प्राकृतिक पदार्थ है!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pentagon', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Pentagon", "gu": "પંચકોણ", "hi": "पंचकोण"}'::jsonb, 
  'assets/images/shapes/pentagon.png', 
  '{"en": "Pentagon! A pentagon has five straight sides and five corners.", "gu": "પંચકોણ! પંચકોણને પાંચ સીધી બાજુઓ અને પાંચ ખૂણા હોય છે.", "hi": "पंचकोण! एक पंचकोण की पांच सीधी भुजाएं और पांच कोने होते हैं।"}'::jsonb, 
  '{"en": "Pentagons are unique! Look at the black patches on a soccer ball, cute birdhouses, and the crossing signs!", "gu": "પંચકોણ અનન્ય છે! ફૂટબોલ પરના કાળા પટ્ટા, સુંદર પક્ષીઘર અને ટ્રાફિક સિગ્નલ બોર્ડ જુઓ!", "hi": "पंचकोण अनोखे होते हैं! फुटबॉल पर काले पैच, प्यारे पक्षीघर और ट्रैफिक सिग्नल बोर्ड देखें!"}'::jsonb, 
  '{"en": "Did you know? If you draw a star and connect its outer points, you get a pentagon shape!", "gu": "શું તમે જાણો છો? જો તમે તારો દોરો અને તેના બહારના બિંદુઓને જોડો, તો તમને પંચકોણ આકાર મળશે!", "hi": "क्या आपको पता है? यदि आप एक तारा बनाते हैं और उसके बाहरी बिन्दुओं को जोड़ते हैं, तो आपको एक पंचकोण मिलेगा!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hexagon', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Hexagon", "gu": "ષટ્કોણ", "hi": "षट्कोण"}'::jsonb, 
  'assets/images/shapes/hexagon.png', 
  '{"en": "Hexagon! A hexagon is a cool shape with six sides and six corners.", "gu": "ષટ્કોણ! ષટ્કોણ એ છ બાજુઓ અને છ ખૂણાવાળો સરસ આકાર છે.", "hi": "षट्कोण! षट्कोण छह भुजाओं और छह कोनों वाला एक बहुत ही सुंदर आकार होता है।"}'::jsonb, 
  '{"en": "Hexagons are neat! You can spot them in honeybee honeycombs, turtle shells, and giant nuts and bolts!", "gu": "ષટ્કોણ ખૂબ વ્યવસ્થિત હોય છે! તમે તેને મધમાખીના મધપૂડામાં, કાચબાની ઢાલ પર અને મોટા નટ-બોલ્ટમાં જોઈ શકો છો!", "hi": "षट्कोण बहुत ही आकर्षक होते हैं! आप उन्हें मधुमक्खियों के छत्ते, कछुए की पीठ और बड़े नट-बोल्ट में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Honeybees build hexagons because they hold the most honey using the least amount of wax!", "gu": "શું તમે જાણો છો? મધમાખીઓ ષટ્કોણ આકાર બનાવે છે કારણ કે તેમાં મીણનો ઓછામાં ઓછો ઉપયોગ કરીને સૌથી વધુ મધ ભરી શકાય છે!", "hi": "क्या आपको पता है? मधुमक्खियां षट्कोण आकार बनाती हैं क्योंकि वे मोम की सबसे कम मात्रा का उपयोग करके सबसे अधिक शहद जमा कर सकती हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'crescent', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Crescent", "gu": "અર્ધચંદ્રાકાર", "hi": "अर्धचंद्राकार"}'::jsonb, 
  'assets/images/shapes/crescent.png', 
  '{"en": "Crescent! A crescent looks like a curved banana or a young moon.", "gu": "અર્ધચંદ્રાકાર! અર્ધચંદ્રાકાર વક્ર કેળા જેવો અથવા નવા ઉગેલા ચંદ્ર જેવો દેખાય છે.", "hi": "अर्धचंद्राकार! अर्धचंद्राकार एक घुमावदार केले या नए चंद्रमा की तरह दिखता है।"}'::jsonb, 
  '{"en": "Crescents are beautiful! We see them in the night sky as the crescent moon, tasty croissants, and bananas!", "gu": "અર્ધચંદ્રાકાર સુંદર હોય છે! આપણે તેને રાત્રિના આકાશમાં બીજના ચંદ્ર તરીકે, સ્વાદિષ્ટ ક્રોઈસન્ટ બ્રેડ અને કેળામાં જોઈએ છીએ!", "hi": "अर्धचंद्राकार बहुत सुंदर होते हैं! हम उन्हें रात के आसमान में नए चंद्रमा के रूप में, स्वादिष्ट क्रोइसैंट ब्रेड और केले में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? The word crescent comes from a Latin word that means to grow, because the moon seems to grow!", "gu": "શું તમે જાણો છો? ક્રેસન્ટ શબ્દ લેટિન શબ્દ પરથી આવ્યો છે જેનો અર્થ ''વધવું'' થાય છે, કારણ કે ચંદ્ર વધતો દેખાય છે!", "hi": "क्या आपको पता है? क्रेसेंट शब्द एक लैटिन शब्द से आया है जिसका अर्थ है ''बढ़ना'', क्योंकि चंद्रमा बढ़ता हुआ प्रतीत होता है!"}'::jsonb, 
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

-- 3D Shapes (NEW - from Stitch)

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'octagon', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Octagon", "gu": "અષ્ટકોણ", "hi": "अष्टकोण"}'::jsonb, 
  'assets/images/shapes/octagon.png', 
  '{"en": "Octagon! An octagon is a shape with eight sides and eight corners.", "gu": "અષ્ટકોણ! અષ્ટકોણ એ આઠ બાજુઓ અને આઠ ખૂણાવાળો આકાર છે.", "hi": "अष्टकोण! एक अष्टकोण आठ भुजाओं और आठ कोनों वाला आकार होता है।"}'::jsonb, 
  '{"en": "Octagons are all around us! You see them every day on red stop signs and in some building windows!", "gu": "અષ્ટકોણ આપણી ચારેબાજુ છે! તમે તેને રોજ લાલ સ્ટોપ સાઇન અને કેટલીક ઇમારતોની બારીઓમાં જુઓ છો!", "hi": "अष्टकोण हमारे चारों ओर हैं! आप उन्हें हर दिन लाल रुको के निशान और कुछ इमारतों की खिड़कियों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? A stop sign is an octagon because its unique shape helps drivers recognize it even in bad weather!", "gu": "શું તમે જાણો છો? સ્ટોપ સાઇન અષ્ટકોણ આકારનું હોય છે કારણ કે તેનો અનન્ય આકાર ખરાબ હવામાનમાં પણ ડ્રાઇવરોને ઓળખવામાં મદદ કરે છે!", "hi": "क्या आपको पता है? स्टॉप साइन अष्टकोण होता है क्योंकि इसका अनूठा आकार बुरे मौसम में भी ड्राइवरों को पहचानने में मदद करता है!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'trapezoid', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Trapezoid", "gu": "ટ્રેપેઝોઇડ", "hi": "समलम्ब चतुर्भुज"}'::jsonb, 
  'assets/images/shapes/trapezoid.png', 
  '{"en": "Trapezoid! A trapezoid has four sides but only one pair of parallel sides.", "gu": "ટ્રેપેઝોઇડ! ટ્રેપેઝોઇડને ચાર બાજુઓ હોય છે પણ માત્ર એક જ જોડ સમાંતર બાજુઓ હોય છે.", "hi": "समलम्ब! एक समलम्ब चतुर्भुज में चार भुजाएँ होती हैं, लेकिन केवल एक जोड़ी समानांतर भुजाएँ होती हैं।"}'::jsonb, 
  '{"en": "Trapezoids are clever shapes! You can spot them in handbags, buckets, guitar bodies, and some bridges!", "gu": "ટ્રેપેઝોઇડ ચતુર આકારો છે! તમે તેમને હેન્ડબેગ, ડોલ, ગિટારની બોડી અને કેટલાક પુલોમાં જોઈ શકો છો!", "hi": "समलम्ब चतुर्भुज चतुर आकार हैं! आप उन्हें हैंडबैग, बाल्टी, गिटार की बॉडी और कुछ पुलों में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Trapezoids are used in architecture because their slanted sides make structures stronger!", "gu": "શું તમે જાણો છો? ટ્રેપેઝોઇડ સ્થાપત્યમાં ઉપયોગ થાય છે કારણ કે તેની ત્રાંસી બાજુઓ માળખાઓને વધુ મજબૂત બનાવે છે!", "hi": "क्या आपको पता है? समलम्ब चतुर्भुज का उपयोग वास्तुकला में किया जाता है क्योंकि इसकी तिरछी भुजाएं संरचनाओं को मजबूत बनाती हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cone', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Cone", "gu": "શંકુ", "hi": "शंकु"}'::jsonb, 
  'assets/images/shapes/cone.png', 
  '{"en": "Cone! A cone has a flat circle bottom and comes to a point at the top.", "gu": "શંકુ! શંકુને નીચે ચપટો વર્તુળ આધાર અને ઉપર એક ટોચ હોય છે.", "hi": "शंकु! एक शंकु में नीचे एक सपाट गोलाकार आधार और ऊपर एक नुकीला सिरा होता है।"}'::jsonb, 
  '{"en": "Cones are yummy and fun! Think of ice cream cones, party hats, traffic cones, and carrots!", "gu": "શંકુ સ્વાદિષ્ટ અને મજેદાર છે! આઇસક્રીમ કોન, પાર્ટી હેટ, ટ્રાફિક કોન અને ગાજર વિશે વિચારો!", "hi": "शंकु स्वादिष्ट और मजेदार हैं! आइसक्रीम कोन, पार्टी हैट, ट्रैफिक कोन और गाजर के बारे में सोचें!"}'::jsonb, 
  '{"en": "Did you know? A volcano is shaped like a cone! That''s why lava flows down the sides when it erupts!", "gu": "શું તમે જાણો છો? જ્વાળામુખી શંકુ આકારનો હોય છે! એટલે જ ફૂટે ત્યારે લાવા બાજુઓ પર નીચે વહે છે!", "hi": "क्या आपको पता है? एक ज्वालामुखी शंकु के आकार का होता है! इसीलिए फटने पर लावा किनारों से नीचे बहता है!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cube', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Cube", "gu": "ઘન", "hi": "घन"}'::jsonb, 
  'assets/images/shapes/cube.png', 
  '{"en": "Cube! A cube is a 3D box shape with six equal square faces.", "gu": "ઘન! ઘન એ ત્રિ-પરિમાણીય બોક્સ આકાર છે જેની છ સમાન ચોરસ બાજુઓ હોય છે.", "hi": "घन! एक घन एक त्रि-आयामी बॉक्स आकार है जिसके छह बराबर वर्गाकार फलक होते हैं।"}'::jsonb, 
  '{"en": "Cubes are everywhere! Look at dice, ice cubes, Rubik''s cube toys, sugar cubes, and toy building blocks!", "gu": "ઘન બધે જ છે! પાસા, બરફના ટુકડા, રૂબિક ક્યૂબ, ખાંડના ટુકડા અને રમકડાના બ્લોક જુઓ!", "hi": "घन हर जगह हैं! पासे, बर्फ के टुकड़े, रूबिक्स क्यूब खिलौने, शक्कर के टुकड़े और खिलौने के ब्लॉक देखें!"}'::jsonb, 
  '{"en": "Did you know? A cube has 6 faces, 12 edges, and 8 corners — and all sides are exactly the same size!", "gu": "શું તમે જાણો છો? ઘનને 6 બાજુઓ, 12 કિનારાઓ અને 8 ખૂણા હોય છે — અને બધી બાજુઓ બિલકુલ સમાન કદની હોય છે!", "hi": "क्या आपको पता है? एक घन में 6 फलक, 12 किनारे और 8 कोने होते हैं — और सभी भुजाएं बिल्कुल एक ही आकार की होती हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cylinder', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Cylinder", "gu": "નળ", "hi": "बेलन"}'::jsonb, 
  'assets/images/shapes/cylinder.png', 
  '{"en": "Cylinder! A cylinder has two round circles on the ends and a curved side.", "gu": "નળ! નળને બે છેડે ગોળ વર્તુળ અને એક વક્ર બાજુ હોય છે.", "hi": "बेलन! एक बेलन के दोनों सिरों पर दो गोल वृत्त और एक घुमावदार भुजा होती है।"}'::jsonb, 
  '{"en": "Cylinders are super useful! We see them in cans of food, batteries, toilet paper rolls, drums, and pipes!", "gu": "નળ ખૂબ ઉપયોગી છે! આપણે તેમને ખાણીપીણીના ડબ્બા, બેટરી, ટોઈલેટ પેપર રોલ, ઢોલ અને નળ-પાઈપમાં જોઈએ છીએ!", "hi": "बेलन बहुत उपयोगी होते हैं! हम उन्हें खाने के डिब्बे, बैटरी, टॉयलेट पेपर रोल, ड्रम और पाइप में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? A cylinder can roll on its side, just like a rolling pin or a log rolling down a hill!", "gu": "શું તમે જાણો છો? નળ તેની બાજુ પર ગબડી શકે છે, જેમ કે રોલિંગ પિન અથવા ટેકરી પરથી ગબડતો લઠ્ઠો!", "hi": "क्या आपको पता है? एक बेलन अपनी तरफ लुढ़क सकता है, जैसे एक बेलन या पहाड़ी से लुढ़कता हुआ एक लट्ठा!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pyramid', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Pyramid", "gu": "પિરામિડ", "hi": "पिरामिड"}'::jsonb, 
  'assets/images/shapes/pyramid.png', 
  '{"en": "Pyramid! A pyramid has a flat bottom and triangular sides that meet at a point.", "gu": "પિરામિડ! પિરામિડને ચપટો આધાર અને ત્રિકોણ બાજુઓ હોય છે જે એક ટોચ પર મળે છે.", "hi": "पिरामिड! एक पिरामिड में एक सपाट आधार और त्रिकोणीय भुजाएं होती हैं जो एक बिंदु पर मिलती हैं।"}'::jsonb, 
  '{"en": "Pyramids are ancient and amazing! The Great Pyramids of Egypt are one of the seven wonders of the world!", "gu": "પિરામિડ પ્રાચીન અને અદ્ભુત છે! ઇજિપ્તના મહાન પિરામિડ વિશ્વના સાત અજાયબોમાંથી એક છે!", "hi": "पिरामिड प्राचीन और अद्भुत हैं! मिस्र के महान पिरामिड दुनिया के सात अजूबों में से एक हैं!"}'::jsonb, 
  '{"en": "Did you know? Pyramid shapes are incredibly strong! The triangular faces spread weight evenly, which is why ancient pyramids still stand after thousands of years!", "gu": "શું તમે જાણો છો? પિરામિડ આકાર અવિશ્વસનીય રીતે મજબૂત છે! ત્રિકોણ ચહેરાઓ વજનને સમાન રીતે ફેલાવે છે, તેથી જ પ્રાચીન પિરામિડ હજારો વર્ષ પછી પણ ઊભા છે!", "hi": "क्या आपको पता है? पिरामिड आकार अविश्वसनीय रूप से मजबूत होते हैं! त्रिकोणीय फलक वजन को समान रूप से फैलाते हैं, इसीलिए प्राचीन पिरामिड हजारों साल बाद भी खड़े हैं!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sphere', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Sphere", "gu": "ગોળો", "hi": "गोला"}'::jsonb, 
  'assets/images/shapes/sphere.png', 
  '{"en": "Sphere! A sphere is a perfectly round 3D shape, like a ball.", "gu": "ગોળો! ગોળો એ સંપૂર્ણ ગોળ ત્રિ-પરિમાણીય આકાર છે, જેમ કે દડો.", "hi": "गोला! एक गोला एक पूरी तरह गोल त्रि-आयामी आकार है, जैसे एक गेंद।"}'::jsonb, 
  '{"en": "Spheres are everywhere! Footballs, basketballs, marbles, bubbles, and even the planets in space are spheres!", "gu": "ગોળા બધે જ છે! ફૂટબોલ, બાસ્કેટબોલ, કાચની ગોળી, પરપોટા અને અવકાશના ગ્રહો પણ ગોળા છે!", "hi": "गोले हर जगह हैं! फुटबॉल, बास्केटबॉल, कंचे, बुलबुले और अंतरिक्ष के ग्रह भी गोले हैं!"}'::jsonb, 
  '{"en": "Did you know? The Earth is a sphere! It''s slightly squished at the top and bottom, but it''s still basically a giant ball!", "gu": "શું તમે જાણો છો? પૃથ્વી ગોળો છે! તે ઉપર અને નીચે થોડી ચપટી છે, પણ મૂળભૂત રીતે તે એક વિશાળ ગોળ છે!", "hi": "क्या आपको पता है? पृथ्वी एक गोला है! यह ऊपर और नीचे से थोड़ी चपटी है, लेकिन मूल रूप से यह एक विशाल गेंद है!"}'::jsonb, 
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

INSERT INTO public.shapes 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'torus', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Torus", "gu": "ડોનટ આકાર", "hi": "टोरस"}'::jsonb, 
  'assets/images/shapes/torus.png', 
  '{"en": "Torus! A torus is a donut-shaped 3D ring with a hole in the middle.", "gu": "ટોરસ! ટોરસ એ ડોનટ આકારનો ત્રિ-પરિમાણીય આકાર છે જેની વચ્ચે છિદ્ર હોય છે.", "hi": "टोरस! टोरस एक डोनट के आकार का त्रि-आयामी आकार है जिसके बीच में एक छेद होता है।"}'::jsonb, 
  '{"en": "A torus looks just like a donut! You can also see this shape in life rings, bagels, and rubber rings!", "gu": "ટોરસ બિલકુલ ડોનટ જેવું દેખાય છે! આ આકાર તમે લાઇફ રિંગ, બૅગલ અને રબ્બર રિંગમાં પણ જોઈ શકો છો!", "hi": "टोरस बिल्कुल डोनट जैसा दिखता है! आप यह आकार जीवन रक्षक रिंग, बैगल और रबर रिंग में भी देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? A donut is actually called a torus in math! Mathematicians love this shape because it has very special curved surfaces!", "gu": "શું તમે જાણો છો? ગણિતમાં ડોનટને ટોરસ કહેવાય છે! ગણિતશાસ્ત્રીઓ આ આકારને ખૂબ પસંદ કરે છે કારણ કે તેમાં ખૂબ ખાસ વક્ર સપાટી હોય છે!", "hi": "क्या आपको पता है? गणित में डोनट को टोरस कहते हैं! गणितज्ञ इस आकार को बहुत पसंद करते हैं क्योंकि इसमें बहुत खास घुमावदार सतह होती है!"}'::jsonb, 
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