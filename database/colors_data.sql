-- 1. Create colors table and index

CREATE TABLE IF NOT EXISTS public.colors (
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
  constraint colors_pkey primary key (id),
  constraint colors_topic_key_key unique (topic_key),
  constraint colors_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_colors_topic_key on public.colors using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.colors DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.colors TO anon;
GRANT ALL ON public.colors TO authenticated;
GRANT ALL ON public.colors TO service_role;


-- 2. Populate colors table with 11 colors data

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'red', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Red", "gu": "લાલ", "hi": "लाल"}'::jsonb, 
  '/assets/svgs/colors/red.svg', 
  '{"en": "Red! Red is the color of love and warm sunshine.", "gu": "લાલ! લાલ એ પ્રેમ અને ગરમ સૂર્યપ્રકાશનો રંગ છે.", "hi": "लाल! लाल प्यार और गर्म धूप का रंग है।"}'::jsonb, 
  '{"en": "Red is a bright and beautiful color. We can see it in ripe apples, strawberries, and ladybugs!", "gu": "લાલ એક તેજસ્વી અને સુંદર રંગ છે. આપણે તેને પાકેલા સફરજન, સ્ટ્રોબેરી અને લેડીબગ્સમાં જોઈ શકીએ છીએ!", "hi": "लाल एक चमकीला और सुंदर रंग है। हम इसे पके हुए सेब, स्ट्रॉबेरी और लेडीबग्स में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Red is the first color a baby can see after birth!", "gu": "શું તમે જાણો છો? લાલ એ પહેલો રંગ છે જે બાળક જન્મ પછી જોઈ શકે છે!", "hi": "क्या आपको पता है? लाल वह पहला रंग है जिसे बच्चा जन्म के बाद देख सकता है!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'blue', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Blue", "gu": "વાદળી", "hi": "नीला"}'::jsonb, 
  '/assets/svgs/colors/blue.svg', 
  '{"en": "Blue! Blue is the color of the vast sky and the deep ocean.", "gu": "વાદળી! વાદળી એ વિશાળ આકાશ અને ઊંડા સમુદ્રનો રંગ છે.", "hi": "नीला! नीला विशाल आकाश और गहरे समुद्र का रंग है।"}'::jsonb, 
  '{"en": "Blue is a cool and calm color. It is the color of blueberries, bluebirds, and water!", "gu": "વાદળી એક શાંત અને ઠંડો રંગ છે. તે બ્લૂબેરી, બ્લૂબર્ડ અને પાણીનો રંગ છે!", "hi": "नीला एक शांत और ठंडा रंग है। यह ब्लूबेरी, ब्लू बर्ड और पानी का रंग है!"}'::jsonb, 
  '{"en": "Did you know? Blue is the most popular favorite color in the whole world!", "gu": "શું તમે જાણો છો? વાદળી એ સમગ્ર વિશ્વમાં સૌથી લોકપ્રિય મનપસંદ રંગ છે!", "hi": "क्या आपको पता है? नीला पूरी दुनिया में सबसे लोकप्रिय पसंदीदा रंग है!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'green', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Green", "gu": "લીલો", "hi": "हरा"}'::jsonb, 
  '/assets/svgs/colors/green.svg', 
  '{"en": "Green! Green is the color of fresh grass and growing plants.", "gu": "લીલો! લીલો એ તાજા ઘાસ અને ઉગતા છોડનો રંગ છે.", "hi": "हरा! हरा ताजी घास और बढ़ते पौधों का रंग है।"}'::jsonb, 
  '{"en": "Green represents nature. You can see it in leaves, frogs, broccoli, and grasshoppers!", "gu": "લીલો રંગ પ્રકૃતિ દર્શાવે છે. તમે તેને પાંદડા, દેડકા, બ્રોકોલી અને તીડમાં જોઈ શકો છો!", "hi": "हरा रंग प्रकृति का प्रतिनिधित्व करता है। आप इसे पत्तियों, मेढकों, ब्रोकली और टिड्डों में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Green is the easiest color for human eyes to see and relax with!", "gu": "શું તમે જાણો છો? લીલો એ માનવ આંખો માટે જોવા અને આરામ આપવા માટે સૌથી સરળ રંગ છે!", "hi": "क्या आपको पता है? हरा रंग मानव आंखों के लिए देखने और आराम करने के लिए सबसे आसान रंग है!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'yellow', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Yellow", "gu": "પીળો", "hi": "पीला"}'::jsonb, 
  '/assets/svgs/colors/yellow.svg', 
  '{"en": "Yellow! Yellow is the bright, happy color of the shining sun.", "gu": "પીળો! પીળો એ ચમકતા સૂર્યનો તેજસ્વી, ખુશ રંગ છે.", "hi": "पीला! पीला चमकते सूरज का चमकीला, खुशहाल रंग है।"}'::jsonb, 
  '{"en": "Yellow is full of energy! We can see it in bananas, lemons, sunflowers, and cute baby chicks!", "gu": "પીળો રંગ ઉર્જાથી ભરપૂર છે! આપણે તેને કેળા, લીંબુ, સૂર્યમુખી અને સુંદર બચ્ચાઓમાં જોઈ શકીએ છીએ!", "hi": "पीला रंग ऊर्जा से भरपूर है! हम इसे केले, नींबू, सूरजमुखी और प्यारे चूजों में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Yellow is the most visible color from a distance, which is why school buses are yellow!", "gu": "શું તમે જાણો છો? પીળો એ દૂરથી સૌથી વધુ દેખાતો રંગ છે, તેથી જ સ્કૂલ બસો પીળી હોય છે!", "hi": "क्या आपको पता है? पीला रंग दूर से सबसे ज्यादा दिखाई देने वाला रंग है, इसीलिए स्कूल बसें पीली होती हैं!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'orange', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Orange", "gu": "નારંગી", "hi": "नारंगी"}'::jsonb, 
  '/assets/svgs/colors/orange.svg', 
  '{"en": "Orange! Orange is a warm and cheerful color like a glowing sunset.", "gu": "નારંગી! નારંગી એ તેજસ્વી સૂર્યાસ્ત જેવો ગરમ અને ખુશખુશાલ રંગ છે.", "hi": "नारंगी! नारंगी एक गर्म और हंसमुख रंग है जैसे चमकता सूर्यास्त।"}'::jsonb, 
  '{"en": "Orange is a fun color! We can see it in orange fruits, carrots, pumpkins, and tigers!", "gu": "નારંગી એક મનોરંજક રંગ છે! આપણે તેને નારંગી, ગાજર, કોળું અને વાઘમાં જોઈ શકીએ છીએ!", "hi": "नारंगी एक मजेदार रंग है! हम इसे संतरे, गाजर, कद्दू और बाघों में देख सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? The fruit orange came first, and the color was named after it!", "gu": "શું તમે જાણો છો? નારંગી ફળ પહેલા આવ્યું હતું, અને રંગનું નામ તેના પરથી રાખવામાં આવ્યું હતું!", "hi": "क्या आपको पता है? संतरा फल पहले आया था, और रंग का नाम इसके नाम पर रखा गया था!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'pink', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Pink", "gu": "ગુલાબી", "hi": "गुलाबी"}'::jsonb, 
  '/assets/svgs/colors/pink.svg', 
  '{"en": "Pink! Pink is a sweet and gentle color like soft flower petals.", "gu": "ગુલાબી! ગુલાબી એ નરમ ફૂલોની પાંદડીઓ જેવો મીઠો અને કોમળ રંગ છે.", "hi": "गुलाबी! गुलाबी एक प्यारा और कोमल रंग है जैसे फूलों की पंखुड़ियाँ।"}'::jsonb, 
  '{"en": "Pink is a playful color. We see it in flamingos, cotton candy, roses, and pigs!", "gu": "ગુલાબી એક રમતિયાળ રંગ છે. આપણે તેને ફ્લેમિંગો, કોટન કેન્ડી, ગુલાબ અને ડુક્કરમાં જોઈએ છીએ!", "hi": "गुलाबी एक चंचल रंग है। हम इसे राजहंस, कॉटन कैंडी, गुलाब और सूअरों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Flamingos are not born pink! They turn pink from eating special pink shrimp!", "gu": "શું તમે જાણો છો? ફ્લેમિંગો ગુલાબી જન્મતા નથી! તેઓ ખાસ ગુલાબી ઝીંગા ખાવાથી ગુલાબી બને છે!", "hi": "क्या आपको पता है? राजहंस गुलाबी पैदा नहीं होते! वे विशेष गुलाबी झींगे खाने से गुलाबी हो जाते हैं!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'purple', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Purple", "gu": "જાંબલી", "hi": "बैंगनी"}'::jsonb, 
  '/assets/svgs/colors/purple.svg', 
  '{"en": "Purple! Purple is a royal and magical color of kings and queens.", "gu": "જાંબલી! જાંબલી એ રાજાઓ અને રાણીઓનો શાહી અને જાદુઈ રંગ છે.", "hi": "बैंगनी! बैंगनी राजाओं और रानियों का एक शाही और जादुई रंग है।"}'::jsonb, 
  '{"en": "Purple is a beautiful color. We see it in sweet grapes, plums, eggplants, and lavender flowers!", "gu": "જાંબલી એક સુંદર રંગ છે. આપણે તેને મીઠી દ્રાક્ષ, પ્લમ, રીંગણ અને લવંડર ફૂલોમાં જોઈએ છીએ!", "hi": "बैंगनी एक सुंदर रंग है। हम इसे मीठे अंगूर, बेर, बैंगन और लैवेंडर के फूलों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Long ago, purple dye was so rare and expensive that only royalty could wear it!", "gu": "શું તમે જાણો છો? લાંબા સમય પહેલા, જાંબલી રંગ એટલો દુર્લભ અને મોંઘો હતો કે માત્ર શાહી લોકો જ તેને પહેરી શકતા હતા!", "hi": "क्या आपको पता है? बहुत समय पहले, बैंगनी रंग इतना दुर्लभ और महंगा था कि केवल शाही लोग ही इसे पहन सकते थे!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'brown', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Brown", "gu": "કથ્થઈ", "hi": "भूरा"}'::jsonb, 
  '/assets/svgs/colors/brown.svg', 
  '{"en": "Brown! Brown is the earthy, warm color of soil and trees.", "gu": "કથ્થઈ! કથ્થઈ એ માટી અને વૃક્ષોનો કુદરતી, ગરમ રંગ છે.", "hi": "भूरा! भूरा मिट्टी और पेड़ों का प्राकृतिक, गर्म रंग है।"}'::jsonb, 
  '{"en": "Brown is a cozy color. We see it in chocolate, teddy bears, pinecones, and monkeys!", "gu": "કથ્થઈ એક આરામદાયક રંગ છે. આપણે તેને ચોકલેટ, ટેડી બેર, પાઈનકોન અને વાંદરાઓમાં જોઈએ છીએ!", "hi": "भूरा एक आरामदायक रंग है। हम इसे चॉकलेट, टेडी बियर, पाइनकोन और बंदरों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Wood from trees is brown because of a special substance called lignin!", "gu": "શું તમે જાણો છો? વૃક્ષોનું લાકડું લિગ્નિન નામના ખાસ પદાર્થને કારણે કથ્થઈ રંગનું હોય છે!", "hi": "क्या आपको पता है? पेड़ों की लकड़ी लिग्निन नामक विशेष पदार्थ के कारण भूरी होती है!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'black', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Black", "gu": "કાળો", "hi": "काला"}'::jsonb, 
  '/assets/svgs/colors/black.svg', 
  '{"en": "Black! Black is the deep color of the quiet night sky.", "gu": "કાળો! કાળો એ શાંત રાત્રિના આકાશનો ઊંડો રંગ છે.", "hi": "काला! काला शांत रात के आसमान का गहरा रंग है।"}'::jsonb, 
  '{"en": "Black is a strong color. We see it in black cats, coal, tires, and cute penguins!", "gu": "કાળો એક મજબૂત રંગ છે. આપણે તેને કાળી બિલાડીઓ, કોલસો, ટાયર અને સુંદર પેન્ગ્વિનમાં જોઈએ છીએ!", "hi": "काला एक मजबूत रंग है। हम इसे काली बिल्लियों, कोयले, टायरों और प्यारे पेंगुइन में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Black is not actually a color, but the absence of all light!", "gu": "શું તમે જાણો છો? કાળો વાસ્તવમાં કોઈ રંગ નથી, પરંતુ તમામ પ્રકાશની ગેરહાજરી છે!", "hi": "क्या आपको पता है? काला वास्तव में कोई रंग नहीं है, बल्कि सभी प्रकाश की अनुपस्थिति है!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'white', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "White", "gu": "સફેદ", "hi": "सफेद"}'::jsonb, 
  '/assets/svgs/colors/white.svg', 
  '{"en": "White! White is the clean, bright color of soft snow.", "gu": "સફેદ! સફેદ એ નરમ બરફનો સ્વચ્છ, તેજસ્વી રંગ છે.", "hi": "सफेद! सफेद नरम बर्फ का साफ, चमकीला रंग है।"}'::jsonb, 
  '{"en": "White is peaceful. We see it in fluffy clouds, milk, cotton, and friendly polar bears!", "gu": "સફેદ શાંતિપ્રિય છે. આપણે તેને રુંવાટીદાર વાદળો, દૂધ, કપાસ અને ધ્રુવીય રીંછમાં જોઈએ છીએ!", "hi": "सफेद रंग शांति का प्रतीक है। हम इसे रोएंदार बादलों, दूध, कपास और ध्रुवीय भालू में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? White light actually contains all the colors of the rainbow mixed together!", "gu": "શું તમે જાણો છો? સફેદ પ્રકાશમાં વાસ્તવમાં મેઘધનુષ્યના બધા રંગો એકસાથે ભળેલા હોય છે!", "hi": "क्या आपको पता है? सफेद प्रकाश में वास्तव में इंद्रधनुष के सभी रंग आपस में मिले होते हैं!"}'::jsonb, 
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

INSERT INTO public.colors 
(topic_key, category_id, name, svg_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'grey', 
  (SELECT id FROM categories WHERE category_key = 'colors' LIMIT 1), 
  '{"en": "Grey", "gu": "ભૂખરો", "hi": "धूसर"}'::jsonb, 
  '/assets/svgs/colors/grey.svg', 
  '{"en": "Grey! Grey is a calm and gentle color like a misty morning.", "gu": "ભૂખરો! ભૂખરો એ ધુમ્મસવાળી સવાર જેવો શાંત અને કોમળ રંગ છે.", "hi": "धूसर! धूसर धुंधली सुबह की तरह एक शांत और कोमल रंग है।"}'::jsonb, 
  '{"en": "Grey is a soft color. We see it in friendly elephants, dolphins, rain clouds, and tiny mice!", "gu": "ભૂખરો એક નરમ રંગ છે. આપણે તેને હાથી, ડોલ્ફિન, વરસાદી વાદળો અને નાના ઉંદરોમાં જોઈએ છીએ!", "hi": "धूसर एक हल्का रंग है। हम इसे हाथियों, डॉल्फ़िन, बारिश के बादलों और छोटे चूहों में देखते हैं!"}'::jsonb, 
  '{"en": "Did you know? Grey is one of the most common colors for stones and rocks on Earth!", "gu": "શું તમે જાણો છો? પૃથ્વી પરના પત્થરો અને ખડકો માટે ભૂખરો એ સૌથી સામાન્ય રંગોમાંનો એક છે!", "hi": "क्या आपको पता है? धूसर पृथ्वी पर पत्थरों और चट्टानों के लिए सबसे आम रंगों में से एक है!"}'::jsonb, 
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