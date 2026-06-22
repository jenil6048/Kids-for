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


-- 2. Populate shapes table with 11 shapes data

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'circle', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Circle", "gu": "વર્તુળ", "hi": "वृत्त"}'::jsonb, 
  '/assets/svgs/shapes/circle.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'square', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Square", "gu": "ચોરસ", "hi": "वर्ग"}'::jsonb, 
  '/assets/svgs/shapes/square.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'triangle', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Triangle", "gu": "ત્રિકોણ", "hi": "त्रिभुज"}'::jsonb, 
  '/assets/svgs/shapes/triangle.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rectangle', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Rectangle", "gu": "લંબચોરસ", "hi": "आयत"}'::jsonb, 
  '/assets/svgs/shapes/rectangle.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'star', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Star", "gu": "તારો", "hi": "तारा"}'::jsonb, 
  '/assets/svgs/shapes/star.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'heart', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Heart", "gu": "દિલ", "hi": "दिल"}'::jsonb, 
  '/assets/svgs/shapes/heart.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'oval', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Oval", "gu": "અંડાકાર", "hi": "अंडाकार"}'::jsonb, 
  '/assets/svgs/shapes/oval.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'diamond', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Diamond", "gu": "હીરો", "hi": "हीरा"}'::jsonb, 
  '/assets/svgs/shapes/diamond.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pentagon', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Pentagon", "gu": "પંચકોણ", "hi": "पंचकोण"}'::jsonb, 
  '/assets/svgs/shapes/pentagon.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hexagon', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Hexagon", "gu": "ષટ્કોણ", "hi": "षट्कोण"}'::jsonb, 
  '/assets/svgs/shapes/hexagon.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.shapes 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'crescent', 
  (SELECT id FROM categories WHERE category_key = 'shapes' LIMIT 1), 
  '{"en": "Crescent", "gu": "અર્ધચંદ્રાકાર", "hi": "अर्धचंद्राकार"}'::jsonb, 
  '/assets/svgs/shapes/crescent.svg', 
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
  svg_path = EXCLUDED.svg_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;