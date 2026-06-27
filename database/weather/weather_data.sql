-- 1. Create weather table and index

CREATE TABLE IF NOT EXISTS public.weather (
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
  constraint weather_pkey primary key (id),
  constraint weather_topic_key_key unique (topic_key),
  constraint weather_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_weather_topic_key on public.weather using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.weather DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.weather TO anon;
GRANT ALL ON public.weather TO authenticated;
GRANT ALL ON public.weather TO service_role;


-- 2. Insert category into categories table (if not exists)

INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'weather',
  '{"en": "Weather", "gu": "હવામાન", "hi": "मौसम"}'::jsonb,
  '#03A9F4',
  false,
  'natures_world',
  20
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 3. Populate weather table with 10 weather conditions

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sunny',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Sunny", "gu": "તડકો", "hi": "धूप"}'::jsonb,
  'assets/images/weather/sunny.png',
  '{"en": "Sunny! The sun is shining bright and the sky is clear and beautiful!", "gu": "તડકો! સૂર્ય ચમકી રહ્યો છે અને આકાશ સ્વચ્છ અને સુંદર છે!", "hi": "धूप! सूरज चमक रहा है और आसमान साफ और सुंदर है!"}'::jsonb,
  '{"en": "On a sunny day, the sky is clear and the sun shines brightly. It''s perfect for playing outside, going to the park, or having a picnic!", "gu": "તડકાના દિવસે, આકાશ સ્વચ્છ હોય છે અને સૂર્ય ચમકે છે. બહાર રમવા, પાર્કમાં જવા અથવા પિકનિક માટે આ સૌથી સારો સમય છે!", "hi": "धूप वाले दिन, आसमान साफ होता है और सूरज चमकता है। यह बाहर खेलने, पार्क जाने या पिकनिक के लिए बिल्कुल सही होता है!"}'::jsonb,
  '{"en": "Did you know? The sun is so powerful that in just one hour, it sends enough energy to Earth to power the whole world for an entire year!", "gu": "શું તમે જાણો છો? સૂર્ય એટલો શક્તિશાળી છે કે માત્ર એક કલાકમાં, તે પૃથ્વી પર એટલી ઊર્જા મોકલે છે જે આખી દુનિયા આખા વર્ષ સુધી ચાલી શકે!", "hi": "क्या आपको पता है? सूरज इतना शक्तिशाली है कि सिर्फ एक घंटे में, वह पृथ्वी पर इतनी ऊर्जा भेजता है जो पूरी दुनिया को एक साल तक चला सकती है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cloudy',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Cloudy", "gu": "વાદળ", "hi": "बादल"}'::jsonb,
  'assets/images/weather/cloudy.png',
  '{"en": "Cloudy! Fluffy white clouds are floating across the sky today!", "gu": "વાદળ! આજે આકાશમાં રૂ જેવા સફેદ વાદળ તરી રહ્યા છે!", "hi": "बादल! आज आसमान में रुई जैसे सफेद बादल तैर रहे हैं!"}'::jsonb,
  '{"en": "On a cloudy day, fluffy white clouds cover parts of the sky. Clouds are made of millions of tiny water droplets floating in the air! They look like cotton candy in the sky!", "gu": "વાદળવાળા દિવસે, રૂ જેવા સફેદ વાદળ આકાશના ભાગોને ઢાંકી દે છે. વાદળ હવામાં તરતા લાખો નાના પાણીના ટીપાંઓ વડે બને છે! તે આકાશમાં કોટન કેન્ડી જેવા દેખાય છે!", "hi": "बादलों वाले दिन, रुई जैसे सफेद बादल आसमान के कुछ हिस्सों को ढक लेते हैं। बादल हवा में तैरते लाखों छोटे पानी की बूंदों से बने होते हैं! वे आसमान में कॉटन कैंडी जैसे दिखते हैं!"}'::jsonb,
  '{"en": "Did you know? A single fluffy cloud can weigh more than a million pounds — as heavy as 100 elephants — but still floats because the air holds it up!", "gu": "શું તમે જાણો છો? એક જ રૂ જેવો વાદળ 10 લાખ પાઉન્ડ કરતાં વધુ વજન ધરાવી શકે છે — 100 હાથી જેટલો ભારે — પણ હવા તેને ટેકો આપે છે!", "hi": "क्या आपको पता है? एक ही रुई जैसा बादल 10 लाख पाउंड से ज़्यादा वजनी हो सकता है — 100 हाथियों जितना भारी — फिर भी हवा उसे ऊपर रखती है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rainy',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Rainy", "gu": "વરસાદ", "hi": "बारिश"}'::jsonb,
  'assets/images/weather/rainy.png',
  '{"en": "Rainy! Drip, drop! Rain is falling from the clouds up above!", "gu": "વરસાદ! ટીપ, ટીપ! ઉપર વાદળોમાંથી વરસાદ પડી રહ્યો છે!", "hi": "बारिश! टिप, टिप! ऊपर बादलों से बारिश गिर रही है!"}'::jsonb,
  '{"en": "When it rains, water droplets fall from clouds to the ground. Rain fills rivers, lakes, and helps plants and trees grow. After rain, you might even spot a beautiful rainbow!", "gu": "જ્યારે વરસાદ પડે છે, ત્યારે વાદળોમાંથી પાણીના ટીપાં જમીન પર પડે છे. વરસાદ નદીઓ, તળાવો ભરે છે અને છોડ-વૃક્ષોને ઉગવામાં મદદ કરે છે. વરસાદ પછી, તમે સુંદર મેઘધનુષ્ય પણ જોઈ શકો!", "hi": "जब बारिश होती है, तो बादलों से पानी की बूंदें जमीन पर गिरती हैं। बारिश नदियों, झीलों को भरती है और पेड़-पौधों को उगाने में मदद करती है। बारिश के बाद, आप एक सुंदर इंद्रधनुष भी देख सकते हैं!"}'::jsonb,
  '{"en": "Did you know? A raindrop falling from a cloud takes about 2 minutes to reach the ground, and it travels at about 20 miles per hour!", "gu": "શું તમે જાણો છો? વાદળમાંથી પડતા વરસાદના ટીપાને જમીન સુધી પહોંચવામાં લગભગ 2 મિનિટ લાગે છે, અને તે લગભગ 20 માઈલ પ્રતિ કલાકની ઝડપે આગળ વધે છે!", "hi": "क्या आपको पता है? बादल से गिरने वाली बारिश की बूंद को जमीन तक पहुंचने में लगभग 2 मिनट लगते हैं, और यह लगभग 20 मील प्रति घंटे की रफ्तार से चलती है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'snowy',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Snowy", "gu": "હિમ", "hi": "बर्फ"}'::jsonb,
  'assets/images/weather/snowy.png',
  '{"en": "Snowy! White snowflakes are falling softly from the sky!", "gu": "હિમ! સફેદ હિમ-કણો આકાશમાંથી ધીમે-ધીમે પડી રહ્યા છે!", "hi": "बर्फ! सफेद बर्फ के टुकड़े आसमान से धीरे-धीरे गिर रहे हैं!"}'::jsonb,
  '{"en": "Snow happens when water droplets in clouds freeze into ice crystals and fall as snowflakes. Every single snowflake has a unique, beautiful six-sided shape. No two snowflakes are exactly alike!", "gu": "જ્યારે વાદળોમાં પાણીના ટીપાં બરફના સ્ફટિકો બની ઘઉં કે ચોખા જેવા ટુકડા બને ત્યારે હિમ-કણ (snowflake) બને છે. દરેક એક હિમ-કણ અલગ, સુંદર છ-ખૂણાવાળો આકાર ધરાવે છે. કોઈ પણ બે હિમ-કણ બિલકુલ સરખા નથી!", "hi": "जब बादलों में पानी की बूंदें जमकर बर्फ के क्रिस्टल बन जाती हैं और बर्फ के टुकड़ों के रूप में गिरती हैं, तो बर्फबारी होती है। हर एक बर्फ का टुकड़ा एक अनोखी, सुंदर छह-कोने वाली आकृति में होता है। कोई भी दो बर्फ के टुकड़े बिल्कुल एक जैसे नहीं होते!"}'::jsonb,
  '{"en": "Did you know? Scientists estimate that around 1 million billion snowflakes fall on Earth every second during a snowstorm — that''s more than all the stars in our galaxy!", "gu": "શું તમે જાણો છો? વૈજ્ઞાનિકો અંદાજ લગાવે છે કે હિમ-વાવાઝોડા દરમ્યાન દર સેકન્ડે પૃથ્વી પર 10 લાખ અબજ જેટલા હિમ-કણ પડે છે — આ આપણી આકાશગંગામાં તારાઓ કરતાં પણ વધુ છે!", "hi": "क्या आपको पता है? वैज्ञानिकों का अनुमान है कि बर्फीले तूफान के दौरान हर सेकंड पृथ्वी पर लगभग 10 लाख अरब बर्फ के टुकड़े गिरते हैं — यह हमारी आकाशगंगा के तारों से भी ज़्यादा है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'thunderstorm',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Thunderstorm", "gu": "વીજળી", "hi": "तूफान"}'::jsonb,
  'assets/images/weather/thunderstorm.png',
  '{"en": "Thunderstorm! Boom! Bright lightning flashes across the dark sky!", "gu": "વીજળી! ગડગડાટ! અંધારા આકાશમાં ચળકતી વીજળી ઝળકી ઊઠે છે!", "hi": "तूफान! गड़गड़ाहट! अंधेरे आसमान में चमकती बिजली कड़कती है!"}'::jsonb,
  '{"en": "A thunderstorm has dark clouds, heavy rain, lightning flashes, and loud thunder. Lightning is a huge spark of electricity in the sky. The thunder sound comes after because sound travels slower than light!", "gu": "વાવાઝોડામાં કાળા વાદળ, ભારે વરસાદ, વીજળીની ઝળક અને ગડગડાટ હોય છે. વીજળી એ આકાશમાં વિદ્યુત ઊર્જાની વિશાળ ઝળક છે. ગડગડાટ અવાજ પ્રકાશ કરતા ધીમો ચાલે છે, એટલે પાછળ સંભળાય છે!", "hi": "आंधी-तूफान में काले बादल, भारी बारिश, बिजली की चमक और तेज़ गड़गड़ाहट होती है। बिजली आसमान में बिजली की एक विशाल चिंगारी है। गड़गड़ाहट की आवाज़ बाद में आती है क्योंकि आवाज़ प्रकाश से धीरे चलती है!"}'::jsonb,
  '{"en": "Did you know? Lightning is 5 times hotter than the surface of the sun — it reaches about 30,000 Kelvin, while the sun''s surface is only about 6,000 Kelvin!", "gu": "શું તમે જાણો છો? વીજળી સૂર્યની સપાટી કરતાં 5 ગણી ગરમ હોય છે — તે લગભગ 30,000 કેલ્વિન સુધી પહોંચે છે, જ્યારે સૂર્યની સપાટી માત્ર 6,000 કેલ્વિન છે!", "hi": "क्या आपको पता है? बिजली सूरज की सतह से 5 गुना ज़्यादा गर्म होती है — यह लगभग 30,000 केल्विन तक पहुंचती है, जबकि सूरज की सतह केवल 6,000 केल्विन है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'windy',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Windy", "gu": "પવન", "hi": "हवा"}'::jsonb,
  'assets/images/weather/windy.png',
  '{"en": "Windy! Whoosh! The wind is blowing and making the trees dance!", "gu": "પવન! સૂ-સૂ! પવન ફૂંકાઈ રહ્યો છે અને ઝાડોને નૃત્ય કરાવી રહ્યો છે!", "hi": "हवा! सूं-सूं! हवा चल रही है और पेड़ों को नाच रही है!"}'::jsonb,
  '{"en": "Wind is moving air! When the sun heats some parts of Earth more than others, warm air rises and cool air rushes in to take its place — that''s wind! It can fly kites, spin windmills, and move sailboats!", "gu": "પવન એ ચાલતી હવા છે! જ્યારે સૂર્ય પૃથ્વીના કેટલાક ભાગોને વધુ ગરમ કરે છે, ત્યારે ગરમ હવા ઉપર જાય છે અને ઠંડી હવા ત્યાં ભરાઈ જાય છે — આ જ પવન છે! તે પતંગ ઉડાડી શકે, પવનચક્કી ફેરવી શકે, અને સઢ-નૌકાઓ ચલાવી શકે!", "hi": "हवा चलती हुई वायु है! जब सूरज पृथ्वी के कुछ हिस्सों को ज़्यादा गर्म करता है, तो गर्म हवा ऊपर उठती है और ठंडी हवा उसकी जगह लेने आती है — यही हवा है! यह पतंग उड़ा सकती है, पवनचक्की घुमा सकती है, और नाव चला सकती है!"}'::jsonb,
  '{"en": "Did you know? The fastest wind speed ever recorded on Earth was 253 mph (408 km/h) during Cyclone Olivia in Australia in 1996 — that''s faster than a racing car!", "gu": "શું તમે જાણો છો? 1996 માં ઓસ્ટ્રેલિયામાં ચક્રવાત ઓલિવિયા દ્યારા પૃથ્વી પર ઘાસ-ભૂ ઉપર નોંધાયેલ સૌથી ઝડપી પવનની ઝડપ 253 mph (408 km/h) હતી — આ રેસ-કારથી પણ ઝડપી છે!", "hi": "क्या आपको पता है? 1996 में ऑस्ट्रेलिया में साइक्लोन ओलिविया के दौरान पृथ्वी पर दर्ज की गई सबसे तेज़ हवा की गति 253 mph (408 km/h) थी — यह एक रेसिंग कार से भी तेज़ है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'foggy',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Foggy", "gu": "ધુમ્મસ", "hi": "कोहरा"}'::jsonb,
  'assets/images/weather/foggy.png',
  '{"en": "Foggy! Everything looks hazy and mysterious in the thick fog!", "gu": "ધુમ્મસ! ઘેઘૂર ધુમ્મસમાં બધું ઝાંખું અને રહસ્યમય દેખાય છે!", "hi": "कोहरा! घने कोहरे में सब कुछ धुंधला और रहस्यमय लगता है!"}'::jsonb,
  '{"en": "Fog is basically a cloud that forms very close to the ground! It''s made of millions of tiny water droplets floating in the air. Fog usually appears in the morning and disappears when the sun warms up the air!", "gu": "ધુમ્મસ એ મૂળ રીતે એક વાદળ છે જે જમીનની ખૂબ નજીક બને છે! તે હવામાં તરતા લાખો નાના પાણીના ટીપાંઓ વડે બને છે. ધુમ્મસ સામાન્ય રીતે સવારે ઉભું થાય છે અને સૂર્ય હવા ગરમ થવા પર ગાયબ થઈ જાય છે!", "hi": "कोहरा मूल रूप से एक बादल है जो जमीन के बहुत करीब बनता है! यह हवा में तैरती लाखों छोटी पानी की बूंदों से बना होता है। कोहरा आमतौर पर सुबह दिखाई देता है और सूरज के हवा गर्म करने पर गायब हो जाता है!"}'::jsonb,
  '{"en": "Did you know? The foggiest place on Earth is the Grand Banks off the coast of Newfoundland, Canada, where warm and cold ocean currents meet and create fog for over 200 days a year!", "gu": "શું તમે જાણો છો? પૃથ્વી પર સૌથી વધુ ધુમ્મસ ધરાવતું સ્થળ ન્યૂફાઉન્ડલેન્ડ, કેનેડાના દરિયા કિનારે ગ્રાન્ડ બેન્ક્સ છે, જ્યાં ગરમ અને ઠંડા સમુદ્ર પ્રવાહ મળે છે અને વર્ષમાં 200 દિવસથી વધુ ધુમ્મસ ઉભું થાય છે!", "hi": "क्या आपको पता है? पृथ्वी पर सबसे अधिक कोहरे वाली जगह कनाडा के न्यूफाउंडलैंड तट पर ग्रैंड बैंक्स है, जहां गर्म और ठंडी समुद्री धाराएं मिलती हैं और साल में 200 से ज़्यादा दिन कोहरा छाया रहता है!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'night',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Night", "gu": "રાત", "hi": "रात"}'::jsonb,
  'assets/images/weather/night.png',
  '{"en": "Night! The moon is glowing and the stars are twinkling in the dark sky!", "gu": "રાત! ચંદ્ર ઝળઝળી રહ્યો છે અને અંધારા આકાશમાં તારાઓ ટમટમી રહ્યા છે!", "hi": "रात! चंद्रमा चमक रहा है और अंधेरे आसमान में तारे टिमटिमा रहे हैं!"}'::jsonb,
  '{"en": "At night, our side of Earth faces away from the sun, making it dark. The moon reflects sunlight to glow in the night sky. On a clear night, you can see thousands of twinkling stars!", "gu": "રાત્રે, આપણી પૃથ્વીની બાજુ સૂર્યથી દૂર ફરે છે, જેના કારણે અંધારું થઈ જાય છે. ચંદ્ર સૂર્યના પ્રકાશને પ્રતિબિંબિત કરીને રાત્રિ આકાશમાં ચળકે છે. ચોખ્ખી રાત્રે, તમે હજારો ટમટમતા તારાઓ જોઈ શકો છો!", "hi": "रात में, हमारी पृथ्वी का हिस्सा सूरज से दूर हो जाता है, जिससे अंधेरा हो जाता है। चंद्रमा सूर्य के प्रकाश को परावर्तित करके रात के आसमान में चमकता है। साफ रात में, आप हजारों टिमटिमाते तारे देख सकते हैं!"}'::jsonb,
  '{"en": "Did you know? There are more stars in the universe than grains of sand on all the beaches on Earth — an estimated 1 septillion (1 followed by 24 zeros) stars!", "gu": "શું તમે જાણો છો? બ્રહ્માંડમાં પૃથ્વી પરના તમામ દરિયા કિનારાઓ ઉપર રેતીના દાણા કરતા પણ વધારે તારાઓ છે — અંદાજે 1 સેપ્ટિલિયન (1 પછી 24 શૂન્ય) તારાઓ!", "hi": "क्या आपको पता है? ब्रह्मांड में पृथ्वी के सभी समुद्र तटों पर रेत के कणों से भी ज़्यादा तारे हैं — अनुमानित 1 सेप्टिलियन (1 के बाद 24 शून्य) तारे!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rainbow',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Rainbow", "gu": "મેઘધનુષ", "hi": "इंद्रधनुष"}'::jsonb,
  'assets/images/weather/rainbow.png',
  '{"en": "Rainbow! Look at those beautiful colors arching across the sky!", "gu": "મેઘધનુષ! આકાશમાં ફૂટી નીકળ્યા સુંદર રંગો જુઓ!", "hi": "इंद्रधनुष! आसमान में चमकते उन खूबसूरत रंगों को देखो!"}'::jsonb,
  '{"en": "A rainbow appears when sunlight shines through raindrops in the air. The raindrops act like tiny prisms that split white sunlight into seven beautiful colors: Red, Orange, Yellow, Green, Blue, Indigo, and Violet!", "gu": "જ્યારે સૂર્યનો પ્રકાશ હવામાં વરસાદના ટીપાઓ દ્વારા ચમકે છે ત્યારે મેઘધનુષ ઉભું થાય છે. વરસાદના ટીપાઓ નાના પ્રિઝ્મ જેવા કાર્ય કરે છે જે સૂર્યના સફેદ પ્રકાશને સાત સુંદર રંગોમાં વિભાજિત કરે છે: લાલ, નારંગી, પીળો, લીલો, વાદળી, ઘઘૂઘ (ઇન્ડિગો) અને જાંબલી!", "hi": "जब हवा में वर्षा की बूंदों से सूर्य का प्रकाश गुजरता है तो इंद्रधनुष दिखाई देता है। वर्षा की बूंदें छोटे प्रिज्म की तरह काम करती हैं जो सफेद सूर्यप्रकाश को सात खूबसूरत रंगों में बांट देती हैं: लाल, नारंगी, पीला, हरा, नीला, बैंगनी, और गहरा बैंगनी!"}'::jsonb,
  '{"en": "Did you know? A rainbow is actually a full circle! We only see an arc from the ground. If you were in an airplane above the clouds, you could see the whole circle rainbow!", "gu": "શું તમે જાણો છો? મેઘધનુષ ખરેખર એક સંપૂર્ણ વર્તુળ છે! જમીન પરથી આપણે માત્ર અર્ધ-ચાપ જ જોઈ શકીએ. જો તમે વાદળ ઉપર વિમાનમાં હો, તો તમે સંપૂર્ણ ગોળ મેઘધનુષ જોઈ શકો!", "hi": "क्या आपको पता है? इंद्रधनुष वास्तव में एक पूरा वृत्त होता है! जमीन से हम केवल एक चाप देखते हैं। अगर आप बादलों के ऊपर विमान में होते, तो आप पूरा गोल इंद्रधनुष देख सकते थे!"}'::jsonb,
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

INSERT INTO public.weather
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hail',
  (SELECT id FROM categories WHERE category_key = 'weather' LIMIT 1),
  '{"en": "Hail", "gu": "કરા", "hi": "ओले"}'::jsonb,
  'assets/images/weather/hail.png',
  '{"en": "Hail! Tiny balls of ice are falling from the sky — ping, ping, ping!", "gu": "કરા! આકાશમાંથી નાની-નાની બરફની ગોળીઓ પડી રહી છે — ઠક, ઠક, ઠક!", "hi": "ओले! आसमान से छोटी-छोटी बर्फ की गोलियां गिर रही हैं — ठक, ठक, ठक!"}'::jsonb,
  '{"en": "Hail forms inside powerful thunderstorm clouds called supercells. Water droplets freeze into ice pellets and get tossed up and down by strong winds, growing bigger and bigger before falling to the ground!", "gu": "કરા શક્તિશાળી ગર્જના-વાવાઝોડાના વાદળોમાં બને છે. પાણીના ટીپां બરફની ગોળીઓ બને છે અને તીવ્ર પવન દ્વારા ઉપર-નીચે ઉછળે છे, જ્યારે વધુ ને વધુ મોટા nes ते पहले नीचे जमीन पर गिरते हैं!", "hi": "ओले शक्तिशाली गर्जनावाले तूफानी बादलों में बनते हैं। पानी की बूंदें जमकर बर्फ की गोलियां बन जाती हैं और तेज़ हवाओं द्वारा ऊपर-नीचे उछाली जाती हैं, बड़ी होती जाती हैं और फिर जमीन पर गिरती हैं!"}'::jsonb,
  '{"en": "Did you know? The largest hailstone ever recorded was the size of a volleyball — it fell in South Dakota, USA in 2010 and measured 8 inches (20 cm) across!", "gu": "શું તમે જાણો છો? અત્યાર સુધી નોંધાયેલ સૌથી મોટો કરો વૉલીબૉલ જેટલો મોટો હતો — તે 2010 માં USA ના સાઉથ ડાકોટામાં પડ્યો હતો અને 8 ઇંચ (20 સે.મી.) પહોળો હતો!", "hi": "क्या आपको पता है? अब तक दर्ज किया गया सबसे बड़ा ओला वॉलीबॉल के आकार का था — यह 2010 में अमेरिका के साउथ डकोटा में गिरा था और 8 इंच (20 सेमी) चौड़ा था!"}'::jsonb,
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
