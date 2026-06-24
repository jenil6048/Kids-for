-- 1. Create animals table and index

CREATE TABLE IF NOT EXISTS public.animals (
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
  constraint animals_pkey primary key (id),
  constraint animals_topic_key_key unique (topic_key),
  constraint animals_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_animals_topic_key on public.animals using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.animals DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.animals TO anon;
GRANT ALL ON public.animals TO authenticated;
GRANT ALL ON public.animals TO service_role;


-- 2. Populate animals table with data

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'gorilla', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Gorilla", "gu": "ગોરિલા", "hi": "गोरिल्ला"}'::jsonb, 
  '/assets/images/animals/gorilla.png', 
  '{"en": "Gorilla! Gorillas are big, strong apes that live in green forests.", "gu": "ગોરિલા! ગોરિલા લીલાછમ જંગલોમાં રહેતા મોટા અને શક્તિશાળી વાનર છે.", "hi": "गोरिल्ला! गोरिल्ला हरे-भरे जंगलों में रहने वाले बड़े और मजबूत वनमानुष होते हैं।"}'::jsonb, 
  '{"en": "Gorillas are gentle giants. They live in family groups called troops, led by a silverback male who protects them.", "gu": "ગોરિલા નમ્ર અને શાંત હોય છે. તેઓ ફેમિલી ગૃપમાં રહે છે જેને સિલ્વરબેક નર ચલાવે છે અને તેમનું રક્ષણ કરે છે.", "hi": "गोरिल्ला बहुत शांत स्वभाव के होते हैं। वे पारिवारिक समूहों में रहते हैं जिनका नेतृत्व एक बड़ा नर करता है जो उनकी रक्षा करता है।"}'::jsonb, 
  '{"en": "Did you know? Gorillas share about 98% of their DNA with humans, and they can even learn sign language!", "gu": "શું તમે જાણો છો? ગોરિલા માનવીઓ સાથે ૯૮% ડીએનએ ધરાવે છે, અને તેઓ સાઇન લેંગ્વેજ પણ શીખી શકે છે!", "hi": "क्या आपको पता है? गोरिल्ला मनुष्यों के साथ लगभग 98% डीएनए साझा करते हैं, और वे सांकेतिक भाषा भी सीख सकते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cow', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Cow", "gu": "ગાય", "hi": "गाय"}'::jsonb, 
  '/assets/images/animals/cow.png', 
  '{"en": "Cow! Cows are gentle domestic animals that give us healthy milk.", "gu": "ગાય! ગાય એ નમ્ર પાલતુ પ્રાણી છે જે આપણને પૌષ્ટિક દૂધ આપે છે.", "hi": "गाय! गाय एक शांत पालतू जानवर है जो हमें स्वास्थ्यवर्धक दूध देती है।"}'::jsonb, 
  '{"en": "Cows love chewing grass in green pastures. They make a friendly ''moo'' sound to talk to each other.", "gu": "ગાય લીલા ઘાસના મેદાનોમાં ઘાસ ચરવું પસંદ કરે છે. તેઓ એકબીજા સાથે વાત કરવા માટે ''ભાંભરવાનો'' અવાજ કરે છે.", "hi": "गायों को हरे मैदानों में घास चरना बहुत पसंद होता है। वे एक-दूसरे से बात करने के लिए ''रंभाने'' की आवाज़ करती हैं।"}'::jsonb, 
  '{"en": "Did you know? Cows have an amazing memory and can remember their cow friends for many years!", "gu": "શું તમે જાણો છો? ગાયની યાદશક્તિ અદ્ભુત હોય છે અને તે તેના ગાય મિત્રોને ઘણા વર્ષો સુધી યાદ રાખી શકે છે!", "hi": "क्या आपको पता है? गायों की याददाश्त बहुत कमाल की होती है और वे अपने दोस्तों को कई सालों तक याद रख सकती हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rhinoceros', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Rhinoceros", "gu": "ગેંડો", "hi": "गैंडा"}'::jsonb, 
  '/assets/images/animals/rhinoceros.png', 
  '{"en": "Rhinoceros! The rhinoceros is a huge animal with tough skin and a horn on its nose.", "gu": "ગેંડો! ગેંડો એ જાડી ચામડી અને નાક પર શિંગડું ધરાવતું એક વિશાળ પ્રાણી છે.", "hi": "गैंडा! गैंडा एक बहुत बड़ा जानवर है जिसकी त्वचा मोटी होती है और उसकी नाक पर एक सींग होता है।"}'::jsonb, 
  '{"en": "Rhinos love rolling in cool mud. The mud acts like sunscreen to protect their skin from the hot sun and bugs!", "gu": "ગેંડાને કાદવમાં આળોટવું ખૂબ ગમે છે. કાદવ સનસ્ક્રીન જેવું કામ કરે છે જે તેમની ત્વચાને સૂર્યની ગરમી અને જંતુઓથી બચાવે છે!", "hi": "गैंडों को ठंडी कीचड़ में लेटना बहुत पसंद होता है। कीचड़ उनकी त्वचा को तेज धूप और कीड़ों से बचाने के लिए सनस्क्रीन का काम करता है!"}'::jsonb, 
  '{"en": "Did you know? Rhino horns are made of keratin, which is the exact same stuff that makes up our hair and nails!", "gu": "શું તમે જાણો છો? ગેંડાનું શિંગડું કેરાટિનનું બનેલું હોય છે, જે આપણા વાળ અને નખ બનાવે છે તે જ તત્વ છે!", "hi": "क्या आपको पता है? गैंडे के सींग केराटिन से बने होते हैं, यह वही चीज़ है जिससे हमारे बाल और नाखून बनते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'elephant', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Elephant", "gu": "હાથી", "hi": "हाथी"}'::jsonb, 
  '/assets/images/animals/elephant.png', 
  '{"en": "Elephant! Elephants are the largest land animals with a long trunk and big ears.", "gu": "હાથી! હાથી લાંબી સૂંઢ અને મોટા કાન ધરાવતા જમીન પરના સૌથી મોટા પ્રાણી છે.", "hi": "हाथी! हाथी लंबी सूंड और बड़े कानों वाले जमीन पर रहने वाले सबसे बड़े जानवर हैं।"}'::jsonb, 
  '{"en": "Elephants use their trunks to breathe, drink water, and pick up food. They also use it to say hello to their friends!", "gu": "હાથી તેમની સૂંઢનો ઉપયોગ શ્વાસ લેવા, પાણી પીવા અને ખોરાક લેવા માટે કરે છે. તેઓ તેનો ઉપયોગ મિત્રોને હેલો કહેવા માટે પણ કરે છે!", "hi": "हाथी अपनी सूंड का उपयोग सांस लेने, पानी पीने और भोजन उठाने के लिए करते हैं। वे इसका उपयोग अपने दोस्तों को नमस्ते कहने के लिए भी करते हैं!"}'::jsonb, 
  '{"en": "Did you know? Elephants have large ears that act like fans to keep them cool on hot days!", "gu": "શું તમે જાણો છો? હાથીના કાન પંખા જેવું કામ કરે છે જે તેમને ગરમીના દિવસોમાં ઠંડા રાખવામાં મદદ કરે છે!", "hi": "क्या आपको पता है? हाथी के बड़े कान पंखे की तरह काम करते हैं जो उन्हें गर्म दिनों में ठंडा रखने में मदद करते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'chimpanzee', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Chimpanzee", "gu": "ચિમ્પાન્ઝી", "hi": "चिंपैंजी"}'::jsonb, 
  '/assets/images/animals/chimpanzee.png', 
  '{"en": "Chimpanzee! Chimpanzees are smart, playful animals that love swinging in trees.", "gu": "ચિમ્પાન્ઝી! ચિમ્પાન્ઝી એ બુદ્ધિશાળી, રમતિયાળ પ્રાણી છે જે ઝાડ પર લટકવું પસંદ કરે છે.", "hi": "चिंपैंजी! चिंपैंजी बुद्धिमान और चंचल जानवर होते हैं जो पेड़ों पर झूलना पसंद करते हैं।"}'::jsonb, 
  '{"en": "Chimpanzees are highly intelligent. They use tools like twigs to catch tasty termites and leaves to scoop up water!", "gu": "ચિમ્પાન્ઝી ખૂબ જ બુદ્ધિશાળી હોય છે. તેઓ પાણી પીવા અને ખોરાક પકડવા માટે નાની લાકડીઓ અને પાંદડાઓનો ઉપયોગ કરે છે!", "hi": "चिंपैंजी बहुत बुद्धिमान होते हैं। वे पानी पीने और कीड़े पकड़ने के लिए टहनियों और पत्तों का उपयोग औजारों की तरह करते हैं!"}'::jsonb, 
  '{"en": "Did you know? Chimpanzees show their emotions by laughing when they play and hugging when they say hello!", "gu": "શું તમે જાણો છો? ચિમ્પાન્ઝી રમતી વખતે હસીને અને ભેટીને પોતાની લાગણીઓ વ્યક્ત કરે છે!", "hi": "क्या आपको पता है? चिंपैंजी खेलते समय हंसकर और गले मिलकर अपनी भावनाएं व्यक्त करते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'wolf', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Wolf", "gu": "વરૂ", "hi": "भेड़िया"}'::jsonb, 
  '/assets/images/animals/wolf.png', 
  '{"en": "Wolf! Wolves are wild, dog-like animals that live in forests and mountains.", "gu": "વરૂ! વરૂ એ જંગલો અને પર્વતોમાં રહેતું કુતરા જેવું જંગલી પ્રાણી છે.", "hi": "भेड़िया! भेड़िये जंगलों और पहाड़ों में रहने वाले कुत्ते जैसे दिखने वाले जंगली जानवर होते हैं।"}'::jsonb, 
  '{"en": "Wolves live in family groups called packs. They work together to hunt, travel, and take care of the cute wolf pups!", "gu": "વરૂ કુટુંબના ટોળામાં રહે છે જેને પેક કહેવાય છે. તેઓ શિકાર કરવા, ફરવા અને બચ્ચાઓની સંભાળ રાખવા સાથે કામ કરે છે!", "hi": "भेड़िये झुंडों में रहते हैं जिन्हें पैक कहा जाता है। वे शिकार करने, यात्रा करने और बच्चों की देखभाल करने के लिए मिलकर काम करते हैं!"}'::jsonb, 
  '{"en": "Did you know? Wolves howl to talk to their pack members and tell other packs to stay away from their territory!", "gu": "શું તમે જાણો છો? વરૂ તેના ટોળાના સભ્યો સાથે વાત કરવા અને અન્ય વરૂને દૂર રાખવા માટે લાળી (હાઉલ) પાડે છે!", "hi": "क्या आपको पता है? भेड़िये अपने झुंड के सदस्यों से बात करने और दूसरे झुंडों को दूर रहने की चेतावनी देने के लिए चिल्लाते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'cheetah', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Cheetah", "gu": "ચિત્તો", "hi": "चीता"}'::jsonb, 
  '/assets/images/animals/cheetah.png', 
  '{"en": "Cheetah! The cheetah is a beautiful spotted big cat built for speed.", "gu": "ચિત્તો! ચિત્તો એ ઝડપ માટે જાણીતી સુંદર ટપકાંવાળી મોટી બિલાડી છે.", "hi": "चीता! चीता रफ्तार के लिए मशहूर सुंदर चित्तीदार बड़ी बिल्ली है।"}'::jsonb, 
  '{"en": "Cheetahs are incredibly fast hunters. They have long legs, lightweight bodies, and dark tear marks on their faces.", "gu": "ચિત્તો ખૂબ જ ઝડપી શિકારી છે. તેમની પાસે લાંબા પગ, હલકું શરીર અને તેમના ચહેરા પર આંસુ જેવા કાળા લીટા હોય છે.", "hi": "चीते बहुत तेज़ शिकारी होते हैं। उनके लंबे पैर, हल्का शरीर और चेहरे पर काले आंसू के निशान होते हैं।"}'::jsonb, 
  '{"en": "Did you know? The cheetah is the fastest land animal! It can run as fast as a car on a highway in short bursts!", "gu": "શું તમે જાણો છો? ચિત્તો જમીન પરનું સૌથી ઝડપી પ્રાણી છે! તે ટૂંકા સમય માટે હાઈવે પર દોડતી કાર જેટલી ઝડપે દોડી શકે છે!", "hi": "क्या आपको पता है? चीता जमीन पर सबसे तेज़ दौड़ने वाला जानवर है! यह हाइवे पर दौड़ती कार जितनी रफ्तार पकड़ सकता है!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'donkey', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Donkey", "gu": "ગધેડું", "hi": "गधा"}'::jsonb, 
  '/assets/images/animals/donkey.png', 
  '{"en": "Donkey! Donkeys are friendly, hardworking farm animals with long ears.", "gu": "ગધેડું! ગધેડું એ લાંબા કાન ધરાવતું મૈત્રીપૂર્ણ, મહેનતુ પાલતુ પ્રાણી છે.", "hi": "गधा! गधा लंबे कानों वाला एक अनुकूल और मेहनती पालतू जानवर है।"}'::jsonb, 
  '{"en": "Donkeys help farmers carry heavy loads. They make a unique braying sound that sounds like ''hee-haw''!", "gu": "ગધેડું ખેડૂતોને ભારે સામાન વહન કરવામાં મદદ કરે છે. તેઓ ''હોંચી-હોંચી'' જેવો અવાજ કરે છે!", "hi": "गधे किसानों को भारी सामान उठाने में मदद करते हैं। वे एक अनोखी आवाज़ निकालते हैं जिसे ढेंचू-ढेंचू कहा जाता है!"}'::jsonb, 
  '{"en": "Did you know? Donkeys have very strong memory and can recognize a place and other donkeys for up to 25 years!", "gu": "શું તમે જાણો છો? ગધેડાની યાદશક્તિ ખૂબ જ મજબૂત હોય છે અને તેઓ ૨૫ વર્ષ પછી પણ સ્થળ કે અન્ય ગધેડાને ઓળખી શકે છે!", "hi": "क्या आपको पता है? गधों की याददाश्त बहुत मजबूत होती है और वे 25 साल बाद भी किसी जगह या दूसरे गधे को पहचान सकते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'alligator', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Alligator", "gu": "મગર", "hi": "घड़ियाल"}'::jsonb, 
  '/assets/images/animals/alligator.png', 
  '{"en": "Alligator! Alligators are big reptiles with strong jaws and lots of teeth.", "gu": "મગર! મગર એ મજબૂત જડબાં અને ઘણા દાંતવાળા મોટા સરિસૃપ પ્રાણી છે.", "hi": "घड़ियाल! घड़ियाल मजबूत जबड़े और बहुत सारे दांतों वाले बड़े सरीसृप होते हैं।"}'::jsonb, 
  '{"en": "Alligators spend their time swimming in rivers and swamps. They love basking in the warm sun on sandy banks to keep warm.", "gu": "મગર નદીઓ અને દલદલના પાણીમાં સમય વિતાવે છે. તેઓ ગરમ રહેવા માટે રેતાળ કિનારા પર તડકો ખાવાનું પસંદ કરે છે.", "hi": "घड़ियाल अपना समय नदियों और दलदल में तैरने में बिताते हैं। वे गर्म रहने के लिए रेतीले किनारों पर धूप सेंकना पसंद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Alligators can grow new teeth to replace old ones! They can have over 2,000 teeth in their lifetime.", "gu": "શું તમે જાણો છો? મગર જૂના દાંતની જગ્યાએ નવા દાંત ઉગાડી શકે છે! તેઓ તેમના જીવનકાળમાં ૨૦૦૦ થી વધુ દાંત બદલી શકે છે.", "hi": "क्या आपको पता है? घड़ियाल पुराने दांतों की जगह नए दांत उगा सकते हैं! वे अपने जीवनकाल में 2,000 से अधिक दांत बदल सकते हैं।"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'lion', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Lion", "gu": "સિંહ", "hi": "शेर"}'::jsonb, 
  '/assets/images/animals/lion.png', 
  '{"en": "Lion! The lion is known as the king of the jungle with a loud roar.", "gu": "સિંહ! સિંહ તેના જોરદાર ગર્જના સાથે જંગલના રાજા તરીકે ઓળખાય છે.", "hi": "शेर! शेर को अपनी तेज़ दहाड़ के साथ जंगल का राजा कहा जाता है।"}'::jsonb, 
  '{"en": "Lions live in groups called prides. They love resting under shady trees and are very strong hunters!", "gu": "સિંહ ગૃપમાં રહે છે જેને સિંહનું ટોળું કહેવાય છે. તેઓ છાયાદાર વૃક્ષો નીચે આરામ કરવો પસંદ કરે છે અને ખૂબ જ શક્તિશાળી શિકારી હોય છે!", "hi": "शेर समूहों में रहते हैं जिन्हें प्राइड कहा जाता है। वे छायादार पेड़ों के नीचे आराम करना पसंद करते हैं और बहुत मजबूत शिकारी होते हैं!"}'::jsonb, 
  '{"en": "Did you know? A lion''s roar is so loud it can be heard from five miles away!", "gu": "શું તમે જાણો છો? સિંહની ગર્જના એટલી જોરદાર હોય છે કે તે પાંચ માઈલ દૂરથી પણ સાંભળી શકાય છે!", "hi": "क्या आपको पता है? एक शेर की दहाड़ इतनी तेज़ होती है कि इसे पांच मील दूर से भी सुना जा सकता है!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'monkey', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Monkey", "gu": "વાંદરો", "hi": "बंदर"}'::jsonb, 
  '/assets/images/animals/monkey.png', 
  '{"en": "Monkey! Monkeys are cheeky, clever animals with long tails that live in trees.", "gu": "વાંદરો! વાંદરો એ વૃક્ષો પર રહેતું લાંબી પૂંછડીવાળું તોફાની અને ચતુર પ્રાણી છે.", "hi": "बंदर! बंदर लंबी पूंछ वाले शरारती और चतुर जानवर होते हैं जो पेड़ों पर रहते हैं।"}'::jsonb, 
  '{"en": "Monkeys love eating bananas and climbing trees. They use their long tails like an extra arm to swing from branch to branch!", "gu": "વાંદરાઓને કેળા ખાવા અને ઝાડ પર ચઢવું ગમે છે. તેઓ ડાળીએથી ડાળીએ લટકવા માટે પૂંછડીનો હાથની જેમ ઉપયોગ કરે છે!", "hi": "बंदरों को केले खाना और पेड़ों पर चढ़ना बहुत पसंद होता है। वे शाखाओं पर झूलने के लिए अपनी पूंछ का उपयोग पांचवें हाथ की तरह करते हैं!"}'::jsonb, 
  '{"en": "Did you know? Monkeys groom each other to show love and friendship, and to keep each other''s fur clean!", "gu": "શું તમે જાણો છો? વાંદરાઓ પ્રેમ અને મિત્રતા દર્શાવવા અને રૂંવાટી સાફ કરવા માટે એકબીજાના શરીર પર હાથ ફેરવે છે!", "hi": "क्या आपको पता है? बंदर प्यार और दोस्ती दिखाने और बालों को साफ रखने के लिए एक-दूसरे के शरीर को सहलाते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'tiger', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Tiger", "gu": "વાઘ", "hi": "बाघ"}'::jsonb, 
  '/assets/images/animals/tiger.png', 
  '{"en": "Tiger! The tiger is a big cat with beautiful orange and black stripes.", "gu": "વાઘ! વાઘ એ સુંદર નારંગી અને કાળી પટ્ટીઓ ધરાવતી એક મોટી બિલાડી છે.", "hi": "बाघ! बाघ सुंदर नारंगी और काली धारियों वाली एक बड़ी बिल्ली है।"}'::jsonb, 
  '{"en": "Tigers are the biggest cats in the world. Unlike most cats, tigers love swimming and playing in water!", "gu": "વાઘ દેશની સૌથી મોટી બિલાડીઓ છે. મોટાભાગની બિલાડીઓથી વિપરીત, વાઘને પાણીમાં તરવું અને રમવું ખૂબ ગમે છે!", "hi": "बाघ दुनिया की सबसे बड़ी बिल्लियां हैं। अधिकांश बिल्लियों के विपरीत, बाघों को पानी में तैरना और खेलना बहुत पसंद होता है!"}'::jsonb, 
  '{"en": "Did you know? No two tigers have the exact same stripes! They are just like our fingerprints.", "gu": "શું તમે જાણો છો? કોઈ પણ બે વાઘના શરીર પર એક સરખી પટ્ટીઓ નથી હોતી! તે આપણા ફિંગરપ્રિન્ટ્સ જેવી જ હોય છે.", "hi": "क्या आपको पता है? किसी भी दो बाघों के शरीर पर एक जैसी धारियां नहीं होती हैं! ये बिल्कुल हमारे उंगलियों के निशान की तरह होती हैं।"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'hippopotamus', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Hippopotamus", "gu": "જળઘોડો", "hi": "दरियाई घोड़ा"}'::jsonb, 
  '/assets/images/animals/hippopotamus.png', 
  '{"en": "Hippopotamus! The hippopotamus is a very heavy animal that loves water.", "gu": "જળઘોડો! જળઘોડો એ પાણી ખૂબ જ ગમતું હોય તેવું એક અત્યંત ભારે પ્રાણી છે.", "hi": "दरियाई घोड़ा! दरियाई घोड़ा पानी में रहने वाला एक बहुत ही भारी जानवर है।"}'::jsonb, 
  '{"en": "Hippos spend most of the day sleeping and swimming in lakes and rivers to keep their skin wet and cool.", "gu": "જળઘોડાઓ તેમની ત્વચાને ભીની અને ઠંડી રાખવા માટે દિવસનો મોટો ભાગ તળાવો અને નદીઓમાં સૂઈને અને તરીને વિતાવે છે.", "hi": "दरियाई घोड़े अपनी त्वचा को गीला और ठंडा रखने के लिए दिन का अधिकांश समय झीलों और नदियों में तैरते हुए बिताते हैं।"}'::jsonb, 
  '{"en": "Did you know? Despite being so huge, hippos can run faster than humans on land!", "gu": "શું તમે જાણો છો? આટલા વિશાળ હોવા છતાં, જળઘોડાઓ જમીન પર માણસો કરતાં પણ વધુ ઝડપથી દોડી શકે છે!", "hi": "क्या आपको पता है? इतने भारी होने के बावजूद, दरियाई घोड़े जमीन पर इंसानों से भी तेज़ दौड़ सकते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'rabbit', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Rabbit", "gu": "સસલું", "hi": "खरगोश"}'::jsonb, 
  '/assets/images/animals/rabbit.png', 
  '{"en": "Rabbit! Rabbits are small, fluffy animals with long ears and twitchy noses.", "gu": "સસલું! સસલું એ લાંબા કાન અને હલતી નાક ધરાવતું નાનું, રુંવાટીદાર પ્રાણી છે.", "hi": "खरगोश! खरगोश लंबे कानों और हिलती हुई नाक वाले छोटे, रोएँदार जानवर होते हैं।"}'::jsonb, 
  '{"en": "Rabbits love eating carrots and crunchy green veggies. They build underground tunnels called burrows to sleep safely.", "gu": "સસલાને ગાજર અને કડક લીલા શાકભાજી ખાવા ગમે છે. તેઓ સુરક્ષિત રીતે સૂવા માટે જમીનની અંદર બોર (બખોલ) બનાવે છે.", "hi": "खरगोशों को गाजर और कुरकुरी हरी सब्जियां खाना पसंद होता है। वे सुरक्षित सोने के लिए जमीन के नीचे बिल बनाते हैं।"}'::jsonb, 
  '{"en": "Did you know? When a rabbit is super happy, it does a special twisty jump called a ''binky''!", "gu": "શું તમે જાણો છો? જ્યારે સસલું ખૂબ ખુશ હોય છે, ત્યારે તે ''બિન્કી'' નામની ખાસ કૂદકો મારે છે!", "hi": "क्या आपको पता है? जब खरगोश बहुत खुश होता है, तो वह हवा में कूदकर एक विशेष घुमाव लेता है जिसे ''बिंकी'' कहते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'zebra', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Zebra", "gu": "ઝેબ્રા", "hi": "ज़ेबरा"}'::jsonb, 
  '/assets/images/animals/zebra.png', 
  '{"en": "Zebra! The zebra looks like a horse with black and white stripes.", "gu": "ઝેબ્રા! ઝેબ્રા કાળી અને સફેદ પટ્ટીઓ ધરાવતા ઘોડા જેવું દેખાય છે.", "hi": "ज़ेबरा! ज़ेबरा काली और सफेद धारियों वाले घोड़े की तरह दिखता है।"}'::jsonb, 
  '{"en": "Zebras live in big groups in grassy plains. Their stripes make it hard for sneaky lions to spot them in the grass!", "gu": "ઝેબ્રા ઘાસના મેદાનોમાં મોટા ટોળામાં રહે છે. તેમની પટ્ટીઓ શિકારી સિંહ માટે તેમને શોધવાનું મુશ્કેલ બનાવે છે!", "hi": "ज़ेबरा घास के मैदानों में बड़े समूहों में रहते हैं। उनकी धारियों के कारण शेर के लिए उन्हें पहचानना मुश्किल हो जाता है!"}'::jsonb, 
  '{"en": "Did you know? Just like our fingerprints, every zebra has a unique pattern of stripes! No two zebras are the same.", "gu": "શું તમે જાણો છો? આપણા ફિંગરપ્રિન્ટ્સની જેમ જ, દરેક ઝેબ્રા પાસે પટ્ટીઓની અનન્ય પેટર્ન હોય છે! કોઈ બે સરખા નથી હોતા.", "hi": "क्या आपको पता है? हमारी उंगलियों के निशान की तरह, हर ज़ेबरा की धारियों का पैटर्न अनोखा होता है! कोई दो ज़ेबरा एक जैसे नहीं होते।"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'leopard', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Leopard", "gu": "દીપડો", "hi": "तेंदुआ"}'::jsonb, 
  '/assets/images/animals/leopard.png', 
  '{"en": "Leopard! Leopard is a strong, graceful big cat with black rosette spots.", "gu": "દીપડો! દીપડો એ કાળા ગુલાબ જેવા ટપકાંવાળી મજબૂત અને ચપળ મોટી બિલાડી છે.", "hi": "तेंदुआ! तेंदुआ काले फूलों जैसे धब्बों वाली एक मजबूत और फुर्तीली बड़ी बिल्ली है।"}'::jsonb, 
  '{"en": "Leopards are amazing tree climbers. They are so strong they can carry heavy food high up into tree branches to keep it safe!", "gu": "દીપડાઓ ઝાડ પર ચઢવામાં હોશિયાર હોય છે. તેઓ એટલા મજબૂત હોય છે કે તેઓ ખોરાકને સુરક્ષિત રાખવા ઝાડની ડાળીઓ પર લઈ જઈ શકે છે!", "hi": "तेंदुए पेड़ों पर चढ़ने में माहिर होते हैं। वे इतने मजबूत होते हैं कि अपने शिकार को सुरक्षित रखने के लिए पेड़ों पर ले जा सकते हैं!"}'::jsonb, 
  '{"en": "Did you know? Leopards can see seven times better in the dark than humans can!", "gu": "શું તમે જાણો છો? દીપડા અંધારામાં માણસો કરતાં સાત ગણું વધુ સારું જોઈ શકે છે!", "hi": "क्या आपको पता है? तेंदुए अंधेरे में इंसानों की तुलना में सात गुना बेहतर देख सकते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'koala', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Koala", "gu": "કોઆલા", "hi": "कोआला"}'::jsonb, 
  '/assets/images/animals/koala.png', 
  '{"en": "Koala! Koalas are cute, fluffy animals that live in eucalyptus trees.", "gu": "કોઆલા! કોઆલા એ નીલગિરીના ઝાડ પર રહેતું સુંદર, રુંવાટીદાર પ્રાણી છે.", "hi": "कोआला! कोआला नीलगिरी के पेड़ों पर रहने वाले प्यारे, रोएँदार जानवर होते हैं।"}'::jsonb, 
  '{"en": "Koalas spend almost all their time in trees, munching on leaves. They sleep a lot to save energy, up to 20 hours a day!", "gu": "કોઆલા તેમનો મોટાભાગનો સમય ઝાડ પર પાંદડા ખાવામાં વિતાવે છે. તેઓ ઉર્જા બચાવવા દિવસમાં ૨૦ કલાક સુધી સુઈ રહે છે!", "hi": "कोआला अपना अधिकांश समय पेड़ों पर पत्ते खाने में बिताते हैं। वे ऊर्जा बचाने के लिए दिन में 20 घंटे तक सोते हैं!"}'::jsonb, 
  '{"en": "Did you know? Koalas have fingerprints that look almost exactly like human fingerprints!", "gu": "શું તમે જાણો છો? કોઆલાના ફિંગરપ્રિન્ટ્સ બિલકુલ માણસના ફિંગરપ્રિન્ટ્સ જેવા જ દેખાય છે!", "hi": "क्या आपको पता है? कोआला की उंगलियों के निशान काफी हद तक इंसानों की उंगलियों के निशान जैसे होते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'panda', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Giant Panda", "gu": "પાન્ડા", "hi": "पांडा"}'::jsonb, 
  '/assets/images/animals/panda.png', 
  '{"en": "Giant Panda! The giant panda is a lovable black and white bear that loves bamboo.", "gu": "પાન્ડા! પાન્ડા એ વાંસ ખાવાનું પસંદ કરતું સુંદર કાળું અને સફેદ રંગનું રીંછ છે.", "hi": "पांडा! पांडा बांस खाने वाला एक प्यारा सा काले और सफेद रंग का भालू है।"}'::jsonb, 
  '{"en": "Pandas live in cold mountain forests. They spend nearly half of their day eating crunchy bamboo leaves and stems!", "gu": "પાન્ડા ઠંડા પર્વતીય જંગલોમાં રહે છે. તેઓ દિવસનો અડધો ભાગ કડક વાંસના પાંદડા અને ડાળીઓ ખાવામાં વિતાવે છે!", "hi": "पांडा ठंडे पहाड़ी जंगलों में रहते हैं। वे अपने दिन का लगभग आधा हिस्सा बांस की पत्तियों और टहनियों को खाने में बिताते हैं!"}'::jsonb, 
  '{"en": "Did you know? A newborn baby panda is tiny—it is smaller than a stick of butter!", "gu": "શું તમે જાણો છો? નવજાત પાન્ડાનું બચ્ચું ઘણું નાનું હોય છે - બટરની એક ટીકડી કરતાં પણ નાનું!", "hi": "क्या आपको पता है? पांडा का नवजात बच्चा बहुत छोटा होता है - मक्खन की एक टिकिया से भी छोटा!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bear', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Brown Bear", "gu": "રીંછ", "hi": "भालू"}'::jsonb, 
  '/assets/images/animals/bear.png', 
  '{"en": "Brown Bear! Bears are large, furry mammals with big paws and short tails.", "gu": "રીંછ! રીંછ એ મોટા પંજા અને ટૂંકી પૂંછડીવાળા મોટા, રુંવાટીદાર સસ્તન પ્રાણી છે.", "hi": "भालू! भालू बड़े, रोएँदार स्तनधारी जीव होते हैं जिनके बड़े पंजे और छोटी पूँछ होती है।"}'::jsonb, 
  '{"en": "Bears love eating honey, berries, and fish. In winter, they build a cozy den and sleep all winter long!", "gu": "રીંછને મધ, બેરી અને માછલી ખાવાનું ખૂબ ગમે છે. શિયાળામાં, તેઓ એક આરામદાયક ગુફા બનાવે છે અને આખો શિયાળો સૂઈ જાય છે!", "hi": "भालुओं को शहद, जामुन और मछली खाना बहुत पसंद होता है। सर्दियों में, वे एक आरामदायक मांद बनाते हैं और पूरी सर्दी सोते हैं!"}'::jsonb, 
  '{"en": "Did you know? A bear has an amazing sense of smell, even better than a dog!", "gu": "શું તમે જાણો છો? રીંછની સૂંઘવાની શક્તિ અદ્ભુત હોય છે, કૂતરા કરતાં પણ વધુ સારી!", "hi": "क्या आपको पता है? एक भालू के सूंघने की क्षमता बहुत कमाल की होती है, यहाँ तक कि एक कुत्ते से भी बेहतर!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'jaguar', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Jaguar", "gu": "જગુઆર", "hi": "जगुआर"}'::jsonb, 
  '/assets/images/animals/jaguar.png', 
  '{"en": "Jaguar! The jaguar is a big, powerful cat that lives in green rainforests.", "gu": "જગુઆર! જગુઆર એ લીલા વર્ષા જંગલોમાં રહેતી એક મોટી અને શક્તિશાળી બિલાડી છે.", "hi": "जगुआर! जगुआर हरे-भरे वर्षावनों में रहने वाली एक बड़ी और शक्तिशाली बिल्ली है।"}'::jsonb, 
  '{"en": "Jaguars are excellent swimmers and hunters. They have beautiful spotted coats that help them hide in the forest shadow.", "gu": "જગુઆર ઉત્તમ તરણવીર અને શિકારી છે. તેમની પાસે સુંદર ટપકાંવાળી ચામડી હોય છે જે જંગલના છાયામાં છુપાવવામાં મદદ કરે છે.", "hi": "जगुआर उत्कृष्ट तैराक और शिकारी होते हैं। उनके शरीर पर सुंदर धब्बे होते हैं जो उन्हें जंगल की छांव में छिपने में मदद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Unlike many other cats, jaguars actually enjoy water and love swimming in rivers to hunt fish!", "gu": "શું તમે જાણો છો? અન્ય બિલાડીઓથી વિપરીત, જગુઆરને નદીઓમાં તરવું અને માછલીઓનો શિકાર કરવો ગમે છે!", "hi": "क्या आपको पता है? दूसरी बिल्लियों के विपरीत, जगुआर को पानी बहुत पसंद होता है और वे मछली का शिकार करने के लिए तैरते हैं!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'orangutan', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Orangutan", "gu": "ઓરેંગુટાન", "hi": "वनमानुष"}'::jsonb, 
  '/assets/images/animals/orangutan.png', 
  '{"en": "Orangutan! Orangutans are large apes with long arms and reddish-orange hair.", "gu": "ઓરેંગુટાન! ઓરેંગુટાન એ લાંબા હાથ અને લાલ-નારંગી વાળવાળા મોટા વાનર છે.", "hi": "वनमानुष! वनमानुष लंबे हाथ और लाल-नारंगी बालों वाले बड़े वानर होते हैं।"}'::jsonb, 
  '{"en": "Orangutans live high in tree branches. They build a fresh leaf nest to sleep in every single night!", "gu": "ઓરેંગુટાન ઊંચા ઝાડની ડાળીઓ પર રહે છે. તેઓ દરરોજ રાત્રે સૂવા માટે પાંદડાઓનો નવો માળો બનાવે છે!", "hi": "वनमानुष ऊंचे पेड़ों की शाखाओं पर रहते हैं। वे हर रात सोने के लिए ताजे पत्तों का एक नया घोंसला बनाते हैं।"}'::jsonb, 
  '{"en": "Did you know? Orangutan means ''person of the forest'' in the Malay language!", "gu": "શું તમે જાણો છો? મલય ભાષામાં ઓરેંગુટાનનો અર્થ ''જંગલનો માણસ'' થાય છે!", "hi": "क्या आपको पता है? मलय भाषा में वनमानुष (ऑरंगुटान) का अर्थ ''जंगल का आदमी'' होता है!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'fox', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Red Fox", "gu": "શિયાળ", "hi": "लोमड़ी"}'::jsonb, 
  '/assets/images/animals/fox.png', 
  '{"en": "Red Fox! The red fox is a clever little animal with a bushy tail.", "gu": "શિયાળ! શિયાળ એ ઝાડીદાર પૂંછડી ધરાવતું એક ચતુર નાનું પ્રાણી છે.", "hi": "लोमड़ी! लाल लोमड़ी झाड़ीदार पूंछ वाला एक चतुर छोटा जानवर है।"}'::jsonb, 
  '{"en": "Foxes live in underground dens. They have large ears that help them hear tiny bugs and mice moving in the grass!", "gu": "શિયાળ જમીનની અંદર રહે છે. તેમના મોટા કાન તેમને ઘાસમાં ફરતા નાના જીવજંતુઓ અને ઉંદરોનો અવાજ સાંભળવામાં મદદ કરે છે!", "hi": "लोमड़ी जमीन के नीचे मांद में रहती है। उनके बड़े कान उन्हें घास में चलने वाले छोटे कीड़े-मकौड़ों की आवाज़ सुनने में मदद करते हैं!"}'::jsonb, 
  '{"en": "Did you know? A fox uses its tail, called a brush, to stay warm in the winter and to send signals to other foxes!", "gu": "શું તમે જાણો છો? શિયાળ શિયાળામાં ગરમ રહેવા માટે અને અન્ય શિયાળોને સંકેત મોકલવા માટે તેની પૂંછડીનો ઉપયોગ કરે છે!", "hi": "क्या आपको पता है? लोमड़ी सर्दियों में गर्म रहने और दूसरी लोमड़ियों को संकेत भेजने के लिए अपनी पूंछ का उपयोग करती है!"}'::jsonb, 
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

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bull', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Bull", "gu": "આખલો", "hi": "सांड"}'::jsonb, 
  '/assets/images/animals/bull.png', 
  '{"en": "Bull! Bulls are male cattle known for their strength and curved horns.", "gu": "આખલો! આખલો એ તેમની શક્તિ અને વળાંકવાળા શિંગડા માટે જાણીતું નર પશુ છે.", "hi": "सांड! सांड अपनी ताकत और घुमावदार सींगों के लिए जाने जाने वाले नर मवेशी होते हैं।"}'::jsonb, 
  '{"en": "Bulls are very strong farm animals. They help carry heavy things and protect the herd of cows from danger.", "gu": "આખલા ખૂબ જ મજબૂત પ્રાણીઓ છે. તેઓ ભારે સામાન ઊંચકવામાં મદદ કરે છે અને ગાયોના ટોળાનું રક્ષણ કરે છે.", "hi": "सांड बहुत मजबूत जानवर होते हैं। वे भारी सामान उठाने में मदद करते हैं और गायों के झुंड की रक्षा करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Bulls cannot see the color red! They run at the matador''s cape because of its movement, not its color.", "gu": "શું તમે જાણો છો? આખલો લાલ રંગ જોઈ શકતો નથી! તેઓ કપડાના હલનચલનને કારણે તેની પાછળ દોડે છે, લાલ રંગને લીધે નહીં.", "hi": "क्या आपको पता है? सांड लाल रंग नहीं देख सकते! वे लाल कपड़े की हरकत के कारण उसकी तरफ दौड़ते हैं, न कि उसके रंग के कारण।"}'::jsonb, 
  'memory', 
  true, 
  23
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'giraffe', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Giraffe", "gu": "જિરાફ", "hi": "जिराफ़"}'::jsonb, 
  '/assets/images/animals/giraffe.png', 
  '{"en": "Giraffe! Giraffes are the tallest animals with super long necks and legs.", "gu": "જિરાફ! જિરાફ એ અત્યંત લાંબી ગરદન અને લાંબા પગ ધરાવતું સૌથી ઊંચું પ્રાણી છે.", "hi": "जिराफ़! जिराफ़ सबसे ऊंचे जानवर होते हैं जिनकी गर्दन और पैर बहुत लंबे होते हैं।"}'::jsonb, 
  '{"en": "Giraffes use their long necks to reach tasty green leaves high up in acacia trees where other animals cannot reach!", "gu": "જિરાફ ઊંચા ઝાડ પરથી પાંદડા ખાવા માટે તેમની લાંબી ગરદનનો ઉપયોગ કરે છે જ્યાં અન્ય પ્રાણીઓ પહોંચી શકતા નથી!", "hi": "जिराफ़ पेड़ों से पत्ते खाने के लिए अपनी लंबी गर्दन का उपयोग करते हैं जहाँ दूसरे जानवर नहीं पहुँच पाते!"}'::jsonb, 
  '{"en": "Did you know? Giraffes have blue-purple tongues that are so long they can use them to clean their own ears!", "gu": "શું તમે જાણો છો? જિરાફ પાસે લાંબી વાદળી-જાંબલી જીભ હોય છે, જેનો ઉપયોગ તેઓ પોતાના કાન સાફ કરવા કરી શકે છે!", "hi": "क्या आपको पता है? जिराफ़ की जीभ नीली-बैंगनी और इतनी लंबी होती है कि वे उससे अपने कान भी साफ कर सकते हैं!"}'::jsonb, 
  'memory', 
  true, 
  24
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'buffalo', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Buffalo", "gu": "ભેંસ", "hi": "भैंस"}'::jsonb, 
  '/assets/images/animals/buffalo.png', 
  '{"en": "Buffalo! The buffalo is a large domestic animal with big, curved horns.", "gu": "ભેંસ! ભેંસ એ મોટા, વળાંકવાળા શિંગડા ધરાવતું મોટું પાલતુ પ્રાણી છે.", "hi": "भैंस! भैंस बड़े और घुमावदार सींगों वाला एक बड़ा पालतू जानवर है।"}'::jsonb, 
  '{"en": "Buffaloes love swimming in rivers and mud. Mud protects their skin from heat and keeps bugs away.", "gu": "ભેંસને નદીઓમાં અને કાદવમાં તરવું ગમે છે. કાદવ તેમની ત્વચાને ગરમીથી બચાવે છે અને જંતુઓથી રક્ષણ આપે છે.", "hi": "भैंसों को नदियों और कीचड़ में तैरना बहुत पसंद होता है। कीचड़ उनकी त्वचा को गर्मी और कीड़ों से बचाता है।"}'::jsonb, 
  '{"en": "Did you know? Water buffaloes have been helping humans grow rice in wet muddy fields for thousands of years!", "gu": "શું તમે જાણો છો? જળ ભેંસ હજારો વર્ષોથી ખેડૂતોને કાદવ ભરેલા ખેતરોમાં ડાંગર (ચોખા) ઉગાડવામાં મદદ કરે છે!", "hi": "क्या आपको पता है? पानी वाली भैंसें हजारों सालों से दलदली खेतों में धान उगाने में इंसानों की मदद कर रही हैं!"}'::jsonb, 
  'memory', 
  true, 
  25
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'kangaroo', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Kangaroo", "gu": "કાંગારુ", "hi": "कंगारू"}'::jsonb, 
  '/assets/images/animals/kangaroo.png', 
  '{"en": "Kangaroo! Kangaroos are bouncy animals with big back legs and a cozy pocket.", "gu": "કાંગારુ! કાંગારુ એ પાછળના મોટા પગ અને કૂદકા મારતું સુંદર કોથળીવાળું પ્રાણી છે.", "hi": "कंगारू! कंगारू बड़े पिछले पैरों और एक आरामदायक थैली वाले कूदने वाले जानवर होते हैं।"}'::jsonb, 
  '{"en": "Kangaroos jump around instead of walking. A mother kangaroo keeps her cute baby, called a joey, inside her pouch to keep it safe.", "gu": "કાંગારુ ચાલવાને બદલે કૂદકો મારે છે. માતા કાંગારુ તેના બચ્ચાને (જોય) સુરક્ષિત રાખવા માટે પેટ પરની કોથળીમાં રાખે છે.", "hi": "कंगारू चलने के बजाय कूदते हैं। मादा कंगारू अपने बच्चे को सुरक्षित रखने के लिए अपने पेट की थैली में रखती है।"}'::jsonb, 
  '{"en": "Did you know? Kangaroos use their big, strong tail like a third leg to help them balance when jumping!", "gu": "શું તમે જાણો છો? કાંગારુ કૂદતી વખતે સંતુલન જાળવવા માટે તેમની મોટી, મજબૂત પૂંછડીનો ત્રીજા પગની જેમ ઉપયોગ કરે છે!", "hi": "क्या आपको पता है? कंगारू कूदते समय संतुलन बनाए रखने के लिए अपनी बड़ी पूंछ का उपयोग तीसरे पैर की तरह करते हैं!"}'::jsonb, 
  'memory', 
  true, 
  26
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'deer', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Deer", "gu": "હરણ", "hi": "हिरण"}'::jsonb, 
  '/assets/images/animals/deer.png', 
  '{"en": "Deer! Deer are gentle, quiet animals that run very fast through the forest.", "gu": "હરણ! હરણ એ જંગલમાં ખૂબ જ ઝડપથી દોડતું નમ્ર, શાંત પ્રાણી છે.", "hi": "हिरण! हिरण शांत और कोमल जानवर होते हैं जो जंगल में बहुत तेज़ दौड़ते हैं।"}'::jsonb, 
  '{"en": "Deer eat plants, leaves, and berries. Male deer grow beautiful, branch-like horns on their heads called antlers!", "gu": "હરણ પાંદડા અને બેરી ખાય છે. નર હરણના માથા પર સુંદર, ડાળીઓ જેવા શિંગડા (એન્ટલર્સ) ઉગે છે!", "hi": "हिरण पौधे और पत्तियां खाते हैं। नर हिरण के सिर पर शाखाओं जैसे सुंदर सींग उगते हैं!"}'::jsonb, 
  '{"en": "Did you know? Baby deer, called fawns, have white spots on their coats that help them hide in the forest light!", "gu": "શું તમે જાણો છો? હરણના નાના બચ્ચા પર સફેદ ટપકાં હોય છે જે તેમને જંગલના પ્રકાશ-છાયામાં છુપાવવામાં મદદ કરે છે!", "hi": "क्या आपको पता है? हिरण के छोटे बच्चों के शरीर पर सफेद धब्बे होते हैं जो उन्हें जंगल में छिपने में मदद करते हैं!"}'::jsonb, 
  'memory', 
  true, 
  27
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'horse', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Horse", "gu": "ઘોડો", "hi": "घोड़ा"}'::jsonb, 
  '/assets/images/animals/horse.png', 
  '{"en": "Horse! Horses are beautiful, strong animals with long manes and tails.", "gu": "ઘોડો! ઘોડો એ લાંબી કેશવાળી અને પૂંછડી ધરાવતું સુંદર, મજબૂત પ્રાણી છે.", "hi": "घोड़ा! घोड़ा सुंदर अयाल और पूंछ वाला एक बहुत ही मजबूत और सुंदर जानवर है।"}'::jsonb, 
  '{"en": "Horses love running fast in open fields. They help humans by carrying riders and pulling carts on farms.", "gu": "ઘોડાઓને ખુલ્લા મેદાનોમાં ઝડપથી દોડવું ગમે છે. તેઓ માણસોને સવારી કરાવવામાં અને ગાડા ખેંચવામાં મદદ કરે છે.", "hi": "घोड़ों को खुले मैदानों में दौड़ना बहुत पसंद होता है। वे इंसानों की सवारी करने और गाड़ी खींचने में मदद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Horses can sleep both lying down and standing up! They have locked legs to stay standing.", "gu": "શું તમે જાણો છો? ઘોડા સૂતા-સૂતા અને ઉભા-ઉભા બંને રીતે સૂઈ શકે છે! તેમના પગ ઉભા રહેવા માટે લોક થઈ જાય છે.", "hi": "क्या आपको पता है? घोड़े लेटकर और खड़े होकर दोनों तरह से सो सकते हैं! उनके पैरों में एक विशेष लॉक सिस्टम होता है।"}'::jsonb, 
  'memory', 
  true, 
  28
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'bison', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Bison", "gu": "બાયસન", "hi": "बाइसन"}'::jsonb, 
  '/assets/images/animals/bison.png', 
  '{"en": "Bison! The bison is a very large, powerful animal with shaggy brown fur.", "gu": "બાયસન! બાયસન એ રુંવાટીદાર કથ્થઈ રંગની રૂંવાટી ધરાવતું ખૂબ જ મોટું અને શક્તિશાળી પ્રાણી છે.", "hi": "बाइसन! बाइसन घने भूरे बालों वाला एक बहुत बड़ा और शक्तिशाली जानवर है।"}'::jsonb, 
  '{"en": "Bison love roaming across open grassy plains in big herds, munching on grass all day.", "gu": "બાયસન મોટા ટોળામાં ખુલ્લા ઘાસના મેદાનોમાં ફરવું અને આખો દિવસ ઘાસ ખાવું પસંદ કરે છે.", "hi": "बाइसन बड़े झुंडों में खुले घास के मैदानों में घूमना और दिन भर घास चरना पसंद करते हैं।"}'::jsonb, 
  '{"en": "Did you know? Bison can run very fast! They can run up to 35 miles per hour, which is faster than a horse!", "gu": "શું તમે જાણો છો? બાયસન ખૂબ ઝડપથી દોડી શકે છે! તેઓ કલાકના ૩૫ માઈલની ઝડપે દોડી શકે છે, જે ઘોડા કરતાં પણ વધુ ઝડપી છે!", "hi": "क्या आपको पता है? बाइसन बहुत तेज़ दौड़ सकते हैं! वे 35 मील प्रति घंटे की रफ्तार से दौड़ सकते हैं, जो घोड़े से भी तेज़ है!"}'::jsonb, 
  'memory', 
  true, 
  29
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

INSERT INTO public.animals 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'camel', 
  (SELECT id FROM categories WHERE category_key = 'animals' LIMIT 1), 
  '{"en": "Camel", "gu": "ઊંટ", "hi": "ऊंट"}'::jsonb, 
  '/assets/images/animals/camel.png', 
  '{"en": "Camel! Camels are strong animals with humps that live in hot deserts.", "gu": "ઊંટ! ઊંટ એ ગરમ રણપ્રદેશમાં રહેતું ખૂંધવાળું મજબૂત પ્રાણી છે.", "hi": "ऊंट! ऊंट गर्म रेगिस्तान में रहने वाला कूबड़ वाला एक बहुत ही मजबूत जानवर है।"}'::jsonb, 
  '{"en": "Camels carry riders and bags across the desert. They can walk on hot sand easily because of their wide, padded feet.", "gu": "ઊંટ રણમાં મુસાફરો અને સામાન લઈ જાય છે. તેઓ તેમના ગાદીવાળા પગને લીધે ગરમ રેતી પર સરળતાથી ચાલી શકે છે.", "hi": "ऊंट रेगिस्तान में सामान और सवारी ले जाने के काम आते हैं। वे अपने गद्दीदार पैरों के कारण गर्म रेत पर आसानी से चल सकते हैं।"}'::jsonb, 
  '{"en": "Did you know? A camel''s hump does not store water—it stores fat, which gives them energy when food is hard to find!", "gu": "શું તમે જાણો છો? ઊંટની ખૂંધમાં પાણી નહીં પણ ચરબી સંગ્રહિત હોય છે, જે ખોરાક ન મળવા પર ઉર્જા આપે છે!", "hi": "क्या आपको पता है? ऊंत का कूबड़ पानी नहीं बल्कि वसा (फैट) जमा करता है, जो भोजन न मिलने पर उन्हें ऊर्जा देता है!"}'::jsonb, 
  'memory', 
  true, 
  30
)
ON CONFLICT (topic_key) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  image_path = EXCLUDED.image_path,
  narration = EXCLUDED.narration,
  explanation = EXCLUDED.explanation,
  fact = EXCLUDED.fact,
  display_order = EXCLUDED.display_order;

