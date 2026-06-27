-- 1. Create months table and index

CREATE TABLE IF NOT EXISTS public.months (
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
  constraint months_pkey primary key (id),
  constraint months_topic_key_key unique (topic_key),
  constraint months_category_id_fkey foreign KEY (category_id) references categories (id) on delete CASCADE
) TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS idx_months_topic_key on public.months using btree (topic_key) TABLESPACE pg_default;

ALTER TABLE public.months DISABLE ROW LEVEL SECURITY;

GRANT ALL ON public.months TO anon;
GRANT ALL ON public.months TO authenticated;
GRANT ALL ON public.months TO service_role;


-- 2. Populate months table with 12 months data

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'january', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "January", "gu": "જાન્યુઆરી", "hi": "जनवरी"}'::jsonb, 
  'assets/images/months/january.png', 
  '{"en": "January! January is the first month of the year, bringing cold and snow.", "gu": "જાન્યુઆરી! જાન્યુઆરી વર્ષનો પહેલો મહિનો છે, જે ઠંડી અને બરફ લાવે છે.", "hi": "जनवरी! जनवरी साल का पहला महीना होता है, जो ठंड और बर्फ लेकर आता है।"}'::jsonb, 
  '{"en": "In January, the weather is very cold in many places. People wear warm coats, gloves, and build cute snowmen!", "gu": "જાન્યુઆરીમાં ઘણી જગ્યાએ ખૂબ જ ઠંડી હોય છે. લોકો ગરમ કોટ અને મોજાં પહેરે છે અને સુંદર સ્નોમેન બનાવે છે!", "hi": "जनवरी में कई जगहों पर मौसम बहुत ठंडा होता. लोग गर्म कोट, दस्ताने पहनते हैं और प्यारे स्नोमैन बनाते हैं!"}'::jsonb, 
  '{"en": "Did you know? January is named after Janus, the Roman god of doors and beginnings, because it starts the new year!", "gu": "શું તમે જાણો છો? જાન્યુઆરીનું નામ રોમન દેવ જાનુસ પરથી પડ્યું છે, જે દરવાજા અને શરૂઆતના દેવ ગણાય છે, કારણ કે આ મહિનો નવું વર્ષ શરૂ કરે છે!", "hi": "क्या आपको पता है? जनवरी का नाम रोमन देवता जानूस के नाम पर रखा गया है, जिन्हें शुरुआत का देवता माना जाता है, क्योंकि यह महीना नए साल की शुरुआत करता है!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'february', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "February", "gu": "ફેબ્રુઆરી", "hi": "फ़रवरी"}'::jsonb, 
  'assets/images/months/february.png', 
  '{"en": "February! February is the shortest month of the year, full of love.", "gu": "ફેબ્રુઆરી! ફેબ્રુઆરી વર્ષનો સૌથી ટૂંકો મહિનો છે, જે પ્રેમથી ભરેલો હોય છે.", "hi": "फ़रवरी! फ़रवरी साल का सबसे छोटा महीना होता है, जो प्यार और स्नेह से भरा होता है।"}'::jsonb, 
  '{"en": "February is a cozy winter month. People share cards, flowers, and chocolates with friends and family for Valentine''s Day!", "gu": "ફેબ્રુઆરી એ શિયાળાનો એક મધુર મહિનો છે. લોકો વેલેન્ટાઇન ડે પર મિત્રો અને પરિવાર સાથે કાર્ડ્સ, ફૂલો અને ચોકલેટ શેર કરે છે!", "hi": "फ़रवरी सर्दियों का एक प्यारा महीना है। लोग वैलेंटाइन डे पर दोस्तों और परिवार के साथ कार्ड, फूल और चॉकलेट साझा करते हैं!"}'::jsonb, 
  '{"en": "Did you know? February is the only month that has 28 days normally, and 29 days in a Leap Year every four years!", "gu": "શું તમે જાણો છો? ફેબ્રુઆરી એકમાત્ર એવો મહિનો છે જેમાં સામાન્ય રીતે ૨૮ દિવસ હોય છે, અને દર ચાર વર્ષે લીપ યરમાં ૨૯ દિવસ હોય છે!", "hi": "क्या आपको पता है? फ़रवरी ही एकमात्र ऐसा महीना है जिसमें सामान्य रूप से 28 दिन होते हैं, और लीप वर्ष में हर चार साल में 29 दिन होते हैं!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'march', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "March", "gu": "માર્ચ", "hi": "मार्च"}'::jsonb, 
  'assets/images/months/march.png', 
  '{"en": "March! March brings the windy spring and beautiful flying kites.", "gu": "માર્ચ! માર્ચ પવનવાળી વસંત અને આકાશમાં ઉડતા પતંગો લાવે છે.", "hi": "मार्च! मार्च का महीना हवादार वसंत और आसमान में उड़ते पतंगों को लेकर आता है।"}'::jsonb, 
  '{"en": "In March, the winter cold starts to go away. Windy days make it the perfect time to go outside and fly colorful kites!", "gu": "માર્ચમાં શિયાળાની ઠંડી ઓછી થવા લાગે છે. પવનવાળા દિવસો હોવાથી બહાર જઈને રંગબેરંગી પતંગો ઉડાડવાનો આ શ્રેષ્ઠ સમય છે!", "hi": "मार्च में सर्दियों की ठंड कम होने लगती है। हवादार दिन होने के कारण बाहर जाने और रंग-बिरंगे पतंग उड़ाने का यह सबसे सही समय है!"}'::jsonb, 
  '{"en": "Did you know? March is named after Mars, the Roman god of war, because it was the time when people started outdoor activities again!", "gu": "શું તમે જાણો છો? માર્ચનું નામ રોમન યુદ્ધના દેવ માર્સ પરથી પડ્યું છે, કારણ કે આ એ સમય હતો જ્યારે લોકો ફરીથી બહારની પ્રવૃત્તિઓ શરૂ કરતા હતા!", "hi": "क्या आपको पता है? मार्च का नाम युद्ध के रोमन देवता मार्स के नाम पर रखा गया है, क्योंकि इस समय लोग फिर से बाहर की गतिविधियां शुरू करते थे!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'april', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "April", "gu": "એપ્રિલ", "hi": "अप्रैल"}'::jsonb, 
  'assets/images/months/april.png', 
  '{"en": "April! April showers bring rainy days and colorful umbrellas.", "gu": "એપ્રિલ! એપ્રિલના વરસાદી ઝાપટાં ભીના દિવસો અને રંગબેરંગી છત્રીઓ લાવે છે.", "hi": "अप्रैल! अप्रैल की बौछारें बारिश के दिन और रंग-बिरंगी छतरियां लेकर आती हैं।"}'::jsonb, 
  '{"en": "April has plenty of refreshing rain showers. Grab your colorful umbrella and wear your rainboots to splash in the puddles!", "gu": "એપ્રિલમાં તાજગી આપતા વરસાદી ઝાપટાં પડે છે. તમારી રંગબેરંગી છત્રી લો અને પાણીના ખાબોચિયામાં કૂદવા માટે રેઈનબૂટ પહેરો!", "hi": "April में ताजगी देने वाली बारिश होती है। अपनी रंग-बिरंगी छतरी लें और पानी के गड्ढों में छप-छप करने के लिए रेनबूट पहनें!"}'::jsonb, 
  '{"en": "Did you know? April showers help the soil wake up, which brings lots of beautiful flowers in the next month!", "gu": "શું તમે જાણો છો? એપ્રિલનો વરસાદ માટીને જગાડવામાં મદદ કરે છે, જેનાથી આગામી મહિનામાં ઘણા બધા સુંદર ફૂલો ખીલે છે!", "hi": "क्या आपको पता है? अप्रैल की बारिश मिट्टी को उपजाऊ बनाती है, जिससे अगले महीने में बहुत सारे सुंदर फूल खिलते हैं!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'may', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "May", "gu": "મે", "hi": "मई"}'::jsonb, 
  'assets/images/months/may.png', 
  '{"en": "May! May is a sunny month when flowers bloom all around.", "gu": "મે! મે એ તડકાવાળો મહિનો છે જ્યારે ચારેય બાજુ સુંદર ફૂલો ખીલે છે.", "hi": "मई! मई धूप वाला महीना होता है जब चारों तरफ सुंदर फूल खिलते हैं।"}'::jsonb, 
  '{"en": "In May, the weather is warm and beautiful. Gardens are filled with colorful blooming flowers, green leaves, and busy bees!", "gu": "મે મહિનામાં હવામાન ગરમ અને સુંદર હોય છે. બગીચાઓ રંગબેરંગી ખીલેલા ફૂલો, લીલા પાંદડા અને ગુંજન કરતી મધમાખીઓથી ભરાઈ જાય છે!", "hi": "मई में मौसम गर्म और सुहावना होता है। बगीचे रंग-बिरंगे खिले हुए फूलों, हरी पत्तियों और गुनगुनाती मधुमक्खियों से भर जाते हैं!"}'::jsonb, 
  '{"en": "Did you know? May is named after Maia, the Greek goddess of growth and spring, who looks after plants!", "gu": "શું તમે જાણો છો? મે મહિનાનું નામ ગ્રીક દેવી માયા પરથી રાખવામાં આવ્યું છે, જે વસંત અને વિકાસની દેવી ગણાય છે અને છોડની સંભાળ રાખે છે!", "hi": "क्या आपको पता है? मई का नाम ग्रीक देवी माया के नाम पर रखा गया है, जिन्हें विकास और वसंत की देवी माना जाता है!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'june', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "June", "gu": "જૂન", "hi": "जून"}'::jsonb, 
  'assets/images/months/june.png', 
  '{"en": "June! June is the start of hot summer and yummy ice cream cones.", "gu": "જૂન! જૂન એ ગરમ ઉનાળાની શરૂઆત અને સ્વાદિષ્ટ આઈસક્રીમનો મહિનો છે.", "hi": "जून! जून गर्म गर्मियों की शुरुआत और स्वादिष्ट आइसक्रीम कोन का महीना है।"}'::jsonb, 
  '{"en": "June brings sunny summer days and school holidays! It is the perfect time to swim, play outside, and eat cold, sweet ice cream!", "gu": "જૂન તેના સૂર્યપ્રકાશવાળા દિવસો અને શાળાના વેકેશન લાવે છે! આ સ્વિમિંગ કરવાનો, બહાર રમવાનો અને ઠંડો, મીઠો આઈસક્રીમ ખાવાનો શ્રેષ્ઠ સમય છે!", "hi": "जून अपने धूप वाले दिनों और स्कूल की छुट्टियों को लेकर आता है! यह तैरने, बाहर खेलने और ठंडी, मीठी आइसक्रीम खाने का सबसे अच्छा समय है!"}'::jsonb, 
  '{"en": "Did you know? June has the longest day of the whole year, called the Summer Solstice, giving us extra time to play!", "gu": "શું તમે જાણો છો? જૂન મહિનામાં આખા વર્ષનો સૌથી લાંબો દિવસ હોય છે, જેને સમર સોલસ્ટિસ કહેવાય છે, જે આપણને રમવા માટે વધારાનો સમય આપે છે!", "hi": "क्या आपको पता है? जून में पूरे साल का सबसे लंबा दिन होता है, जिसे समर सोल्सटिस कहा जाता है, जो हमें खेलने के लिए अतिरिक्त समय देता है!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'july', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "July", "gu": "જુલાઈ", "hi": "जुलाई"}'::jsonb, 
  'assets/images/months/july.png', 
  '{"en": "July! July brings hot sunny days and sweet, juicy watermelons.", "gu": "જુલાઈ! જુલાઈ ગરમ તડકાવાળા દિવસો અને મીઠા, રસદાર તડબૂચ લાવે છે.", "hi": "जुलाई! जुलाई गर्म धूप वाले दिन और मीठे, रसीले तरबूज लेकर आता है।"}'::jsonb, 
  '{"en": "July is a great month for summer adventures! Families go on picnics and enjoy eating cold slices of sweet, refreshing red watermelons!", "gu": "જુલાઈ એ ઉનાળાના સાહસો માટે ઉત્તમ મહિનો છે! પરિવારો પિકનિક પર જાય છે અને મીઠા, તાજગી આપતા લાલ તડબૂચ ખાવાની મજા માણે છે!", "hi": "जुलाई गर्मियों के कारनामों के लिए एक बेहतरीन महीना है! परिवार पिकनिक पर जाते हैं और मीठे, ताज़ा लाल तरबूज़ खाने का मज़ा लेते हैं!"}'::jsonb, 
  '{"en": "Did you know? Watermelons are 92 percent water, which makes them perfect for staying cool and hydrated in July!", "gu": "શું તમે જાણો છો? તડબૂચમાં ૯૨ ટકા પાણી હોય છે, જે જુલાઈની ગરમીમાં આપણને ઠંડક અને હાઇડ્રેટેડ રાખવા માટે શ્રેષ્ઠ બનાવે છે!", "hi": "क्या आपको पता है? तरबूज में 92 प्रतिशत पानी होता है, जो जुलाई की गर्मी में हमें ठंडा और तरोताजा रखने के लिए सबसे बढ़िया है!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'august', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "August", "gu": "ઓગસ્ટ", "hi": "अगस्त"}'::jsonb, 
  'assets/images/months/august.png', 
  '{"en": "August! August is a beach month, perfect for building sandcastles.", "gu": "ઓગસ્ટ! ઓગસ્ટ એ દરિયાકિનારાનો મહિનો છે, જે રેતીના સુંદર કિલ્લા બનાવવા માટે ઉત્તમ છે.", "hi": "अगस्त! अगस्त समुद्र तट का महीना है, जो रेत के महल बनाने के लिए सबसे अच्छा है।"}'::jsonb, 
  '{"en": "August is the last month of summer holidays. Many people visit the sandy beaches, search for seashells, and build big sandcastles!", "gu": "ઓગસ્ટ એ ઉનાળાના વેકેશનનો છેલ્લો મહિનો છે. ઘણા લોકો રેતાળ દરિયાકાંઠે જાય છે, છીપલાં શોધે છે અને રેતીના મોટા કિલ્લા બનાવે છે!", "hi": "अगस्त गर्मियों की छुट्टियों का आखिरी महीना है। बहुत से लोग रेतीले समुद्र तटों पर जाते हैं, सीपियाँ ढूँढ़ते हैं और रेत के बड़े महल बनाते हैं!"}'::jsonb, 
  '{"en": "Did you know? August is named after Augustus Caesar, the first emperor of Rome, who wanted his own month to be special!", "gu": "શું તમે જાણો છો? ઓગસ્ટનું નામ રોમના પ્રથમ સમ્રાટ ઓગસ્ટસ સીઝર પરથી રાખવામાં આવ્યું છે, જેઓ પોતાના નામના મહિનાને વિશેષ બનાવવા માંગતા હતા!", "hi": "क्या आपको पता है? अगस्त का नाम रोम के पहले सम्राट ऑगस्टस सीज़र के नाम पर रखा गया है, जो अपने नाम के महीने को विशेष बनाना चाहते थे!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'september', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "September", "gu": "સપ્ટેમ્બર", "hi": "सितंबर"}'::jsonb, 
  'assets/images/months/september.png', 
  '{"en": "September! September is back-to-school time with yellow school buses.", "gu": "સપ્ટેમ્બર! સપ્ટેમ્બર એ પીળી સ્કૂલ બસો સાથે શાળાએ પાછા જવાનો સમય છે.", "hi": "सितंबर! सितंबर पीली स्कूल बसों के साथ वापस स्कूल जाने का समय है।"}'::jsonb, 
  '{"en": "In September, autumn begins. Children put on their backpacks and ride the yellow school bus to meet their teachers and friends!", "gu": "સપ્ટેમ્બરમાં પાનખરની શરૂઆત થાય છે. બાળકો પીઠ પર બેગ ભરાવીને શિક્ષકો અને મિત્રોને મળવા માટે પીળી સ્કૂલ બસમાં બેસીને જાય છે!", "hi": "सितंबर में पतझड़ की शुरुआत होती है। बच्चे अपनी पीठ पर बस्ता टांगते हैं और शिक्षकों और दोस्तों से मिलने के लिए पीली स्कूल बस में जाते हैं!"}'::jsonb, 
  '{"en": "Did you know? September comes from the Latin word ''septem'', which means seven, because it was the seventh month in the old calendar!", "gu": "શું તમે જાણો છો? સપ્ટેમ્બર લેટિન શબ્દ ''સેપ્ટેમ'' પરથી આવ્યો છે જેનો અર્થ સાત થાય છે, કારણ કે તે જૂના કેલેન્ડરમાં સાતમો મહિનો હતો!", "hi": "क्या आपको पता है? सितंबर लैटिन शब्द ''सेप्टम'' से आया है जिसका अर्थ सात है, क्योंकि पुराने कैलेंडर में यह सातवां महीना था!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'october', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "October", "gu": "ઓક્ટોબર", "hi": "अक्टूबर"}'::jsonb, 
  'assets/images/months/october.png', 
  '{"en": "October! October brings orange pumpkins and autumn harvest.", "gu": "ઓક્ટોબર! ઓક્ટોબર નારંગી કોળા અને પાનખરની લણણી લાવે છે.", "hi": "अक्टूबर! अक्टूबर नारंगी कद्दू और पतझड़ की फसल लेकर आता है।"}'::jsonb, 
  '{"en": "October is full of falling leaves. The farms are ready with big orange pumpkins! We carve them, paint them, and make tasty pumpkin pies!", "gu": "ઓક્ટોબરમાં ઝાડના પાંદડા ખરવા લાગે છે. ખેતરો નારંગી કોળાથી ભરાઈ જાય છે! આપણે તેને સજાવીએ છીએ અને સ્વાદિષ્ટ કોળાની વાનગીઓ બનાવીએ છીએ!", "hi": "अक्टूबर में पेड़ों की पत्तियां गिरने लगती हैं। खेत नारंगी कद्दू से भर जाते हैं! हम उन्हें सजाते हैं और स्वादिष्ट कद्दू के व्यंजन बनाते हैं!"}'::jsonb, 
  '{"en": "Did you know? Pumpkins are actually fruits, not vegetables, and they grow on long vines along the ground!", "gu": "શું તમે જાણો છો? કોળા ખરેખર ફળ છે, શાકભાજી નથી, અને તે જમીન પર લાંબી વેલાઓ પર ઉગે છે!", "hi": "क्या आपको पता है? कद्दू वास्तव में फल हैं, सब्जियां नहीं, और वे जमीन पर लंबी लताओं पर उगते हैं!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'november', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "November", "gu": "નવેમ્બર", "hi": "नवंबर"}'::jsonb, 
  'assets/images/months/november.png', 
  '{"en": "November! November is a cozy month with beautiful falling leaves.", "gu": "નવેમ્બર! નવેમ્બર એ સુંદર ખરતા પાંદડાઓ સાથેનો આરામદાયક મહિનો છે.", "hi": "नवंबर! नवंबर सुंदर गिरती पत्तियों के साथ एक आरामदायक महीना है।"}'::jsonb, 
  '{"en": "In November, the weather gets cooler. Trees drop their golden and brown leaves, creating a colorful carpet to jump and play in!", "gu": "નવેમ્બરમાં હવામાન વધુ ઠંડુ થાય છે. વૃક્ષો તેમના સોનેરી અને કથ્થઈ પાંદડા ખેરવે છે, જેનાથી રમવા માટે એક સુંદર ચાદર બની જાય છે!", "hi": "नवंबर में मौसम अधिक ठंडा हो जाता है। पेड़ अपनी सुनहरी और भूरी पत्तियां गिराते हैं, जिससे खेलने के लिए एक सुंदर चादर बन जाती है!"}'::jsonb, 
  '{"en": "Did you know? The name November comes from ''novem'', which means nine in Latin, because it was the ninth month long ago!", "gu": "શું તમે જાણો છો? નવેમ્બર નામ લેટિનના ''નોવેમ'' શબ્દ પરથી આવ્યું છે જેનો અર્થ નવ થાય છે, કારણ કે તે પહેલાં નવમો મહિનો હતો!", "hi": "क्या आपको पता है? नवंबर नाम लैटिन के ''नोवेम'' शब्द से आया है जिसका अर्थ नौ है, क्योंकि पहले यह नौवां महीना था!"}'::jsonb, 
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

INSERT INTO public.months 
(topic_key, category_id, name, image_path, narration, explanation, fact, game_type, is_free, display_order)
VALUES (
  'december', 
  (SELECT id FROM categories WHERE category_key = 'months' LIMIT 1), 
  '{"en": "December", "gu": "ડિસેમ્બર", "hi": "दिसंबर"}'::jsonb, 
  'assets/images/months/december.png', 
  '{"en": "December! December brings winter holidays and decorated green pine trees.", "gu": "ડિસેમ્બર! ડિસેમ્બર શિયાળાની રજાઓ અને શણગારેલા લીલા પાઈન વૃક્ષો લાવે છે.", "hi": "दिसंबर! दिसंबर सर्दियों की छुट्टियां और सजाए गए हरे पाइन के पेड़ लेकर आता है।"}'::jsonb, 
  '{"en": "December is the last month of the year, full of lights and joy! People decorate pine trees with stars, balls, and wait for gifts!", "gu": "ડિસેમ્બર વર્ષનો છેલ્લો મહિનો છે, જે પ્રકાશ અને આનંદથી ભરેલો હોય છે! લોકો પાઈન વૃક્ષને તારાઓથી શણગારે છે અને ભેટોની રાહ જુએ છે!", "hi": "दिसंबर साल का आखिरी महीना है, जो रोशनी और खुशियों से भरा होता है! लोग पाइन के पेड़ों को सितारों से सजाते हैं और उपहारों का इंतजार करते हैं!"}'::jsonb, 
  '{"en": "Did you know? December has the shortest day and longest night of the year in the North, called the Winter Solstice!", "gu": "શું તમે જાણો છો? ડિસેમ્બરમાં ઉત્તરી ગોળાર્ધમાં વર્ષનો સૌથી ટૂંકો દિવસ અને સૌથી લાંબી રાત હોય છે, જેને વિન્ટર સોલસ્ટિસ કહેવાય છે!", "hi": "क्या आपको पता है? दिसंबर में साल का सबसे छोटा दिन और सबसे लंबी रात होती है, जिसे विंटर सोल्सटिस कहा जाता है!"}'::jsonb, 
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