-- 1. Create habits table

CREATE TABLE IF NOT EXISTS public.habits (
  id bigint generated always as identity not null,
  topic_key text not null,
  category_id bigint null,
  name jsonb not null default '{}'::jsonb,
  image_path text null,
  svg_path text null,
  lottie_path text null,
  hex_code text null,
  narration jsonb not null default '{}'::jsonb,
  explanation jsonb not null default '{}'::jsonb,
  fact jsonb not null default '{}'::jsonb,
  game_type text null,
  is_free boolean not null default true,
  display_order integer null,
  constraint habits_pkey primary key (id),
  constraint habits_topic_key_key unique (topic_key),
  constraint habits_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_habits_topic_key on public.habits using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.habits DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.habits TO anon;
GRANT ALL ON public.habits TO authenticated;
GRANT ALL ON public.habits TO service_role;


-- 2. Reset sequence & insert category

SELECT setval(
  pg_get_serial_sequence('public.categories', 'id'),
  COALESCE((SELECT MAX(id) FROM public.categories), 0) + 1,
  false
);

INSERT INTO public.categories (category_key, title, color, is_premium, group_id, display_order)
VALUES (
  'habits',
  '{"en": "Good Habits", "gu": "સારી ટેવો", "hi": "अच्छी आदतें"}'::jsonb,
  '#4DB6AC',
  false,
  'brain_and_skill',
  25
)
ON CONFLICT (category_key) DO UPDATE SET
  title = EXCLUDED.title,
  color = EXCLUDED.color,
  group_id = EXCLUDED.group_id,
  display_order = EXCLUDED.display_order;


-- 3. Seed habits entries (20 items)

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'brushing_teeth',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Brushing Teeth","gu":"દાંત સાફ કરવા","hi":"दांत साफ करना"}'::jsonb,
  'assets/images/habits/brushing_teeth.png',
  '#4DB6AC',
  '{"en":"Brushing teeth! Brushing your teeth twice a day keeps them clean and shiny!","gu":"દાંત સાફ કરવા! દિવસમાં બે વાર બ્રશ કરવાથી તમારા દાંત સાફ અને ચમકદાર રહે છે!","hi":"दांत साफ करना! दिन में दो बार ब्रश करने से आपके दांत साफ और चमकदार रहते हैं!"}'::jsonb,
  '{"en":"We should brush our teeth in the morning and before sleeping. Brushing removes food particles and keeps our mouth fresh and healthy!","gu":"આપણે સવારે અને સૂતા પહેલા બ્રશ કરવું જોઈએ. બ્રશ કરવાથી મોંમાંથી ખોરાકના કણો દૂર થાય છે અને મોં તાજું રહે છે!","hi":"हमें सुबह और सोने से पहले ब्रश करना चाहिए। ब्रश करने से मुंह के कीटाणु दूर होते हैं और मुंह स्वस्थ रहता है!"}'::jsonb,
  '{"en":"Did you know? Snails have the most teeth of any animal — some have over 20,000 tiny teeth in their mouth!","gu":"શું તમે જાણો છો? ગોકળગાયને મોંમાં સૌથી વધુ દાંત હોય છે — કેટલાકના મોંમાં ૨૦,૦૦૦ થી વધુ નાના દાંત હોય છે!","hi":"क्या आपको पता है? घोंघे के मुंह में सबसे ज्यादा दांत होते हैं — कुछ के मुंह में 20,000 से भी अधिक छोटे दांत होते हैं!"}'::jsonb,
  'memory',
  true,
  1
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'combing_hair',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Combing Hair","gu":"વાળ ઓળાવા","hi":"बाल कंघी करना"}'::jsonb,
  'assets/images/habits/combing_hair.png',
  '#80CBC4',
  '{"en":"Combing hair! Combing your hair neatly makes you look smart and tidy!","gu":"વાળ ઓળાવા! તમારા વાળ વ્યવસ્થિત રીતે ઓળાવવાથી તમે સ્માર્ટ અને સ્વચ્છ લાગો છો!","hi":"बाल कंघी करना! अपने बालों को अच्छे से संवारने से आप साफ-सुथरे और सुंदर दिखते हैं!"}'::jsonb,
  '{"en":"Combing keeps our hair clean and untangled. Using our own clean comb or brush daily is a great habit!","gu":"વાળ ઓળાવવાથી તે ગૂંચવાતા નથી અને સ્વચ્છ રહે છે. રોજ પોતાની અલગ કાંસકી વાપરવી એ સારી ટેવ છે!","hi":"कंघी करने से हमारे बाल साफ और सुलझे रहते हैं। प्रतिदिन अपनी खुद की कंघा उपयोग करना एक अच्छी आदत है!"}'::jsonb,
  '{"en":"Did you know? Healthy hair is actually very strong — a single strand of hair can support the weight of a small apple!","gu":"શું તમે જાણો છો? તંદુરસ્ત વાળ ખરેખર ખૂબ જ મજબૂત હોય છે — વાળનો એક નાનો તાર સફરજન જેટલું વજન પણ ખમી શકે છે!","hi":"क्या आपको पता है? स्वस्थ बाल वास्तव में बहुत मजबूत होते हैं — बाल का एक टुकड़ा एक छोटे सेब का वजन भी उठा सकता है!"}'::jsonb,
  'memory',
  true,
  2
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'washing_hands',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Washing Hands","gu":"હાથ ધોવા","hi":"हाथ धोना"}'::jsonb,
  'assets/images/habits/washing_hands.png',
  '#26A69A',
  '{"en":"Washing hands! Washing hands with soap removes germs and keeps us healthy!","gu":"હાથ ધોવા! સાબુથી હાથ ધોવાથી જીવાણુઓ દૂર થાય છે અને આપણે સ્વસ્થ રહીએ છીએ!","hi":"हाथ धोना! साबुन से हाथ धोने से कीटाणु साफ होते हैं और हम बीमार नहीं पड़ते!"}'::jsonb,
  '{"en":"Always wash your hands before eating and after playing or using the restroom. Scrubbing for 20 seconds makes them germ-free!","gu":"જમતા પહેલા અને રમત રમ્યા પછી હંમેશા હાથ ધોવા જોઈએ. ૨૦ સેકન્ડ સુધી હાથ ઘસવાથી તે જંતુમુક્ત બને છે!","hi":"हमेशा खाना खाने से पहले और खेलने के बाद हाथ धोएं। 20 सेकंड तक हाथ रगड़ने से वे कीटाणु-मुक्त हो जाते हैं!"}'::jsonb,
  '{"en":"Did you know? Washing hands with soap is the single most effective way to prevent the spread of cold and flu germs!","gu":"શું તમે જાણો છો? સાબુથી હાથ ધોવા એ શરદી અને તાવના જંતુઓ ફેલાતા રોકવાનો સૌથી અસરકારક રસ્તો છે!","hi":"क्या आपको पता है? साबुन से हाथ धोना सर्दी और फ्लू के कीटाणुओं को फैलने से रोकने का सबसे असरदार तरीका है!"}'::jsonb,
  'memory',
  true,
  3
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'taking_bath',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Taking a Bath","gu":"સ્નાન કરવું","hi":"स्नान करना"}'::jsonb,
  'assets/images/habits/taking_bath.png',
  '#00897B',
  '{"en":"Taking a bath! Taking a warm bath daily keeps our body clean and refreshed!","gu":"સ્નાન કરવું! રોજ સ્નાન કરવાથી આપણું શરીર સ્વચ્છ અને સ્ફૂર્તિલું રહે છે!","hi":"स्नान करना! रोजाना स्नान करने से हमारा शरीर साफ और तरोताजा रहता है!"}'::jsonb,
  '{"en":"Bathing washes away sweat, dirt, and germs from our skin. It helps us feel energetic in the morning and sleep peacefully at night!","gu":"નાહવાથી આપણા શરીર પરથી પરસેવો અને ધૂળ સાફ થઈ જાય છે. તે આપણને સવારે તાજગી આપે છે અને રાત્રે સારી ઊંઘ લાવે છે!","hi":"नहाने से हमारी त्वचा से पसीना और धूल साफ हो जाती है। यह हमें सुबह ऊर्जा देता है और रात में अच्छी नींद लाता है!"}'::jsonb,
  '{"en":"Did you know? Bubble baths were invented in the 1960s to make bath time fun and exciting for children!","gu":"શું તમે જાણો છો? બાળકો માટે નાહવાનો સમય મનોરંજક બનાવવા ૧૯૬૦ ના દાયકામાં બબલ બાથની શોધ કરવામાં આવી હતી!","hi":"क्या आपको पता है? बच्चों के लिए नहाने को मजेदार बनाने के लिए 1960 के दशक में बबल बाथ का आविष्कार किया गया था!"}'::jsonb,
  'memory',
  true,
  4
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'wearing_clean_clothes',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Wearing Clean Clothes","gu":"સ્વચ્છ કપડાં પહેરવા","hi":"साफ कपड़े पहनना"}'::jsonb,
  'assets/images/habits/wearing_clean_clothes.png',
  '#00796B',
  '{"en":"Wearing clean clothes! Dressing in clean, fresh clothes makes us feel happy and look tidy!","gu":"સ્વચ્છ કપડાં પહેરવા! સ્વચ્છ અને ધોયેલા કપડાં પહેરવાથી આપણે ખુશ રહીએ છીએ અને સુઘડ દેખાઈએ છીએ!","hi":"साफ कपड़े पहनना! साफ और धुले कपड़े पहनने से हम खुश महसूस करते हैं और अच्छे दिखते हैं!"}'::jsonb,
  '{"en":"After a bath, always wear fresh, washed clothes. It protects our skin from dirt and makes us feel ready for a wonderful day!","gu":"નાહ્યા પછી હંમેશા સ્વચ્છ કપડાં જ પહેરો. તે આપણી ત્વચાને ધૂળથી બચાવે છે અને આપણને દિવસ માટે તૈયાર કરે છે!","hi":"नहाने के बाद हमेशा साफ कपड़े पहनें। यह हमारी त्वचा को धूल से बचाता है और हमें दिन की शुरुआत के लिए तैयार करता है!"}'::jsonb,
  '{"en":"Did you know? Colors of clothes can affect how we feel! Bright colors like yellow can make us feel happy and energetic!","gu":"શું તમે જાણો છો? કપડાંના રંગો આપણા મૂડને અસર કરે છે! પીળા જેવા તેજસ્વી રંગો આપણને ખુશ અને ઉર્જાવાન બનાવે છે!","hi":"क्या आपको पता है? कपड़ों के रंग हमारे मूड को प्रभावित करते हैं! पीले जैसे चमकीले रंग हमें खुश और ऊर्जावान बनाते हैं!"}'::jsonb,
  'memory',
  true,
  5
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'drinking_water',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Drinking Water","gu":"પાણી પીવું","hi":"पानी पीना"}'::jsonb,
  'assets/images/habits/drinking_water.png',
  '#B2DFDB',
  '{"en":"Drinking water! Drinking plenty of water keeps our body active, hydrated, and strong!","gu":"પાણી પીવું! પૂરતું પાણી પીવાથી આપણું શરીર સક્રિય, સ્વસ્થ અને મજબૂત રહે છે!","hi":"पानी पीना! पर्याप्त पानी पीने से हमारा शरीर सक्रिय, स्वस्थ और मजबूत रहता है!"}'::jsonb,
  '{"en":"Water helps our brain think and gives us energy to run and play. We should drink water whenever we feel thirsty!","gu":"પાણી આપણા મગજને સક્રિય રાખે છે અને રમવા માટે શક્તિ આપે છે. જ્યારે પણ તરસ લાગે ત્યારે પાણી પીવું જોઈએ!","hi":"पानी हमारे दिमाग को सक्रिय रखता है और हमें खेलने की ऊर्जा देता है। जब भी प्यास लगे, पानी जरूर पीना चाहिए!"}'::jsonb,
  '{"en":"Did you know? More than half of our body is made up of water! That is why drinking water is so important!","gu":"શું તમે જાણો છો? આપણા શરીરનો અડધાથી વધુ ભાગ પાણીનો બનેલો છે! તેથી જ પાણી પીવું ખૂબ જ જરૂરી છે!","hi":"क्या आपको पता है? हमारे शरीर का आधे से अधिक हिस्सा पानी से बना है! इसलिए पानी पीना इतना महत्वपूर्ण है!"}'::jsonb,
  'memory',
  true,
  6
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'eating_healthy_food',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Eating Healthy Food","gu":"પૌષ્ટિક ખોરાક ખાવો","hi":"स्वस्थ भोजन करना"}'::jsonb,
  'assets/images/habits/eating_healthy_food.png',
  '#E0F2F1',
  '{"en":"Eating healthy food! Fresh fruits and vegetables give us vitamins to grow big and strong!","gu":"પૌષ્ટિક ખોરાક ખાવો! તાજા ફળો અને શાકભાજી આપણને મજબૂત બનાવવા માટે પોષક તત્વો આપે છે!","hi":"स्वस्थ भोजन करना! ताजे फल और सब्जियां हमें मजबूत बनाने के लिए पोषक तत्व देती हैं!"}'::jsonb,
  '{"en":"Healthy food like apples, carrots, and milk build strong bones and protect us from falling sick. Avoid too much junk food!","gu":"ફળો, શાકભાજી અને દૂધ જેવા ખોરાક હાડકાંને મજબૂત કરે છે અને આપણને બીમાર પડતા બચાવે છે. બહારનો જંક ફૂડ ન ખાવો જોઈએ!","hi":"फल, सब्जियां और दूध जैसे खाद्य पदार्थ हड्डियों को मजबूत करते हैं और हमें बीमार होने से बचाते हैं। जंक फूड से बचना चाहिए!"}'::jsonb,
  '{"en":"Did you know? Apples float in water because they are 25 percent air! That makes them a crunchy, fun snack!","gu":"શું તમે જાણો છો? સફરજન પાણીમાં તરે છે કારણ કે તેમાં ૨૫ ટકા હવા હોય છે! તેથી જ તે એક ક્રન્ચી નાસ્તો છે!","hi":"क्या आपको पता है? सेब पानी में तैरते हैं क्योंकि उनमें 25 प्रतिशत हवा होती है! इसलिए यह एक मजेदार नाश्ता है!"}'::jsonb,
  'memory',
  true,
  7
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sleeping_early',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Sleeping Early","gu":"વહેલા સૂઈ જવું","hi":"जल्दी सोना"}'::jsonb,
  'assets/images/habits/sleeping_early.png',
  '#004D40',
  '{"en":"Sleeping early! Going to bed early gives our brain and body the perfect rest to wake up happy!","gu":"વહેલા સૂઈ જવું! રાત્રે વહેલા સૂવાથી આપણું મગજ અને શરીર તાજગી મેળવે છે જેથી સવારે ખુશ રહી શકાય!","hi":"जल्दी सोना! रात को जल्दी सोने से हमारे दिमाग और शरीर को आराम मिलता है ताकि हम सुबह खुश उठ सकें!"}'::jsonb,
  '{"en":"Children need about 9 to 11 hours of sleep every night. While we sleep, our body grows and builds strong muscles!","gu":"બાળકોને દરરોજ રાત્રે ૯ થી ૧૧ કલાકની ઊંઘની જરૂર હોય છે. આપણે જ્યારે ઊંઘતા હોઈએ છીએ ત્યારે આપણું શરીર વિકાસ કરે છે!","hi":"बच्चों को हर रात 9 से 11 घंटे की नींद की जरूरत होती है। जब हम सोते हैं, तो हमारा शरीर बढ़ता और मजबूत होता है!"}'::jsonb,
  '{"en":"Did you know? Getting enough sleep helps you learn and remember things better at school the next day!","gu":"શું તમે જાણો છો? પૂરતી ઊંઘ લેવાથી તમને શાળામાં વસ્તુઓ વધુ સારી રીતે શીખવામાં અને યાદ રાખવામાં મદદ મળે છે!","hi":"क्या आपको पता है? पर्याप्त नींद लेने से आपको स्कूल में चीजें बेहतर ढंग से सीखने और याद रखने में मदद मिलती है!"}'::jsonb,
  'memory',
  true,
  8
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'exercising',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Exercising","gu":"કસરત કરવી","hi":"व्यायाम करना"}'::jsonb,
  'assets/images/habits/exercising.png',
  '#00695C',
  '{"en":"Exercising! Playing, stretching, and exercising daily makes our muscles and heart super strong!","gu":"કસરત કરવી! રોજ રમવાથી અને કસરત કરવાથી આપણી માંસપેશીઓ અને હૃદય ખૂબ મજબૂત બને છે!","hi":"व्यायाम करना! रोजाना खेलने और व्यायाम करने से हमारी मांसपेशियां और दिल बहुत मजबूत होते हैं!"}'::jsonb,
  '{"en":"Exercising keeps our body flexible and active. Running, jumping, dancing, and playing sports are all great ways to exercise!","gu":"કસરત કરવાથી શરીર લચીલું અને સક્રિય રહે છે. દોડવું, કૂદવું, ડાન્સ કરવો અને રમતો રમવી એ કસરત કરવાની ઉત્તમ રીતો છે!","hi":"व्यायाम करने से शरीर लचीला और सक्रिय रहता है। दौड़ना, कूदना, नाचना और खेल खेलना व्यायाम करने के बेहतरीन तरीके हैं!"}'::jsonb,
  '{"en":"Did you know? Laughing is also a form of exercise! It makes your heart pump faster and helps you feel happy!","gu":"શું તમે જાણો છો? હસવું એ પણ એક પ્રકારની કસરત છે! તે હૃદયના ધબકારા વધારે છે અને આપણને ખુશ રાખે છે!","hi":"क्या आपको पता है? हंसना भी एक प्रकार का व्यायाम है! यह दिल की धड़कन बढ़ाता है और हमें खुश रखता है!"}'::jsonb,
  'memory',
  true,
  9
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'sharing_toys',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Sharing Toys","gu":"રમકડાં વહેંચવા","hi":"खिलौने साझा करना"}'::jsonb,
  'assets/images/habits/sharing_toys.png',
  '#4DB6AC',
  '{"en":"Sharing toys! Sharing toys with friends makes playing together twice as much fun!","gu":"રમકડાં વહેંચવા! મિત્રો સાથે રમકડાં વહેંચીને રમવાથી રમવાની મજા બમણી થઈ જાય છે!","hi":"खिलौने साझा करना! दोस्तों के साथ खिलौने बांटकर खेलने से खेल का आनंद दोगुना हो जाता है!"}'::jsonb,
  '{"en":"Sharing is caring! When we share our toys and take turns, we make good friends and build happy memories.","gu":"વહેંચીને રમવું એ સદ્ગુણ છે! જ્યારે આપણે રમકડાં શેર કરીએ છીએ, ત્યારે આપણે સારા મિત્રો બનાવી શકીએ છીએ.","hi":"बांटना ही प्यार है! जब हम खिलौने साझा करते हैं और अपनी बारी का इंतजार करते हैं, तो हम अच्छे दोस्त बनाते हैं!"}'::jsonb,
  '{"en":"Did you know? Sharing triggers a happy feeling in our brain that makes us feel warm and joyful!","gu":"શું તમે જાણો છો? વહેંચવાથી મગજમાં એક સુખદ લાગણી ઉત્પન્ન થાય છે જે આપણને અતિશય આનંદ આપે છે!","hi":"क्या आपको पता है? साझा करने से दिमाग में एक सुखद भावना पैदा होती है जो हमें बहुत खुशी देती है!"}'::jsonb,
  'memory',
  true,
  10
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'saying_please',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Saying Please","gu":"મહેરબાની કરીને કહેવું","hi":"कृपया कहना"}'::jsonb,
  'assets/images/habits/saying_please.png',
  '#26A69A',
  '{"en":"Saying please! Saying please is a polite way to ask for things and shows respect!","gu":"નમ્રતાપૂર્વક કહેવું! જ્યારે કોઈ વસ્તુ જોઈએ ત્યારે નમ્રતાપૂર્વક માગવું એ આદર દર્શાવે છે!","hi":"कृपया कहना! जब कोई चीज चाहिए हो तो विनम्रता से मांगना सम्मान दर्शाता है!"}'::jsonb,
  '{"en":"When we want something, asking politely by adding ''please'' makes others happy to help us. It is a magic word!","gu":"જ્યારે આપણે કંઈક જોઈતું હોય, ત્યારે ''મહેરબાની કરીને'' (please) કહીને પૂછવાથી લોકો રાજી થઈને મદદ કરે છે. આ એક જાદુઈ શબ્દ છે!","hi":"जब हमें कुछ चाहिए, तो ''कृपया'' (please) कहकर मांगना दूसरों को खुश करता है। यह एक जादुई शब्द है!"}'::jsonb,
  '{"en":"Did you know? Magic words like please, thank you, and sorry are used all over the world to show kindness!","gu":"શું તમે જાણો છો? સમગ્ર વિશ્વમાં દયા અને માન દર્શાવવા માટે પ્લીઝ, થેંક યુ અને સોરી જેવા જાદુઈ શબ્દોનો ઉપયોગ થાય છે!","hi":"क्या आपको पता है? पूरी दुनिया में दयालुता दर्शाने के लिए प्लीज, थैंक यू और सॉरी जैसे जादुई शब्दों का उपयोग किया जाता है!"}'::jsonb,
  'memory',
  true,
  11
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'helping_others',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Helping Others","gu":"બીજાને મદદ કરવી","hi":"दूसरों की मदद करना"}'::jsonb,
  'assets/images/habits/helping_others.png',
  '#80CBC4',
  '{"en":"Helping others! Helping friends and parents makes our home and school a happier place!","gu":"બીજાને મદદ કરવી! મિત્રો અને માતા-પિતાને મદદ કરવાથી આપણું ઘર અને શાળા વધુ સુંદર બને છે!","hi":"दूसरों की मदद करना! दोस्तों और माता-पिता की मदद करने से हमारा घर और स्कूल अधिक खुशहाल बनते हैं!"}'::jsonb,
  '{"en":"Helping someone pick up dropped books or clean up toys shows kindness. Little acts of help make a big difference!","gu":"કોઈને પુસ્તકો ઉપાડવામાં કે રમકડાં ગોઠવવામાં મદદ કરવી એ દયા દર્શાવે છે. નાની મદદ પણ મોટું કામ કરી શકે છે!","hi":"किसी को गिरी हुई किताबें उठाने में या खिलौने समेटने में मदद करना दयालुता है। छोटी सी मदद भी बड़ा बदलाव लाती है!"}'::jsonb,
  '{"en":"Did you know? Doing something kind for others makes your own brain release happy chemicals that boost your mood!","gu":"શું તમે જાણો છો? બીજા માટે કોઈ સારું કામ કરવાથી તમારા પોતાના મગજમાં પણ આનંદના હોર્મોન્સ મુક્ત થાય છે!","hi":"क्या आपको पता है? दूसरों के लिए कुछ अच्छा करने से आपके अपने दिमाग में भी खुशी के रसायन निकलते हैं!"}'::jsonb,
  'memory',
  true,
  12
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'saying_thank_you',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Saying Thank You","gu":"આભાર માનવો","hi":"धन्यवाद कहना"}'::jsonb,
  'assets/images/habits/saying_thank_you.png',
  '#00897B',
  '{"en":"Saying thank you! Saying thank you shows appreciation when someone helps us or gives a gift!","gu":"આભાર માનવો! જ્યારે કોઈ આપણને મદદ કરે અથવા ભેટ આપે ત્યારે આભાર માનવો એ સભ્યતા છે!","hi":"धन्यवाद कहना! जब कोई हमारी मदद करे या उपहार दे तो धन्यवाद कहना शिष्टता है!"}'::jsonb,
  '{"en":"Saying ''thank you'' shows that we are grateful and happy. It is a simple word that brings a big smile to people''s faces!","gu":"''આભાર'' માનવાથી દર્શાવાય છે કે આપણે ખુશ છીએ. આ એક નાનો શબ્દ લોકોના ચહેરા પર સ્મિત લાવી શકે છે!","hi":"''धन्यवाद'' कहने से पता चलता है कि हम खुश हैं। यह एक छोटा सा शब्द लोगों के चेहरे पर बड़ी मुस्कान ला सकता है!"}'::jsonb,
  '{"en":"Did you know? Gratitude (saying thank you) actually helps you sleep better and feel more positive every day!","gu":"શું તમે જાણો છો? કૃતજ્ઞતા દર્શાવવાથી (આભાર માનવાથી) તમને રાત્રે સારી ઊંઘ આવે છે અને હકારાત્મકતા વધે છે!","hi":"क्या आपको पता है? आभार व्यक्त करने से आपको रात में बेहतर नींद आती है और सकारात्मकता बढ़ती है!"}'::jsonb,
  'memory',
  true,
  13
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fighting',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Fighting","gu":"ઝઘડો કરવો","hi":"लड़ाई करना"}'::jsonb,
  'assets/images/habits/fighting.png',
  '#E57373',
  '{"en":"Fighting! Fighting and arguing hurt feelings. We should use kind words to solve problems!","gu":"ઝઘડો કરવો! ઝઘડો કરવાથી સંબંધો બગડે છે. આપણે સમસ્યાઓ હલ કરવા નમ્ર શબ્દોનો ઉપયોગ કરવો જોઈએ!","hi":"लड़ाई करना! लड़ाई करने से रिश्ते खराब होते हैं। हमें समस्याओं को सुलझाने के लिए विनम्र शब्दों का उपयोग करना चाहिए!"}'::jsonb,
  '{"en":"Fighting is a bad habit that makes everyone sad. If you are angry, take a deep breath and talk calmly to resolve the issue.","gu":"ઝઘડો કરવો એ ખરાબ ટેવ છે જે બધાને ઉદાસ કરે છે. જો તમને ગુસ્સો આવે તો ઊંડો શ્વાસ લો અને શાંતિથી વાત કરો.","hi":"लड़ाई करना एक बुरी आदत है जो सभी को दुखी करती है। यदि आपको गुस्सा आए तो गहरा सांस लें और शांति से बात करें।"}'::jsonb,
  '{"en":"Did you know? Talking about your feelings is the best way to resolve anger without fighting!","gu":"શું તમે જાણો છો? લડ્યા વિના ગુસ્સો શાંત કરવા માટે તમારી લાગણીઓ વિશે ખુલીને વાત કરવી એ જ સર્વોત્તમ માર્ગ છે!","hi":"क्या आपको पता है? बिना लड़े गुस्सा शांत करने के लिए अपनी भावनाओं के बारे में खुलकर बात करना ही सबसे अच्छा तरीका है!"}'::jsonb,
  'memory',
  true,
  14
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'throwing_garbage_in_dustbin',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Throwing Garbage in Dustbin","gu":"કચરો કચરાપેટીમાં નાખવો","hi":"कचरा कूड़ेदान में डालना"}'::jsonb,
  'assets/images/habits/throwing_garbage_in_dustbin.png',
  '#81C784',
  '{"en":"Throwing garbage in dustbin! Keeping our surroundings clean keeps our home and school beautiful!","gu":"કચરો કચરાપેટીમાં નાખવો! આસપાસની જગ્યા સ્વચ્છ રાખવાથી આપણું ઘર અને શાળા સુંદર બને છે!","hi":"कचरा कूड़ेदान में डालना! आसपास की जगह साफ रखने से हमारा घर और स्कूल सुंदर बनते हैं!"}'::jsonb,
  '{"en":"Always throw trash, wrappers, and waste into the dustbin. It keeps flies and germs away and protects our environment.","gu":"હંમેશા કચરો અને રેપર્સ કચરાપેટીમાં જ નાખો. તે માખીઓ અને જીવાણુઓને દૂર રાખે છે અને પર્યાવરણને બચાવે છે.","hi":"हमेशा कचरा और रैपर्स कूड़ेदान में ही डालें। यह मक्खियों और कीटाणुओं को दूर रखता है और पर्यावरण को बचाता है।"}'::jsonb,
  '{"en":"Did you know? Recycling just one glass bottle saves enough energy to power a computer for 25 minutes!","gu":"શું તમે જાણો છો? કાચની માત્ર એક બોટલ રિસાયકલ કરવાથી કોમ્પ્યુટરને ૨૫ મિનિટ સુધી ચલાવવા જેટલી ઉર્જા બચી શકે છે!","hi":"क्या आपको पता है? कांच की सिर्फ एक बोतल रीसायकल करने से कंप्यूटर को 25 मिनट तक चलाने जितनी ऊर्जा बच सकती है!"}'::jsonb,
  'memory',
  true,
  15
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lying',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Lying","gu":"જૂઠું બોલવું","hi":"झूठ बोलना"}'::jsonb,
  'assets/images/habits/lying.png',
  '#EF5350',
  '{"en":"Lying! Lying is a bad habit. Speaking the truth helps others trust and respect us!","gu":"જૂઠું બોલવું! જૂઠું બોલવું એ ખરાબ આદત છે. સાચું બોલવાથી લોકો આપણા પર વિશ્વાસ અને આદર કરે છે!","hi":"झूठ बोलना! झूठ बोलना एक बुरी आदत है। सच बोलने से लोग हम पर विश्वास और सम्मान करते हैं!"}'::jsonb,
  '{"en":"Lying can hurt people and break trust. Even when we make a mistake, telling the truth is always the right and brave choice.","gu":"જૂઠું બોલવાથી સંબંધો અને વિશ્વાસ તૂટે છે. ભૂલ થઈ હોય તો પણ સાચું બોલવું એ જ બહાદુરી છે.","hi":"झूठ बोलने से विश्वास टूटता है। गलती होने पर भी सच बोलना ही बहादुरी और सही निर्णय है।"}'::jsonb,
  '{"en":"Did you know? Telling the truth makes you feel relaxed and happy, while lying can make you feel worried!","gu":"શું તમે જાણો છો? સાચું બોલવાથી તમે હળવાશ અને ખુશી અનુભવો છો, જ્યારે જૂઠું બોલવાથી મન ચિંતિત રહે છે!","hi":"क्या आपको पता है? सच बोलने से आप तनावमुक्त महसूस करते हैं, जबकि झूठ बोलने से मन चिंतित रहता है!"}'::jsonb,
  'memory',
  true,
  16
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'wasting_water',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Wasting Water","gu":"પાણીનો બગાડ કરવો","hi":"पानी बर्बाद करना"}'::jsonb,
  'assets/images/habits/wasting_water.png',
  '#E57373',
  '{"en":"Wasting water! Water is precious. We must turn off the tap when not using it!","gu":"પાણીનો બગાડ કરવો! પાણી અમૂલ્ય છે. વપરાશ ન હોય ત્યારે નળ બંધ રાખવો જોઈએ!","hi":"पानी बर्बाद करना! पानी अमूल्य है। उपयोग न होने पर नल बंद रखना चाहिए!"}'::jsonb,
  '{"en":"Leaving the tap running while brushing or washing is a bad habit. Saving water ensures there is enough clean water for everyone.","gu":"બ્રશ કરતી વખતે નળ ચાલુ રાખવો એ ખરાબ ટેવ છે. પાણી બચાવવાથી દરેકને પૂરતું પાણી મળી રહેશે.","hi":"ब्रश करते समय नल खुला छोड़ना एक बुरी आदत है। पानी बचाने से सभी को पर्याप्त पानी मिल सकेगा।"}'::jsonb,
  '{"en":"Did you know? A dripping tap can waste more than 3,000 gallons of water in a single year!","gu":"શું તમે જાણો છો? ટપકતો નળ એક વર્ષમાં ૩,૦૦૦ ગેલન કરતાં વધુ પાણીનો બગાડ કરી શકે છે!","hi":"क्या आपको पता है? टपकता हुआ नल एक साल में 3,000 गैलन से अधिक पानी बर्बाद कर सकता है!"}'::jsonb,
  'memory',
  true,
  17
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'littering',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Littering","gu":"ગંદકી કરવી","hi":"कचरा फैलाना"}'::jsonb,
  'assets/images/habits/littering.png',
  '#EF5350',
  '{"en":"Littering! Littering damages nature and hurts animals. We must keep our planet clean!","gu":"ગંદકી કરવી! ગંદકી કરવાથી પ્રકૃતિ અને પ્રાણીઓને નુકસાન થાય છે. આપણે પૃથ્વીને સ્વચ્છ રાખવી જોઈએ!","hi":"कचरा फैलाना! कचरा फैलाने से प्रकृति और जानवरों को नुकसान होता है। हमें पृथ्वी को साफ रखना चाहिए!"}'::jsonb,
  '{"en":"Throwing plastic or trash on roads, parks, or beaches is littering. It is a bad habit that causes pollution and harms wildlife.","gu":"રસ્તા કે બગીચામાં પ્લાસ્ટિક અને કચરો ફેંકવો એ ગંદકી ફેલાવે છે. તેનાથી પર્યાવરણ અને જીવોને નુકસાન થાય છે.","hi":"सड़क या बगीचे में प्लास्टिक और कचरा फेंकना गंदगी फैलाता है। इससे पर्यावरण और जीवों को नुकसान होता है।"}'::jsonb,
  '{"en":"Did you know? A plastic bottle thrown on the ground can take up to 450 years to completely break down!","gu":"શું તમે જાણો છો? જમીન પર ફેંકેલી પ્લાસ્ટિકની બોટલને સંપૂર્ણ નાશ પામતા ૪૫૦ વર્ષ સુધીનો સમય લાગી શકે છે!","hi":"क्या आपको पता है? जमीन पर फेंकी गई प्लास्टिक की बोतल को पूरी तरह नष्ट होने में 450 साल तक लग सकते हैं!"}'::jsonb,
  'memory',
  true,
  18
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'respecting_elders',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Respecting Elders","gu":"વડીલોને માન આપવું","hi":"बड़ों का सम्मान करना"}'::jsonb,
  'assets/images/habits/respecting_elders.png',
  '#81C784',
  '{"en":"Respecting elders! Greeting our grandparents and listening to parents shows respect and love!","gu":"વડીલોને માન આપવું! દાદા-દાદીને વંદન કરવા અને માતા-પિતાની વાત સાંભળવી એ આદર દર્શાવે છે!","hi":"बड़ों का सम्मान करना! दादा-दादी को प्रणाम करना और माता-पिता की बात सुनना आदर दर्शाता है!"}'::jsonb,
  '{"en":"Elders guide us and teach us important lessons. Speaking politely to them and helping them is a wonderful habit.","gu":"વડીલો આપણને માર્ગદર્શન આપે છે અને મહત્વના પાઠ શીખવે છે. તેમની સાથે નમ્રતાથી વાત કરવી એ ઉત્તમ ટેવ છે.","hi":"बुजुर्ग हमारा मार्गदर्शन करते हैं और महत्वपूर्ण बातें सिखाते हैं। उनसे विनम्रता से बात करना एक बेहतरीन आदत है।"}'::jsonb,
  '{"en":"Did you know? In many cultures around the world, bowing or touching the feet of elders is a sign of receiving their blessings!","gu":"શું તમે જાણો છો? ઘણી સંસ્કૃતિઓમાં વડીલોના ચરણ સ્પર્શ કરવા એ તેમના આશીર્વાદ મેળવવાનું પ્રતીક ગણાય છે!","hi":"क्या आपको पता है? कई संस्कृतियों में बुजुर्गों के पैर छूना उनका आशीर्वाद प्राप्त करने का प्रतीक माना जाता है!"}'::jsonb,
  'memory',
  true,
  19
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.habits (topic_key, category_id, name, image_path, hex_code, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'not_sharing',
  (SELECT id FROM categories WHERE category_key = 'habits' LIMIT 1),
  '{"en":"Not Sharing","gu":"વહેંચણી ન કરવી","hi":"साझा न करना"}'::jsonb,
  'assets/images/habits/not_sharing.png',
  '#EF5350',
  '{"en":"Not sharing! Keeping toys only to oneself is a bad habit. Sharing brings happiness to all!","gu":"વહેંચણી ન કરવી! રમકડાં એકલા જ રાખવા એ ખરાબ આદત છે. વહેંચીને રમવાથી પરસ્પર આનંદ વધે છે!","hi":"साझा न करना! खिलौने अकेले ही रखना एक बुरी आदत है। बांटकर खेलने से आपसी आनंद बढ़ता है!"}'::jsonb,
  '{"en":"Not sharing makes playing lonely and sad. When we refuse to share, others might not want to play with us.","gu":"બીજા સાથે ન રમવાથી રમત કંટાળાજનક અને ઉદાસ બને છે. જો આપણે રમકડાં શેર નહીં કરીએ તો કોઈ આપણી સાથે નહીં રમે.","hi":"दूसरों के साथ न साझा करने से खेल उबाऊ बन जाता है। यदि हम खिलौने साझा नहीं करेंगे तो कोई हमारे साथ नहीं खेलेगा।"}'::jsonb,
  '{"en":"Did you know? Children who share their toys are proven to make friends faster and have more fun at playtime!","gu":"શું તમે જાણો છો? જે બાળકો રમકડાં વહેંચીને રમે છે, તેઓ ઝડપથી મિત્રો બનાવી શકે છે અને વધુ આનંદ માણી શકે છે!","hi":"क्या आपको पता है? जो बच्चे खिलौने बांटकर खेलते हैं, वे जल्दी दोस्त बना पाते हैं और खेल का अधिक आनंद लेते हैं!"}'::jsonb,
  'memory',
  true,
  20
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  hex_code = EXCLUDED.hex_code,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;
