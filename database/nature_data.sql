

-- 2. Create nature table and index

CREATE TABLE IF NOT EXISTS public.nature (
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
  constraint nature_pkey primary key (id),
  constraint nature_topic_key_key unique (topic_key),
  constraint nature_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_nature_topic_key on public.nature using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.nature DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.nature TO anon;
GRANT ALL ON public.nature TO authenticated;
GRANT ALL ON public.nature TO service_role;


-- 2. Populate nature table with data

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sun',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Sun", "gu": "સૂર્ય", "hi": "सूरज"}'::jsonb,
  '/assets/images/nature/sun.png',
  '{"en": "Sun! The Sun is a big, bright star that gives us light and warmth.", "gu": "સૂર્ય! સૂર્ય એક મોટો અને તેજસ્વી તારો છે જે આપણને પ્રકાશ અને ગરમી આપે છે.", "hi": "सूरज! सूरज एक बड़ा और चमकीला तारा है जो हमें रोशनी और गर्मी देता है।"}'::jsonb,
  '{"en": "The Sun is at the center of our solar system. Plants need sunlight to grow and make their own food!", "gu": "સૂર્ય આપણા સૌરમંડળના કેન્દ્રમાં છે. છોડને વધવા અને પોતાનો ખોરાક બનાવવા માટે સૂર્યપ્રકાશની જરૂર હોય છે!", "hi": "सूरज हमारे सौर मंडल के केंद्र में है। पौधों को बढ़ने और अपना भोजन बनाने के लिए सूरज की रोशनी की जरूरत होती है!"}'::jsonb,
  '{"en": "Did you know? The Sun is so large that about one million Earths could fit inside it!", "gu": "શું તમે જાણો છો? સૂર્ય એટલો મોટો છે કે તેની અંદર લગભગ દસ લાખ પૃથ્વી સમાઈ શકે છે!", "hi": "क्या आपको पता है? सूरज इतना बड़ा है कि इसके अंदर लगभग दस लाख पृथ्वी समा सकती हैं!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'moon',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Moon", "gu": "ચંદ્ર", "hi": "चंद्रमा"}'::jsonb,
  '/assets/images/nature/moon.png',
  '{"en": "Moon! The Moon is our neighbor in space that glows in the night sky.", "gu": "ચંદ્ર! ચંદ્ર અવકાશમાં આપણો પાડોશી છે જે રાત્રિના આકાશમાં ચમકે છે.", "hi": "चंद्रमा! चंद्रमा अंतरिक्ष में हमारा पड़ोसी है जो रात के आकाश में चमकता है।"}'::jsonb,
  '{"en": "The Moon doesn''t have its own light; it reflects light from the Sun. It changes shape throughout the month!", "gu": "ચંદ્રને પોતાનો પ્રકાશ નથી; તે સૂર્યના પ્રકાશને પરાવર્તિત કરે છે. તે આખા મહિના દરમિયાન પોતાનો આકાર બદલે છે!", "hi": "चंद्रमा की अपनी रोशनी नहीं होती; यह सूरज की रोशनी को परावर्तित करता है। यह पूरे महीने अपना आकार बदलता रहता है!"}'::jsonb,
  '{"en": "Did you know? Even though it looks bright, the Moon''s surface is actually dark, like charcoal!", "gu": "શું તમે જાણો છો? ભલે તે તેજસ્વી દેખાય છે, પરંતુ ચંદ્રની સપાટી વાસ્તવમાં કોલસાની જેમ અંધારી છે!", "hi": "क्या आपको पता है? भले ही यह चमकीला दिखता हो, लेकिन चंद्रमा की सतह वास्तव में कोयले की तरह अंधेरी है!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cloud',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Cloud", "gu": "વાદળ", "hi": "बादल"}'::jsonb,
  '/assets/images/nature/cloud.png',
  '{"en": "Cloud! Clouds are fluffy white shapes that float high in the blue sky.", "gu": "વાદળ! વાદળો એ સફેદ આકારો છે જે વાદળી આકાશમાં ઊંચા તરે છે.", "hi": "बादल! बादल सफेद आकार के होते हैं जो नीले आकाश में ऊंचे तैरते हैं।"}'::jsonb,
  '{"en": "Clouds are made of tiny water drops or ice. When they get heavy, they give us refreshing rain!", "gu": "વાદળો પાણીના નાના ટીપાં અથવા બરફના બનેલા હોય છે. જ્યારે તેઓ ભારે થાય છે, ત્યારે તેઓ આપણને વરસાદ આપે છે!", "hi": "बादल पानी की नन्हीं बूंदों या बर्फ से बने होते हैं। जब वे भारी हो जाते हैं, तो वे हमें बारिश देते हैं!"}'::jsonb,
  '{"en": "Did you know? Some clouds can be as tall as mountains and hold millions of gallons of water!", "gu": "શું તમે જાણો છો? કેટલાક વાદળો પર્વતો જેટલા ઊંચા હોઈ શકે છે અને તેમાં લાખો ગેલન પાણી હોઈ શકે છે!", "hi": "क्या आपको पता है? कुछ बादल पहाड़ों जितने ऊंचे हो सकते हैं और उनमें लाखों गैलन पानी हो सकता है!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rainbow',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Rainbow", "gu": "મેઘધનુષ", "hi": "इंद्रधनुष"}'::jsonb,
  '/assets/images/nature/rainbow.png',
  '{"en": "Rainbow! A rainbow is a beautiful arch of colors that appears after it rains.", "gu": "મેઘધનુષ! મેઘધનુષ એ રંગોની એક સુંદર કમાન છે જે વરસાદ પછી દેખાય છે.", "hi": "इंद्रधनुष! इंद्रधनुष रंगों का एक सुंदर धनुष है जो बारिश के बाद दिखाई देता है।"}'::jsonb,
  '{"en": "Rainbows have seven colors: red, orange, yellow, green, blue, indigo, and violet. They happen when sunlight hits raindrops!", "gu": "મેઘધનુષમાં સાત રંગો હોય છે: લાલ, નારંગી, પીળો, લીલો, વાદળી, નીલ અને જાંબલી. જ્યારે સૂર્યપ્રકાશ વરસાદના ટીપાં પર પડે છે ત્યારે તે રચાય છે!", "hi": "इंद्रधनुष में सात रंग होते हैं: लाल, नारंगी, पीला, हरा, नीला, जामुनी और बैंगनी। वे तब बनते हैं जब सूरज की रोशनी बारिश की बूंदों से टकराती है!"}'::jsonb,
  '{"en": "Did you know? No two people see the exact same rainbow! Each person sees it from a slightly different spot.", "gu": "શું તમે જાણો છો? કોઈ પણ બે વ્યક્તિ એક જ મેઘધનુષ જોઈ શકતી નથી! દરેક વ્યક્તિ તેને થોડી અલગ જગ્યાએથી જુએ છે.", "hi": "क्या आपको पता है? कोई भी दो लोग बिल्कुल एक जैसा इंद्रधनुष नहीं देखते! हर व्यक्ति इसे थोड़ा अलग जगह से देखता है।"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'waterfall',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Waterfall", "gu": "ધોધ", "hi": "झरना"}'::jsonb,
  '/assets/images/nature/waterfall.png',
  '{"en": "Waterfall! A waterfall is where water flows over a cliff and splashes down below.", "gu": "ધોધ! ધોધ એ છે જ્યાં પાણી ખડક પરથી વહે છે અને નીચે પછડાય છે.", "hi": "झरना! झरना वह जगह है जहाँ पानी एक चट्टान से गिरता है और नीचे छपछपाता है।"}'::jsonb,
  '{"en": "Waterfalls create a beautiful misty spray and a loud rushing sound as the water tumbles down into a pool.", "gu": "જ્યારે પાણી નીચે કુંડમાં પડે છે ત્યારે ધોધ સુંદર ઝાકળ જેવી વર્ષા અને જોરદાર અવાજ પેદા કરે છે.", "hi": "जब पानी नीचे गिरता है, तो झरने सुंदर धुंध और पानी के गिरने की तेज़ आवाज़ पैदा करते हैं।"}'::jsonb,
  '{"en": "Did you know? The tallest waterfall in the world is Angel Falls in Venezuela—it is almost one kilometer high!", "gu": "શું તમે જાણો છો? વિશ્વનો સૌથી ઊંચો ધોધ વેનેઝુએલામાં એન્જલ ફોલ્સ છે - તે લગભગ એક કિલોમીટર ઊંચો છે!", "hi": "क्या आपको पता है? दुनिया का सबसे ऊँचा झरना वेनेजुएला में एंजेल फॉल्स है—यह लगभग एक किलोमीटर ऊँचा है!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tree',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Tree", "gu": "ઝાડ", "hi": "पेड़"}'::jsonb,
  '/assets/images/nature/tree.png',
  '{"en": "Tree! Trees are tall plants with a woody trunk and many green leaves.", "gu": "ઝાડ! ઝાડ એ લાકડાના થડ અને ઘણા લીલા પાંદડા ધરાવતા ઊંચા છોડ છે.", "hi": "पेड़! पेड़ लकड़ी के तने और कई हरी पत्तियों वाले ऊंचे पौधे होते हैं।"}'::jsonb,
  '{"en": "Trees give us shade, fresh air to breathe, and yummy fruits to eat. They are homes for many birds and squirrels!", "gu": "ઝાડ આપણને છાયડો, શ્વાસ લેવા માટે તાજી હવા અને ખાવા માટે સ્વાદિષ્ટ ફળો આપે છે. તેઓ પક્ષીઓ અને ખિસકોલીઓનું ઘર છે!", "hi": "पेड़ हमें छाया, सांस लेने के लिए ताजी हवा और खाने के लिए स्वादिष्ट फल देते हैं। वे कई पक्षियों और गिलहरियों के घर हैं!"}'::jsonb,
  '{"en": "Did you know? Some trees can live for thousands of years, making them the oldest living things on Earth!", "gu": "શું તમે જાણો છો? કેટલાક વૃક્ષો હજારો વર્ષ જીવી શકે છે, જે તેમને પૃથ્વી પરના સૌથી જૂના જીવંત પ્રાણીઓ બનાવે છે!", "hi": "क्या आपको पता है? कुछ पेड़ हजारों सालों तक जीवित रह सकते हैं, जो उन्हें पृथ्वी पर सबसे पुरानी जीवित चीज़ें बनाते हैं!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mountain',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Mountain", "gu": "પર્વત", "hi": "पहाड़"}'::jsonb,
  '/assets/images/nature/mountain.png',
  '{"en": "Mountain! Mountains are very tall landforms that reach high into the clouds.", "gu": "પર્વત! પર્વતો એ ખૂબ જ ઊંચા ભૂમિ સ્વરૂપો છે જે વાદળો સુધી પહોંચે છે.", "hi": "पहाड़! पहाड़ बहुत ऊंचे होते हैं जो बादलों तक पहुँचते हैं।"}'::jsonb,
  '{"en": "Mountains can have snowy tops and are fun to climb. A group of mountains together is called a mountain range!", "gu": "પર્વતોની ટોચ બરફવાળી હોઈ શકે છે અને તેના પર ચઢવાની મજા આવે છે. પર્વતોના સમૂહને પર્વતમાળા કહેવાય છે!", "hi": "पहाड़ों की चोटियाँ बर्फीली हो सकती हैं और उन पर चढ़ना मजेदार होता.। पहाड़ों के समूह को पर्वत श्रृंखला कहा जाता है!"}'::jsonb,
  '{"en": "Did you know? Mount Everest is the highest mountain in the world above sea level!", "gu": "શું તમે જાણો છો? માઉન્ટ એવરેસ્ટ એ દરિયાની સપાટીથી વિશ્વનો સૌથી ઊંચો પર્વત છે!", "hi": "क्या आपको पता है? माउंट एवरेस्ट समुद्र तल से दुनिया का सबसे ऊँचा पर्वत है!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cactus',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Cactus", "gu": "થોર", "hi": "कैक्टस"}'::jsonb,
  '/assets/images/nature/cactus.png',
  '{"en": "Cactus! A cactus is a prickly plant that grows in hot, dry deserts.", "gu": "થોર! થોર એ કાંટાવાળો છોડ છે જે ગરમ, સૂકા રણમાં ઉગે છે.", "hi": "कैक्टस! कैक्टस एक कांटेदार पौधा है जो गर्म, सूखे रेगिस्तान में उगता है।"}'::jsonb,
  '{"en": "Cacti have sharp spines to protect themselves. They can store lots of water inside their stems to stay alive without rain!", "gu": "થોર પોતાની જાતને બચાવવા માટે તીક્ષ્ણ કાંટા ધરાવે છે. તેઓ વરસાદ વિના જીવંત રહેવા માટે તેમના થડમાં ઘણું પાણી સંગ્રહિત કરી શકે છે!", "hi": "कैक्टस खुद को बचाने के लिए नुकीले कांटे रखते हैं। वे बिना बारिश के जीवित रहने के लिए अपने तने के अंदर बहुत सारा पानी जमा कर सकते हैं!"}'::jsonb,
  '{"en": "Did you know? Some cacti grow beautiful flowers, and some can live for over 150 years!", "gu": "શું તમે જાણો છો? કેટલાક થોર પર સુંદર ફૂલો ઉગે છે, અને કેટલાક ૧૫૦ વર્ષથી વધુ જીવી શકે છે!", "hi": "क्या आपको पता है? कुछ कैक्टस में सुंदर फूल उगते हैं, और कुछ 150 से अधिक वर्षों तक जीवित रह सकते हैं!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'flower',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Flower", "gu": "ફૂલ", "hi": "फूल"}'::jsonb,
  '/assets/images/nature/flower.png',
  '{"en": "Flower! Flowers are colorful and smelly parts of plants that make the world beautiful.", "gu": "ફૂલ! ફૂલો એ છોડના રંગીન અને સુગંધિત ભાગો છે જે વિશ્વને સુંદર બનાવે છે.", "hi": "फूल! फूल पौधों के रंगीन और खुशबूदार हिस्से होते हैं जो दुनिया को सुंदर बनाते हैं।"}'::jsonb,
  '{"en": "Flowers come in all shapes and colors. Bees and butterflies love visiting flowers to drink sweet nectar!", "gu": "ફૂલો તમામ આકારો અને રંગોમાં આવે છે. મધમાખીઓ અને પતંગિયાઓને મીઠો રસ પીવા માટે ફૂલોની મુલાકાત લેવી ગમે છે!", "hi": "फूल सभी आकारों और रंगों में आते हैं। मधुमक्खियों और तितलियों को मीठा रस पीने के लिए फूलों पर जाना बहुत पसंद है!"}'::jsonb,
  '{"en": "Did you know? Sunflowers always turn their heads to face the sun as it moves across the sky!", "gu": "શું તમે જાણો છો? સૂર્યમુખી હંમેશા આકાશમાં સૂર્ય જેમ ફરે તેમ તેનું મુખ સૂર્ય તરફ રાખે છે!", "hi": "क्या आपको पता है? सूरजमुखी हमेशा अपना सिर सूरज की ओर रखते हैं जैसे-जैसे वह आकाश में घूमता है!"}'::jsonb,
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

INSERT INTO public.nature
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'mushroom',
  (SELECT id FROM categories WHERE category_key = 'nature' LIMIT 1),
  '{"en": "Mushroom", "gu": "મશરૂમ", "hi": "मशरूम"}'::jsonb,
  '/assets/images/nature/mushroom.png',
  '{"en": "Mushroom! Mushrooms are fungi that often look like little umbrellas growing on the ground.", "gu": "મશરૂમ! મશરૂમ એ ફૂગ છે જે ઘણીવાર જમીન પર ઉગતી નાની છત્રીઓ જેવી લાગે છે.", "hi": "मशरूम! मशरूम कवक होते हैं जो अक्सर जमीन पर उगने वाली छोटी छतरियों की तरह दिखते हैं।"}'::jsonb,
  '{"en": "Mushrooms like to grow in damp, shady places. Some are safe to eat, but others can be very dangerous!", "gu": "મશરૂમ્સ ભેજવાળી, છાયાદાર જગ્યાએ ઉગવાનું પસંદ કરે છે. કેટલાક ખાવા માટે સલામત છે, પરંતુ અન્ય જોખમી હોઈ શકે છે!", "hi": "मशरूम नम, छायादार जगहों पर उगना पसंद करते हैं। कुछ खाने के लिए सुरक्षित होते हैं, लेकिन अन्य बहुत खतरनाक हो सकते हैं!"}'::jsonb,
  '{"en": "Did you know? Some mushrooms can glow in the dark! This is called bioluminescence.", "gu": "શું તમે જાણો છો? કેટલાક મશરૂમ્સ અંધારામાં ચમકી શકે છે! આને બાયોલ્યુમિનેસન્સ કહેવાય છે.", "hi": "क्या आपको पता है? कुछ मशरूम अंधेरे में चमक सकते हैं! इसे बायोलुमिनेसेंस कहा जाता है।"}'::jsonb,
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
